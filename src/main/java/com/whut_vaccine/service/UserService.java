package com.whut_vaccine.service;


import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.whut_vaccine.domain.Child;
import com.whut_vaccine.domain.User;

public interface UserService {
    JSONArray childState(int id);
    User selectUser(String usernameOrEmailOrPhone);
    User selectUserByUserName(String username);
    User selectUserByPhone(String phone);
    User selectUserByEmail(String email);
    void insertUser(User user);
    void insertChild(Child child);
    void updateChild(String childname,String statement);
}
