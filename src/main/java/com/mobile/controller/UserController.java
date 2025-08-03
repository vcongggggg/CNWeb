package com.mobile.controller;

import com.mobile.bo.UserBO;
import com.mobile.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/*")
public class UserController extends HttpServlet {
    private UserBO userBO;
    
    @Override
    public void init() throws ServletException {
        userBO = new UserBO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo.equals("/login")) {
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else if (pathInfo.equals("/register")) {
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        } else if (pathInfo.equals("/logout")) {
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/");
        } else if (pathInfo.equals("/profile")) {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("/user-profile.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/user/login");
            }
        } else if (pathInfo.equals("/admin/users")) {
            // Redirect to AdminController
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo.equals("/login")) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            
            User user = userBO.login(username, password);
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                
                // Redirect admin to dashboard, customer to home page
                if ("admin".equals(user.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                } else {
                    response.sendRedirect(request.getContextPath() + "/");
                }
            } else {
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } else if (pathInfo.equals("/register")) {
            User user = new User();
            user.setUsername(request.getParameter("username"));
            user.setPassword(request.getParameter("password"));
            user.setEmail(request.getParameter("email"));
            user.setFullName(request.getParameter("fullName"));
            user.setPhone(request.getParameter("phone"));
            user.setAddress(request.getParameter("address"));
            
            boolean success = userBO.register(user);
            if (success) {
                request.setAttribute("message", "Registration successful! Please login.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Registration failed. Please try again.");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
            }
        } else if (pathInfo.equals("/update")) {
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");
            if (currentUser != null) {
                currentUser.setEmail(request.getParameter("email"));
                currentUser.setFullName(request.getParameter("fullName"));
                currentUser.setPhone(request.getParameter("phone"));
                currentUser.setAddress(request.getParameter("address"));
                
                boolean success = userBO.updateUser(currentUser);
                if (success) {
                    session.setAttribute("user", currentUser);
                    request.setAttribute("message", "Profile updated successfully!");
                } else {
                    request.setAttribute("error", "Failed to update profile");
                }
                request.getRequestDispatcher("/user-profile.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/user/login");
            }
        } else if (pathInfo.equals("/change-password")) {
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");
            if (currentUser != null) {
                String currentPassword = request.getParameter("currentPassword");
                String newPassword = request.getParameter("newPassword");
                String confirmPassword = request.getParameter("confirmPassword");
                
                // Validate current password
                if (!userBO.validatePassword(currentUser.getUsername(), currentPassword)) {
                    request.setAttribute("error", "Mật khẩu hiện tại không đúng!");
                    request.getRequestDispatcher("/user-profile.jsp").forward(request, response);
                    return;
                }
                
                // Validate new password
                if (!newPassword.equals(confirmPassword)) {
                    request.setAttribute("error", "Mật khẩu mới và xác nhận mật khẩu không khớp!");
                    request.getRequestDispatcher("/user-profile.jsp").forward(request, response);
                    return;
                }
                
                if (newPassword.length() < 6) {
                    request.setAttribute("error", "Mật khẩu mới phải có ít nhất 6 ký tự!");
                    request.getRequestDispatcher("/user-profile.jsp").forward(request, response);
                    return;
                }
                
                // Update password
                boolean success = userBO.changePassword(currentUser.getId(), newPassword);
                if (success) {
                    request.setAttribute("message", "Đổi mật khẩu thành công!");
                } else {
                    request.setAttribute("error", "Không thể đổi mật khẩu. Vui lòng thử lại!");
                }
                request.getRequestDispatcher("/user-profile.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/user/login");
            }
        }
    }
} 