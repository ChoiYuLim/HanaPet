<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.kopo.finalproject.EmailSender" %>
<!DOCTYPE html>
<head>
    <title>Join-Product</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link rel="stylesheet" href="/resources/css/common.css">
    <link rel="stylesheet" href="/resources/css/join-product.css">
    <link rel="stylesheet" href="/resources/css/modal.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
            crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        table {
            width: 100%;
        }

        th {
            width: 15%;
        }

        td {
            padding: 0px 0px 4px 0px;
            text-align: center;
            width: 30%;
        }

        td.form-label {
            font-weight: normal;
            padding-top: 20px;
            color: #324D3D;
        }

        td:nth-child(2) {
            text-align: start;
            width: 300px;
            padding-left: 10px;
        }

        .accordion-button {
            color: white !important;
            background-color: var(--primary-color) !important;
        }

        .f {
            padding-top: 7px;
            background: #E1E6DE;
            text-align: center !important;
        }

        .s {
            padding-left: 10px;
            text-align: start;
        }

        .modal_body {
            height: 410px;
        }

        .category {
            background: white;
            box-shadow: none;
            width: auto;
            height: 60px;
            display: flex;
            align-items: center;
            padding: 0px 10px;
        }
    </style>
</head>
<%@ include file="include/header.jsp" %>
<div class="body">
    <section id="hero-animated" class="hero-animated2 align-items-center">
        <div id='mask_wrap2'>
            <div class="container" style="margin-top: 40px;">
                <div class="row">
                    <h4 class="mb-4" style="text-align: center">보험 가입 신청서</h4>
                    <div style="margin-top: 45px; display: flex;" data-wow-delay="0.3s">
                        <div style="width: 600px; margin-right: 80px;">
                            <h5>신청인 정보</h5>
                            <table>
                                <tr>
                                    <td class="f">성명</td>
                                    <td class="s"
                                        style="background: none !important;"><%=session.getAttribute("name")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>주민등록번호</td>
                                    <td><%=session.getAttribute("personal_id").toString().substring(0, 6)%>
                                        -<%=session.getAttribute("personal_id").toString().substring(6, 7)%>xxxxxx
                                    </td>
                                </tr>
                                <tr>
                                    <td>자택주소</td>
                                    <td>서울시 강서구 화곡로 11번지</td>
                                </tr>
                                <tr>
                                    <td>연락처</td>
                                    <td><%=session.getAttribute("phone").toString().substring(0, 3)%>
                                        -<%=session.getAttribute("phone").toString().substring(3, 7)%>
                                        -<%=session.getAttribute("phone").toString().substring(7, 11)%>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div>
                            <h5>반려견 정보</h5>
                            <table>
                                <tr id="dog" style=" border-bottom: 3px solid var(--primary-color); height: 45px ">
                                    <td class="form-label" style="padding-top: 5px">반려견 이름</td>
                                    <td style="padding-top: 3px">
                                        <select class="form-dropdown" id="petSelection" style="width: 250px;" required>
                                            <option value="" selected disabled>반려견을 선택하세요</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr id="breedTableRow" style="display: none; height: 45px">
                                    <td class="form-label" style="padding-top: 5px">반려견 종</td>
                                    <td id="breedTableCell"></td>
                                </tr>
                                <tr id="ageTableRow" style="display: none;  height: 45px">
                                    <td class="form-label" style="padding-top: 5px">반려견 나이</td>
                                    <td id="ageTableCell"></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <br>
                    <div>
                        <br><br><br>
                        <h5>보험 정보</h5>
                        <table>
                            <tr>
                                <td class="f">보험회사명</td>
                                <td class="s" style="background: none !important;">하나펫손해보험</td>
                            </tr>
                            <tr>
                                <td>보험명</td>
                                <td id="name"></td>
                            </tr>
                            <tr>
                                <td>보험료</td>
                                <td id="amount1">
                                </td>
                            </tr>
                            <tr>
                                <td>최종가입료</td>
                                <td id="amount2">
                                </td>
                            </tr>
                        </table>
                        <script>
                            document.getElementById('name').textContent = JSON.parse(sessionStorage.getItem("selectedInsurance")).insuranceName;
                            document.getElementById('amount1').textContent = JSON.parse(sessionStorage.getItem("selectedInsurance")).insuranceAmount;
                            document.getElementById('amount2').textContent = JSON.parse(sessionStorage.getItem("selectedInsurance")).insuranceAmount;
                        </script>
                        <br>
                        <p style="font-size: 17px">※ 실제 보험료는 보험기간, 납입기간, 가입금액 등 선택에 따라 달라질 수 있습니다.</p>
                        <br><br>
                        <h5>납입 정보</h5>
                        <table class="table">
                            <tr>
                                <td class="form-label">출금 계좌번호</td>
                                <td>
                                    <div style="display: flex">
                                        <select class="form-dropdown" id="accountNumberSelection" required
                                                onchange="updateBalance()">
                                        </select>
                                        <div class="color">
                                            <div style="display: flex">
                                                <div>현재 잔액:</div>
                                                <div id="current_balance"></div>
                                            </div>
                                            <div style="display: flex">
                                                <div>출금 가능 금액:</div>
                                                <div id="able_balance"></div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="form-label">계좌 비밀번호</td>
                                <td>
                                    <div style="display: flex">
                                        <div>
                                            <input type="password" class="input-form" id="accountPassword"
                                                   placeholder="계좌 비밀번호를 입력해주세요."
                                                   required>
                                            <div id="pwMessage"></div>
                                        </div>
                                        <button class="Button" id="confirmButton">확인</button>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <br>
                        <div>
                            <h4 style="margin-top: 80px; text-align: center">보험 가입 동의서</h4>
                            <br>
                            <img src="/resources/img/warning.png" width="30px">
                            <span>본 동의서는 요약 동의서이며, 「신용정보의 이용 및 보호에 관한 법률」에 따라, 상세동의서의 주요 사항만을 발췌한 동의서입니다. </span>
                            <h6>요약 동의서에 동의하시면 상세 동의서에 대한 동의는 생략합니다.</h6>
                        </div>
                        <div>
                            <div style="margin:20px 0px">[필수] 계약 체결 ‧ 이행을 위한 상세 동의서 (개인금융성 신용보험용)</div>
                            <label for="agree_all" style="margin-bottom: 25px;">
                                <input type="checkbox" name="agree_all" id="agree_all"
                                       style="width: 18px; height: 16px;">
                                <span style="font-size: 23px; text-align: center;">모두 동의합니다.</span>
                            </label>

                            <div class="accordion" id="agreeAccordion1">
                                <div class="accordion-item">
                                    <h2 class="accordion-header"><%--@declare id="agree"--%><label for="agree"
                                                                                                   style="width:100%">
                                        <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse"
                                                data-bs-target="#collapseAgree1" aria-expanded="true"
                                                aria-controls="collapseAgree1">
                                            <input type="checkbox" name="agree" value="1"
                                                   style="width: 16px; height: 15px;">
                                            <span style="font-size: 18px; color: white">&nbsp개인(신용)정보의 수집·이용 목적</span>
                                        </button>
                                    </label>
                                    </h2>
                                    <div id="collapseAgree1" class="accordion-collapse collapse"
                                         aria-labelledby="headingProduct"
                                         data-bs-parent="#agreeAccordion1">
                                        <div class="accordion-body"
                                             style="border: 3px solid #E1E6DE; border-radius: 0px 0px 5px 5px;">
                                            <div class="accordion-body">
                                                「신용정보의 이용 및 보호에 관한 법률」 제32조 제2항에 따라 귀사가 아래와 같은 내용으로 손해보험협회, 생명보험협회 등
                                                신용정보집중기관, 금융위원회,
                                                금융감독원으로부터 본인의 신용정보를 조회하는 것에 대하여 동의합니다.<br><br>
                                                <div>
                                                    o 보험계약의 인수 심사·체결·유지·관리(부활 및 갱신 포함)<br>
                                                    o 보험금 등 지급·심사<br>
                                                    o 순보험요율의 산출·검증<br>
                                                    o 민원 처리 및 분쟁 대응<br>
                                                    o 적부 및 사고조사(보험사기 조사 포함)<br>
                                                    o 보험모집질서의 유지<br>
                                                    o 기존 계약자에 대한 보험계약 상담(당사 및 당사 설계사에 한함)<br>
                                                    o 금융거래 관련 업무(금융거래 신청, 자동이체 등)
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="accordion" id="agreeAccordion2">
                                <div class="accordion-item">
                                    <h2 class="accordion-header"><label for="agree" style="width:100%">
                                        <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse"
                                                data-bs-target="#collapseAgree2" aria-expanded="true"
                                                aria-controls="collapseAgree2">
                                            <input type="checkbox" name="agree" value="1"
                                                   style="width: 16px; height: 15px;">
                                            <span style="font-size: 18px; color: white">&nbsp수집·이용할 개인(신용)정보의 내용</span>
                                        </button>
                                    </label>
                                    </h2>
                                    <div id="collapseAgree2" class="accordion-collapse collapse"
                                         aria-labelledby="headingProduct"
                                         data-bs-parent="#agreeAccordion">
                                        <div class="accordion-body"
                                             style="border: 3px solid #E1E6DE; border-radius: 0px 0px 5px 5px;">
                                            <div class="accordion-body">
                                                「신용정보의 이용 및 보호에 관한 법률」 제32조 제2항에 따라 귀사가 아래와 같은 내용으로 손해보험협회, 생명보험협회 등
                                                신용정보집중기관, 금융위원회,
                                                금융감독원으로부터 본인의 신용정보를 조회하는 것에 대하여 동의합니다.<br><br>
                                                o 개인식별정보(성명,주민등록번호, 외국인등록번호, 주소, 성별, 직업, 전화번호, 휴대전화번호, 전자우편 주소)<br>
                                                o 당사, 신용정보집중기관 및 보험요율 산출기관에서 수집·관리하는 보험계약 정보, 피보험자의 질병 및 상해에 관한 정보, 보험금
                                                지급 관련
                                                정보(사고정보, 본인의 위임을 받아 취득한 각종 조사서, 판결문, 증명서, 확인서, 진료기록 등)<br>
                                                o 계약 전 알릴 의무 사항, 소득 및 재산 사항<br>
                                                o 법률 및 국제협약 등의 의무이행을 위한 정보<br>
                                                o 금융거래 업무(보험료 및 보험금 등 출·수납) 관련 정보
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="accordion" id="agreeAccordion3">
                                <div class="accordion-item">
                                    <h2 class="accordion-header"><label for="agree" style="width:100%">
                                        <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse"
                                                data-bs-target="#collapseAgree3" aria-expanded="true"
                                                aria-controls="collapseAgree3">
                                            <input type="checkbox" name="agree" value="1"
                                                   style="width: 16px; height: 15px;">
                                            <span style="font-size: 18px; color: white">&nbsp개인(신용)정보의 보유·이용기간</span>
                                        </button>
                                    </label>
                                    </h2>
                                    <div id="collapseAgree3" class="accordion-collapse collapse"
                                         aria-labelledby="headingProduct"
                                         data-bs-parent="#agreeAccordion3">
                                        <div class="accordion-body"
                                             style="border: 3px solid #E1E6DE; border-radius: 0px 0px 5px 5px;">
                                            <div class="accordion-body">
                                                「신용정보의 이용 및 보호에 관한 법률」 제32조 제2항에 따라 귀사가 아래와 같은 내용으로 손해보험협회, 생명보험협회 등
                                                신용정보집중기관, 금융위원회,
                                                금융감독원으로부터 본인의 신용정보를 조회하는 것에 대하여 동의합니다.<br><br>
                                                <div>
                                                    o 수집·이용 동의일로부터 거래종료 후 5년까지 (단, 거래종료 후 5년이 경과한 후에는 보험금 지급, 금융사고 조사,
                                                    보험사기 방지∙적발, 민원처리,
                                                    법령상 의무이행을 위한 경우에 한하여 보유·이용하며, 별도 보관)
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="accordion" id="agreeAccordion4">
                                <div class="accordion-item">
                                    <h2 class="accordion-header"><label for="agree" style="width:100%">
                                        <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse"
                                                data-bs-target="#collapseAgree4" aria-expanded="true"
                                                aria-controls="collapseAgree4">
                                            <input type="checkbox" name="agree" value="1"
                                                   style="width: 16px; height: 15px;">
                                            <span style="font-size: 18px; color: white">&nbsp민감정보 및 고유 식별정보의 처리에 관한 사항</span>
                                        </button>
                                    </label>
                                    </h2>
                                    <div id="collapseAgree4" class="accordion-collapse collapse"
                                         aria-labelledby="headingProduct"
                                         data-bs-parent="#agreeAccordion3">
                                        <div class="accordion-body"
                                             style="border: 3px solid #E1E6DE; border-radius: 0px 0px 5px 5px;">
                                            <div class="accordion-body">
                                                「신용정보의 이용 및 보호에 관한 법률」 제32조 제2항에 따라 귀사가 아래와 같은 내용으로 손해보험협회, 생명보험협회 등
                                                신용정보집중기관, 금융위원회,
                                                금융감독원으로부터 본인의 신용정보를 조회하는 것에 대하여 동의합니다.<br><br>
                                                <div>
                                                    o 수집·이용 동의일로부터 거래종료 후 5년까지 (단, 거래종료 후 5년이 경과한 후에는 보험금 지급, 금융사고 조사,
                                                    보험사기 방지∙적발, 민원처리,
                                                    법령상 의무이행을 위한 경우에 한하여 보유·이용하며, 별도 보관)
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <div style="text-align: center; margin-top: 50px">
        <button type="button" class="Button" id="joinButton">가입하기</button>
    </div>

    <div class="modal">
        <div class="modal_body">
            <div class="category">
                <img src="/resources/img/insurance-logo.png" width="160px"
                     style="padding-left: 5px; padding-top: 3px; margin-right: 15px;">
            </div>

            <div class="first-content">
                <span id="selectedPetName"></span><br>
                <span id="account-name"></span><br>
                <span>에 가입되었습니다.</span>
            </div>
            <div class="second-content">
                <img src="/resources/img/checked.png" width="100px"/>
            </div>
            <div class="third-content">
                <a href="/">
                    <button>HOME으로</button>
                </a>
                <a href="/mypage">
                    <button>마이페이지로</button>
                </a>
            </div>
        </div>
    </div>
