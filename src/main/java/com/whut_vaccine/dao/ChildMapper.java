package com.whut_vaccine.dao;

import com.whut_vaccine.domain.Child;

public interface ChildMapper {
    void insertChild(Child child);
    void updateChild(String childname,String statement);
    String selectChildName(int id);
    String selectChildState(int id);
    int getChildCount();
}
