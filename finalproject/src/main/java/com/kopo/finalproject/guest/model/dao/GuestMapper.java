package com.kopo.finalproject.guest.model.dao;

import com.kopo.finalproject.guest.model.dto.EmailGuest;
import com.kopo.finalproject.guest.model.dto.EndMessageGuest;
import com.kopo.finalproject.guest.model.dto.Guest;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface GuestMapper {
    List<Guest> getAllGuest();

    // 로그인하기 (select)

    List<EndMessageGuest> getEndMessageGuest(String account_number);

    Guest loginGuest(HashMap<String, String> loginData);

    Guest selectEmailOneMember(String email);

    int checkDuplicate(HashMap<String, String> data);

    void insertPet(HashMap<String, String> data);

    String getPhone(String guest_id);

    List<EmailGuest> getEmailGuest();
}
