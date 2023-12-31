package com.kopo.finalproject.insurance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class InsuranceServiceImpl implements InsuranceService {
    private final InsuranceMapper insuranceMapper;

    @Autowired
    public InsuranceServiceImpl(InsuranceMapper insuranceMapper) {
        this.insuranceMapper = insuranceMapper;
    }

    @Override
    public List<InsuranceProduct> getAllInsuranceProduct() {
        return insuranceMapper.getAllInsuranceProduct();
    }

    @Override
    public List<BreedData> getBreedOne() {
        return insuranceMapper.getBreedOne();
    }

    @Override
    public List<BreedRatio> getBreedRatio() {
        return insuranceMapper.getBreedRatio();
    }

    @Override
    public List<AgeTopThree> getAgeTopThree() {
        return insuranceMapper.getAgeTopThree();
    }

    @Override
    public List<MyInsurance> getAllInsurancesOfPetOfGuest(HashMap<String, String> data) {
        return insuranceMapper.getAllInsurancesOfPetOfGuest(data);
    }

    @Override
    public List<InsuranceProduct> getInsuRecommend(String word) {
        return insuranceMapper.getInsuRecommend(word);
    }

    @Override
    public void joinInsurance(HashMap<String, String> data) {
        insuranceMapper.joinInsurance(data);
    }

    @Override
    public MyInsurance getInsuDeatil(String insu_id) {
        return insuranceMapper.getInsuDetail(insu_id);
    }
}
