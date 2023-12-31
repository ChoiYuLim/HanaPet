package com.kopo.finalproject.depositaccount.model.dao;

import com.kopo.finalproject.depositaccount.model.dto.Depositaccount;
import com.kopo.finalproject.depositaccount.model.dto.History;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface DepositaccountMapper {

    // 예금 계좌를 모두 가져오기 (select)
    List<Depositaccount> getAllDepositAccountsOfGuest(String guest_id);

    List<History> getHistory(String account_number);

    // 예금 계좌 비밀번호 확인하기
    int checkDepositAccountPW(HashMap<String, String> checkPWdata);

    // 예금 계좌에서 인출하기 (update)
    void withdraw(HashMap<String, String> data);

    // 예금 계좌에 돈 넣기 (update)
    void insert(HashMap<String, String> data);

    String getBalance(String account_number);

}
