CREATE DATABASE IF NOT EXISTS mobile_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE mobile_shop;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    role ENUM('admin', 'customer') DEFAULT 'customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    brand VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    image VARCHAR(500),
    category VARCHAR(100),
    seller_id INT NOT NULL,
    `condition` VARCHAR(50),
    warranty VARCHAR(100),
    location VARCHAR(200),
    contact_info TEXT,
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (seller_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'confirmed', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending',
    shipping_address TEXT,
    payment_method VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

INSERT INTO users (username, password, email, full_name, phone, address, role) VALUES
('admin', 'admin123', 'admin@mobileshop.com', 'Administrator', '0123456789', '123 Admin Street, HCMC', 'admin'),
('customer1', 'customer123', 'customer1@email.com', 'Nguyễn Văn A', '0987654321', '456 Customer Street, HCMC', 'customer'),
('customer2', 'customer123', 'customer2@email.com', 'Trần Thị B', '0123456780', '789 Customer Street, HCMC', 'customer');

INSERT INTO products (name, brand, description, price, stock, image, category, seller_id, `condition`, warranty, location, contact_info, status) VALUES
('iPhone 15 Pro Max', 'iPhone', 'iPhone 15 Pro Max với chip A17 Pro, camera 48MP, màn hình 6.7 inch', 29990000, 10, 'https://example.com/iphone15.jpg', 'iPhone', 1, 'Mới', '12 tháng', 'TP.HCM', 'admin@mobileshop.com', 'approved'),
('Samsung Galaxy S24 Ultra', 'Samsung', 'Samsung Galaxy S24 Ultra với S Pen, camera 200MP, màn hình 6.8 inch', 26990000, 15, 'https://example.com/s24ultra.jpg', 'Samsung', 1, 'Mới', '12 tháng', 'TP.HCM', 'admin@mobileshop.com', 'approved'),
('Xiaomi 14 Ultra', 'Xiaomi', 'Xiaomi 14 Ultra với camera Leica, chip Snapdragon 8 Gen 3', 19990000, 8, 'https://example.com/xiaomi14.jpg', 'Xiaomi', 1, 'Mới', '12 tháng', 'TP.HCM', 'admin@mobileshop.com', 'approved'),
('OPPO Find X7 Ultra', 'Oppo', 'OPPO Find X7 Ultra với camera Hasselblad, chip MediaTek Dimensity 9300', 18990000, 12, 'https://example.com/oppofindx7.jpg', 'Oppo', 1, 'Mới', '12 tháng', 'TP.HCM', 'admin@mobileshop.com', 'approved'),
('iPhone 14', 'iPhone', 'iPhone 14 với chip A15 Bionic, camera 12MP, màn hình 6.1 inch', 19990000, 20, 'https://example.com/iphone14.jpg', 'iPhone', 1, 'Mới', '12 tháng', 'TP.HCM', 'admin@mobileshop.com', 'approved'),
('Samsung Galaxy A55', 'Samsung', 'Samsung Galaxy A55 với camera 50MP, chip Exynos 1480', 8990000, 25, 'https://example.com/a55.jpg', 'Samsung', 1, 'Mới', '12 tháng', 'TP.HCM', 'admin@mobileshop.com', 'approved'),
('Xiaomi Redmi Note 13 Pro', 'Xiaomi', 'Xiaomi Redmi Note 13 Pro với camera 200MP, chip MediaTek Dimensity 7200 Ultra', 6990000, 18, 'https://example.com/redminote13.jpg', 'Xiaomi', 1, 'Mới', '12 tháng', 'TP.HCM', 'admin@mobileshop.com', 'approved'),
('OPPO Reno 11', 'Oppo', 'OPPO Reno 11 với camera 50MP, chip MediaTek Dimensity 7050', 7990000, 22, 'https://example.com/reno11.jpg', 'Oppo', 1, 'Mới', '12 tháng', 'TP.HCM', 'admin@mobileshop.com', 'approved'); 