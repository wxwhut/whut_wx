package com.whut_vaccine.util;


import com.alibaba.fastjson.JSONObject;

public class JSONUTIL {
    public static JSONObject getJsonObj(String name, String value) {
        JSONObject jsonobj = new JSONObject();
        jsonobj.put(name,value);
        return jsonobj;
    }

}