</div>
<%@ include file="include/footer.jsp" %>

<%
    String guest_id = (String) session.getAttribute("guest_id");
%>
<script>
    const agreeChkAll = document.querySelector('input[name=agree_all]');

    agreeChkAll.addEventListener('change', (e) => {
        let agreeChk = document.querySelectorAll('input[name=agree]');
        for (let i = 0; i < agreeChk.length; i++) {
            agreeChk[i].checked = e.target.checked;
        }
    });

    $("#joinButton").click(function () {
        const isAgreed = document.getElementById("agree_all").checked;
        if (!isAgreed) {
            alert("약관에 동의해주세요.");
        } else {
            joinInsurance();
            <%EmailSender.naverMailSend((String) session.getAttribute("email"),"하나펫 손해보험 - 프로미 반려동물보험 One형 플랜 가입 확정 안내", "안녕하세요 "+ (String)session.getAttribute("name")+"님\n" +
"\n" +
"하나펫 손해보험에 프로미 반려동물보험 One형 플랜을 가입해 주셔서 진심으로 감사드립니다.\n" +
"\n" +
"가입하신 보험의 주요 내용 및 유의사항을 첨부된 PDF에서 확인하실 수 있습니다. 보험에 대한 자세한 내용과 유의사항을 꼭 확인하시어 보험 이용에 차질이 없도록 해주시기 바랍니다.\n" +
"\n" +
"첨부 파일:\n" +
"프로미 반려동물보험 One형 플랜 유의사항 및 상세 안내\n" +
"보험과 관련하여 궁금한 사항이나 문의사항이 있으시면 언제든지 고객센터로 연락 주시기 바랍니다.\n" +
"\n" +
"다시 한번 가입해 주셔서 감사드리며, 항상 건강하고 행복한 시간을 보내시길 바랍니다.\n" +
"\n" +
"감사합니다.\n" +
"\n" +
"하나펫 손해보험 드림.", "C:\\Users\\ChoiYuLim\\yulim\\hanaTI\\hanaPet\\finalproject\\src\\main\\webapp\\resources\\pdf\\insurance_프로미 반려동물보험 One형 플랜 유의사항.pdf");%>
        }
    });

    function joinInsurance() {
        const productInfo = JSON.parse(sessionStorage.getItem("selectedInsurance"));
        const selectedOption = document.getElementById('accountNumberSelection').options[document.getElementById('accountNumberSelection').selectedIndex];
        const requestData = {
            guestId: '<%=guest_id%>',
            petId: document.getElementById("petSelection").value,
            insuranceName: productInfo.insuranceName,
            depositAccountNumber: selectedOption.textContent.split(" ")[0],
            insuranceAmount: parseInt(productInfo.insuranceAmount.replace(/[^0-9]/g, ""), 10)
        };

        $.ajax({
            url: "/join-insuranceProduct",
            type: "POST",
            data: JSON.stringify(requestData),
            contentType: 'application/json',
            success: function (response) {
                console.log(response)
                if (response === "보험 생성 성공") {
                    modal.style.display = "block";
                } else {
                    console.error("insert 실패");
                }
            },
            error: function () {
                console.log("Error post.");
            }
        });
        modal.style.display = "block";
    }

