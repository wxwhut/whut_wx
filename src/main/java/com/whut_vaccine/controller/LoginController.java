package com.whut_vaccine.controller;

import com.whut_vaccine.domain.User;
import com.whut_vaccine.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;


@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    // 登录
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> login(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        User dataBaseUser = userService.selectUser(userName);
        if (dataBaseUser != null && password.equals(dataBaseUser.getpassword())) {
            User user = new User(userName, password, dataBaseUser.getLeveltype(), dataBaseUser.getEmail(), dataBaseUser.getPhone());
            request.getSession().setAttribute("user", user);
            map.put("result", "1");
        } else if (dataBaseUser != null && !password.equals(dataBaseUser.getpassword())) {
            map.put("result", "2");
        } else {
            map.put("result", "0");
        }
        return map;
    }

    // 退出
    @RequestMapping(value = "/quit", method = RequestMethod.GET)
    public String loginOut(HttpServletRequest request) {
        // 清除session
        request.getSession().invalidate();
        return "login";
    }

}
