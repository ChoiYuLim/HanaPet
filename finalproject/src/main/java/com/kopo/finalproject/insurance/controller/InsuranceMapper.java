package com.kopo.finalproject.insurance.controller;

import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface InsuranceMapper {

    List<InsuranceProduct> getAllInsuranceProduct();

    List<BreedData> getBreedOne();

    List<InsuranceProduct> getInsuRecommend(String word);

    List<BreedRatio> getBreedRatio();

    List<AgeTopThree> getAgeTopThree();

    List<MyInsurance> getAllInsurancesOfPetOfGuest(HashMap<String, String> data);

    void joinInsurance(HashMap<String, String> data);

    MyInsurance getInsuDetail(String insu_id);
}
