package com.mobile.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet("/upload/*")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 5, // 5MB
        maxRequestSize = 1024 * 1024 * 10 // 10MB
)
public class UploadController extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";
    private static final String[] ALLOWED_EXTENSIONS = { ".jpg", ".jpeg", ".png", ".gif", ".webp" };

    @Override
    public void init() throws ServletException {
        // Tạo thư mục uploads nếu chưa tồn tại
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        if ("/image".equals(pathInfo)) {
            handleImageUpload(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleImageUpload(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            List<String> uploadedUrls = new ArrayList<>();

            // Lấy tất cả các file được upload
            for (Part part : request.getParts()) {
                if ("images".equals(part.getName()) && part.getSize() > 0) {
                    String fileName = getSubmittedFileName(part);

                    // Kiểm tra extension
                    if (!isValidImageFile(fileName)) {
                        continue;
                    }

                    // Tạo tên file mới với UUID
                    String fileExtension = getFileExtension(fileName);
                    String newFileName = UUID.randomUUID().toString() + fileExtension;

                    // Lưu file vào webapp uploads directory
                    String uploadPath = getServletContext().getRealPath("/uploads/");
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    String filePath = uploadPath + newFileName;

                    // Save file to uploads directory
                    try (java.io.InputStream input = part.getInputStream();
                            java.io.FileOutputStream output = new java.io.FileOutputStream(filePath)) {
                        byte[] buffer = new byte[1024];
                        int length;
                        while ((length = input.read(buffer)) > 0) {
                            output.write(buffer, 0, length);
                        }
                    }

                    // Tạo URL để truy cập
                    String contextPath = request.getContextPath();
                    String imageUrl = contextPath + "/" + UPLOAD_DIR + "/" + newFileName;
                    uploadedUrls.add(imageUrl);
                }
            }

            // Trả về JSON response
            if (!uploadedUrls.isEmpty()) {
                out.println("{\"success\": true, \"urls\": " +
                        uploadedUrls.toString().replace("[", "[\"").replace("]", "\"]").replace(", ", "\", \"") +
                        ", \"message\": \"Upload thành công\"}");
            } else {
                out.println("{\"success\": false, \"message\": \"Không có file nào được upload\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("{\"success\": false, \"message\": \"Lỗi: " + e.getMessage() + "\"}");
        }
    }

    private String getSubmittedFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }

    private boolean isValidImageFile(String fileName) {
        if (fileName == null || fileName.isEmpty()) {
            return false;
        }

        String extension = getFileExtension(fileName).toLowerCase();
        for (String allowedExt : ALLOWED_EXTENSIONS) {
            if (allowedExt.equals(extension)) {
                return true;
            }
        }
        return false;
    }

    private String getFileExtension(String fileName) {
        int lastDotIndex = fileName.lastIndexOf(".");
        if (lastDotIndex > 0) {
            return fileName.substring(lastDotIndex);
        }
        return "";
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }
}