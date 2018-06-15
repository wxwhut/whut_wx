package com.whut_vaccine.service.impl;


import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.whut_vaccine.dao.ChildMapper;
import com.whut_vaccine.dao.UserMapper;
import com.whut_vaccine.dao.VaccineMapper;
import com.whut_vaccine.domain.Child;
import com.whut_vaccine.domain.User;
import com.whut_vaccine.domain.Vaccine;
import com.whut_vaccine.service.UserService;
import com.whut_vaccine.util.JSONUTIL;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class UserServiceImpl implements UserService {
    @Resource
    UserMapper userMapper;
    public User selectUser(String usernameOrEmailOrPhone) {

        return userMapper.selectUser(usernameOrEmailOrPhone);
    }

    public User selectUserByUserName(String username) {

        return userMapper.selectUserByUserName(username);
    }

    public User selectUserByPhone(String phone) {
        return userMapper.selectUserByPhone(phone);
    }

    public User selectUserByEmail(String email) {
        return userMapper.selectUserByEmail(email);
    }

    public void insertUser(User user) {
        userMapper.insertUser(user);
    }

    @Resource
    ChildMapper childMapper;
    @Override
    public void insertChild(Child child) {
        childMapper.insertChild(child);
    }

    @Override
    public void updateChild(String childname, String statement) {
        childMapper.updateChild(childname,statement);
    }


    @Autowired
    VaccineMapper vaccineMapper;
    @Override
    public JSONArray childState(int id) {
        try {
            JSONArray result=new JSONArray();
            String childName=childMapper.selectChildName(id);
            String childState=childMapper.selectChildState(id);
            String[] token=childState.split("\\,");
            for(String s:token){
                String vid=s.split("\\_")[0];
                String date=s.split("\\_")[1];
                Vaccine vaccine=vaccineMapper.selectVaccine(Integer.parseInt(vid));
                JSONObject jsonObject= (JSONObject) JSONObject.toJSON(vaccine);
                int childCount=childMapper.getChildCount();
                int vaccineChildCount=vaccineMapper.getVaccineChildCount(Integer.parseInt(vid));
                jsonObject.put("name",childName);
                jsonObject.put("date",date);
                jsonObject.put("ChildCount",childCount);
                jsonObject.put("vaccineChildCount",vaccineChildCount);
                result.add(jsonObject);
            }
            return result;
        }catch (Exception e){
            return new JSONArray();
        }
    }
}
