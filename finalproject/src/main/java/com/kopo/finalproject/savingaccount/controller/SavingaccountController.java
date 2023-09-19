package com.kopo.finalproject.savingaccount.controller;

import com.kopo.finalproject.pet.model.dto.Pet;
import com.kopo.finalproject.pet.service.PetService;
import com.kopo.finalproject.savingaccount.model.dto.MyAccountsOfPet;
import com.kopo.finalproject.savingaccount.model.dto.MyPageDetailInfo;
import com.kopo.finalproject.savingaccount.model.dto.MyPageHistoryInfo;
import com.kopo.finalproject.savingaccount.service.SavingaccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

@Controller
public class SavingaccountController {
    @Autowired
    private final SavingaccountService savingaccountService;

    @Autowired
    private final PetService petService;

    public SavingaccountController(SavingaccountService savingaccountService, PetService petService) {
        this.savingaccountService = savingaccountService;
        this.petService = petService;
    }

    @GetMapping("/savingaccounts")
    public ResponseEntity<List<MyAccountsOfPet>> getSavingaccount(@RequestParam HashMap<String, String> data) {
        List<MyAccountsOfPet> savingaccounts = savingaccountService.getAllSavingAccountsOfPetOfGuest(data); // 데이터베이스에서 모든 제품 정보 가져오기\
        return ResponseEntity.ok(savingaccounts);
    }

    @RequestMapping("/mypet-saving")
    public ModelAndView mypetSaving(HttpSession session) {
        ModelAndView mav = new ModelAndView("mypet-saving");
        String id = (String) session.getAttribute("guest_id");
        List<Pet> pets = petService.getAllPetsOfGuest(id);
        mav.addObject("pets", pets);
        return mav;
    }

    // 마이페이지 반려견 적금 자세히 보기
    @GetMapping("/mypet-saving/detail")
    public ModelAndView mypetSavingDetail(@RequestParam(name = "accountNumber", required = false) String accountNumber) {
        ModelAndView mav = new ModelAndView("mypet-saving-detail");
        // 자세히 보기 페이지에서 필요한 정보들
        List<MyPageDetailInfo> infos = savingaccountService.getDetailInfo(accountNumber);
        // 자세히 보기 페이지에서 필요한 거래 내역 정보들
        List<MyPageHistoryInfo> historyInfos = savingaccountService.getHistoryInfo(accountNumber);
        mav.addObject("info", infos);
        mav.addObject("history_info", historyInfos);
        System.out.println("infos: "+ infos);
        System.out.println("historyInfos: "+ historyInfos);
        return mav;
    }

    @PostMapping("/join-savingaccounts")
    public ResponseEntity<String> createSavingaccount(@RequestBody HashMap<String, String> data) {
        savingaccountService.joinSavingAccounts(data);
        return ResponseEntity.ok("적금 생성 성공");
    }

    @PostMapping("/join-invited")
    public ResponseEntity<String> joinInvited(@RequestBody HashMap<String, String> data, HttpSession session) {
        savingaccountService.joinInvited(data);
        session.removeAttribute("accountNumber");
        return ResponseEntity.ok("초대 적금 가입 성공");
    }
}