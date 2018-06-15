package com.whut_vaccine.service;


import com.whut_vaccine.domain.Vaccine;

import java.util.List;

public interface AdminService {
    List<Vaccine> ShowAll();
    void InsertVaccine(Vaccine vaccine);
    void DeleteVaccine(int id);

}
