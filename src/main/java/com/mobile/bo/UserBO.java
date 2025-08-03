package com.mobile.bo;

import com.mobile.dao.UserDAO;
import com.mobile.model.User;

import java.util.List;

public class UserBO {
    private UserDAO userDAO;
    
    public UserBO() {
        this.userDAO = new UserDAO();
    }
    
    public User login(String username, String password) {
        // Validate input
        if (username == null || username.trim().isEmpty()) {
            return null;
        }
        if (password == null || password.trim().isEmpty()) {
            return null;
        }
        
        return userDAO.login(username, password);
    }
    
    public boolean register(User user) {
        // Validate user data
        if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
            return false;
        }
        if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
            return false;
        }
        if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            return false;
        }
        if (user.getFullName() == null || user.getFullName().trim().isEmpty()) {
            return false;
        }
        
        return userDAO.register(user);
    }
    
    public User getUserById(int id) {
        return userDAO.getUserById(id);
    }
    
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }
    
    public boolean updateUser(User user) {
        // Validate user data
        if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
            return false;
        }
        if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            return false;
        }
        if (user.getFullName() == null || user.getFullName().trim().isEmpty()) {
            return false;
        }
        
        return userDAO.updateUser(user);
    }
    
    public boolean deleteUser(int id) {
        return userDAO.deleteUser(id);
    }
    
    public boolean isAdmin(User user) {
        return user != null && "admin".equals(user.getRole());
    }
    
    public boolean isCustomer(User user) {
        return user != null && "customer".equals(user.getRole());
    }
    
    public boolean validatePassword(String username, String password) {
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            return false;
        }
        return userDAO.validatePassword(username, password);
    }
    
    public boolean changePassword(int userId, String newPassword) {
        if (newPassword == null || newPassword.trim().isEmpty() || newPassword.length() < 6) {
            return false;
        }
        return userDAO.changePassword(userId, newPassword);
    }
} 