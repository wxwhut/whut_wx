package com.whut_vaccine.dao;


import com.whut_vaccine.domain.Vaccine;

import java.util.List;

public interface VaccineMapper {
    void insertVaccine(Vaccine vaccine);
    void deleteVaccine(int id);
    void updateVaccine(int id,Vaccine vaccine);
    Vaccine selectVaccine(int id);
    String selectVaccineName(int id);
    List<Vaccine> selectAll();
    int getVaccineChildCount(int id);
}