</script>
<script>
    const modal = document.querySelector('.modal');

    function updateBalance() {
        const selectedValue = document.getElementById("accountNumberSelection").value;

        document.getElementById("current_balance").textContent = Number(selectedValue).toLocaleString() + "원";
        document.getElementById("able_balance").textContent = Number(selectedValue).toLocaleString() + "원";

        document.getElementById('accountPassword').value = "";
        document.getElementById('pwMessage').textContent = "";
        flag1 = false;
    }

    $(document).ready(function () {
        var guest_id = '<%= guest_id %>';

        $.ajax({
            url: '/pets',
            method: 'GET',
            data: {
                guest_id: guest_id
            },
            dataType: 'json',
            success: function (data) {
                const petSelection = $('#petSelection');
                const breedTableRow = $('#breedTableRow');
                const breedTableCell = $('#breedTableCell');
                const ageTableRow = $('#ageTableRow');
                const ageTableCell = $('#ageTableCell');

                data.forEach(function (pet) {
                    // 각 반려견에 대한 옵션을 생성하여 삽입
                    const option = $('<option>', {
                        value: pet.pet_id,
                        text: pet.name,
                        'data-breed': pet.breed,
                        'data-age': pet.age
                    });
                    petSelection.append(option);

                    petSelection.on('change', function () {
                        const selectedOption = petSelection.find(':selected');
                        const selectedBreed = selectedOption.data('breed');
                        const selectedAge = selectedOption.data('age');
                        const selectedName = selectedOption.text();

                        $('#selectedPetName').text(selectedName + "를 위한");

                        if (selectedBreed) {
                            breedTableRow.show();
                            breedTableCell.text(selectedBreed);
                            $('#dog').css('border-bottom', 'none');
                        } else {
                            breedTableRow.hide();
                        }
                        if (selectedAge) {
                            ageTableRow.show();
                            ageTableCell.text(selectedAge + "살");
                        } else {
                            ageTableRow.hide();
                        }
                    });
                });
            },
            error: function (xhr, status, error) {
                console.error('Error fetching pet list:', error);
            }
        });

        document.getElementById('account-name').textContent = JSON.parse(sessionStorage.getItem("selectedInsurance")).insuranceName;
    });

    $.ajax({
        url: '/depositaccounts',
        method: 'GET',
        data: {
            guest_id: '<%= guest_id %>'
        },
        dataType: 'json',
        success: function (data) {
            const accountNumberSelection = document.getElementById('accountNumberSelection');
            data.forEach(function (account) {
                const option = document.createElement('option');
                option.value = account.balance;
                option.textContent = account.account_number + " [" + account.account_name + "]";
                accountNumberSelection.appendChild(option);
            });
            document.getElementById("current_balance").textContent = data[0].balance.toLocaleString() + "원";
            document.getElementById("able_balance").textContent = data[0].balance.toLocaleString() + "원";
        },
        error: function (xhr, status, error) {
            console.error('Error fetching account list:', error);
        }
    });

    $("#confirmButton").click(function (event) {
        const account_number = $("#accountNumberSelection option:selected").text().split(' ')[0];
        const account_pw = $("#accountPassword").val();

        $.ajax({
            url: '/checkdepositaccountpw',
            method: 'GET',
            data: {
                guest_id: '<%= guest_id %>',
                account_number: account_number,
                account_pw: account_pw
            },
            dataType: 'json',
            success: function (data) {
                if (data < 1) { // 비번 틀린 경우
                    document.getElementById('pwMessage').textContent = "비밀번호가 틀립니다.";
                    flag1 = false;
                } else { // 비번 일치하는 경우
                    document.getElementById('pwMessage').textContent = "비밀번호가 일치합니다.";
                    flag1 = true;
                }
            },
            error: function (xhr, status, error) {
                console.error('Error fetching account list:', error);
            }
        });
        event.preventDefault();
    })
</script>