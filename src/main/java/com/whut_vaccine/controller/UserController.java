package com.whut_vaccine.controller;


import com.whut_vaccine.domain.User;
import com.whut_vaccine.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;


@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;
//注册
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    @ResponseBody //表示返回的是数据
    public int register(HttpServletRequest request)  {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String phone=request.getParameter("phone");
        String email=request.getParameter("email");
        if(userService.selectUserByUserName(username)!=null) {
            return 400;
        }
        if(userService.selectUserByPhone(phone)!=null){
            return 401;
        }
        if(userService.selectUserByEmail(email)!=null){
            return 402;
        }
        String leveltype="1";
        User user=new User(username,password,leveltype,email,phone);
        userService.insertUser(user);
        return 200;
    }
    // 登录
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    @ResponseBody
    public int login(HttpServletRequest request)
    {
        String usernameOrEmailOrPhone = request.getParameter("usernameOrEmailOrPhone");
        String password = request.getParameter("password");
        //根据用户名或者email或者phone查找用户
        User dataBaseUser = userService.selectUser(usernameOrEmailOrPhone);
        if(dataBaseUser==null) {
            return 403;//用户不存在！
        }else if(!dataBaseUser.getpassword().equals(password)) {
            return 404;//密码错误！
        }else{
            request.getSession().setAttribute("user",dataBaseUser);
        }
        if(dataBaseUser.getLeveltype().equals("1")) {
            return 200;                               //用户身份
        }else if (dataBaseUser.getLeveltype().equals("0")){//管理员身份
            return 1;
        }
        return 0;
    }
    //通过session获取用户信息
    @RequestMapping(value = "/getUserInfoInSession",method = RequestMethod.POST)
    @ResponseBody
    public static String getUserInfoInSession(HttpServletRequest request)
    {
        Map<String, String> map=new HashMap<String, String>();

        String response="登陆";
        User user = (User)request.getSession().getAttribute("user");
        if(user!=null) {
            response = user.getusername();
        }
        map.put("result",response);
        return response;
    }
    @RequestMapping(value = "/quit", method = RequestMethod.GET)
    @ResponseBody
    public String loginOut(HttpServletRequest request) {
        // 清除session
        request.getSession().invalidate();
        return "1";
    }
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    @ResponseBody
    public String showVaccine(HttpServletRequest request) {
        try{
            User user= (User) request.getSession().getAttribute("user");
            return userService.childState(user.getId()).toString();
        }catch (Exception e){
            return "login";
        }

    }
}
