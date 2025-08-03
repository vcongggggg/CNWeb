# 🚀 HƯỚNG DẪN ĐẨY PROJECT LÊN GITHUB

## 📋 **CÁC BƯỚC THỰC HIỆN**

### **Bước 1: Khởi tạo Git repository (Đã hoàn thành)**
```bash
git init
```

### **Bước 2: Tạo file .gitignore (Đã hoàn thành)**
File `.gitignore` đã được tạo để loại trừ các file không cần thiết.

### **Bước 3: Thêm remote repository**
Thay thế `YOUR_USERNAME` và `YOUR_REPOSITORY_NAME` bằng thông tin thực của bạn:

```bash
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPOSITORY_NAME.git
```

**Ví dụ:**
```bash
git remote add origin https://github.com/username/mobile-shop.git
```

### **Bước 4: Thêm tất cả files vào staging area**
```bash
git add .
```

### **Bước 5: Commit lần đầu**
```bash
git commit -m "Initial commit: Mobile Shop E-commerce Project"
```

### **Bước 6: Push lên GitHub**
```bash
git push -u origin main
```

**Lưu ý:** Nếu repository của bạn sử dụng branch `master` thay vì `main`, hãy thay đổi:
```bash
git push -u origin master
```

## 🔧 **CÁC LỆNH GIT HỮU ÍCH**

### **Kiểm tra trạng thái:**
```bash
git status
```

### **Xem remote repositories:**
```bash
git remote -v
```

### **Xem lịch sử commit:**
```bash
git log --oneline
```

### **Tạo branch mới:**
```bash
git checkout -b feature-name
```

### **Chuyển branch:**
```bash
git checkout branch-name
```

### **Merge branch:**
```bash
git merge branch-name
```

## 📁 **CẤU TRÚC PROJECT SẼ ĐƯỢC PUSH**

```
BTNhom/
├── src/
│   ├── main/
│   │   ├── java/com/mobile/
│   │   │   ├── bo/
│   │   │   ├── controller/
│   │   │   ├── dao/
│   │   │   ├── model/
│   │   │   └── util/
│   │   └── webapp/
│   │       ├── admin/
│   │       ├── css/
│   │       ├── error/
│   │       └── WEB-INF/
├── target/ (sẽ bị loại trừ bởi .gitignore)
├── pom.xml
├── database.sql
├── update_database.sql
├── .gitignore
├── README.md
├── SELLING_FEATURES.md
└── GITHUB_DEPLOYMENT.md
```

## ⚠️ **LƯU Ý QUAN TRỌNG**

### **1. Database Configuration**
- File `database.sql` chứa schema database
- File `update_database.sql` chứa script cập nhật
- **KHÔNG** push file database thực tế (`.db`, `.sqlite`)

### **2. Build Files**
- Thư mục `target/` sẽ bị loại trừ bởi `.gitignore`
- Chỉ push source code, không push compiled files

### **3. Environment Variables**
- Nếu có file cấu hình database, hãy tạo file `.env.example`
- Không push file `.env` chứa thông tin nhạy cảm

## 🎯 **SAU KHI PUSH THÀNH CÔNG**

### **1. Kiểm tra trên GitHub**
- Vào repository trên GitHub
- Kiểm tra tất cả files đã được upload
- Kiểm tra `.gitignore` hoạt động đúng

### **2. Tạo Release (Tùy chọn)**
```bash
git tag -a v1.0.0 -m "First stable release"
git push origin v1.0.0
```

### **3. Cập nhật README.md**
- Thêm hướng dẫn cài đặt
- Thêm screenshots
- Thêm thông tin về features

## 🔄 **CÁCH CẬP NHẬT SAU NÀY**

### **Thêm thay đổi mới:**
```bash
git add .
git commit -m "Description of changes"
git push origin main
```

### **Pull thay đổi từ GitHub:**
```bash
git pull origin main
```

## 📞 **HỖ TRỢ**

Nếu gặp lỗi, hãy kiểm tra:
1. URL repository có đúng không
2. Quyền truy cập GitHub
3. Git credentials đã được cấu hình chưa

**Chúc bạn thành công!** 🎉 