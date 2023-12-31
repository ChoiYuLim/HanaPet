package com.kopo.finalproject.savingaccount.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class MyPageDetailInfo {
    private String guestId;
    private String guestName;
    private String accountNumber;
    private String openingDate;
    private String endDate;
    private String category;
    private String categoryImg;
    private String openerId;
    private String openerName;
    private String balance;
    private String savingName;
    private String petName;
    private String progressRate;
    private String finalAmount;
    private String interestAmount;
    private String joinDate;
    private String contributionAmount;
    private String contributionRatio;
    private String transferAmount;
    private String transferPeriod;
    private String depositAccountNumber;
    private String rate;
    private String priorRate;

    public MyPageDetailInfo() {
    }
}