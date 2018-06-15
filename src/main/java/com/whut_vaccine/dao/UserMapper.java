package com.whut_vaccine.dao;


import com.whut_vaccine.domain.User;

public interface UserMapper {
    void insertUser(User user);
    void deleteUser(int id);
    void updateUser(int id,User user);
    User selectUser(String usernameOrEmailOrPhone);
    User selectUserByUserName(String username);
    User selectUserByPhone(String phone);
    User selectUserByEmail(String email);
}
