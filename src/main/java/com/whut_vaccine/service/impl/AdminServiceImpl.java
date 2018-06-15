package com.whut_vaccine.service.impl;


import com.whut_vaccine.dao.VaccineMapper;
import com.whut_vaccine.domain.Vaccine;
import com.whut_vaccine.service.AdminService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class AdminServiceImpl implements AdminService{
    @Resource
    VaccineMapper vaccineMapper;

    @Override
    public List<Vaccine> ShowAll() {
        return vaccineMapper.selectAll();
    }

    @Override
    public void InsertVaccine(Vaccine vaccine) {
        vaccineMapper.insertVaccine(vaccine);
    }

    @Override
    public void DeleteVaccine(int id) {
        vaccineMapper.deleteVaccine(id);
    }


}
