<%@ page import="com.kopo.finalproject.guest.model.dto.Guest" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<head>
    <title>Join-Product</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link rel="stylesheet" href="/resources/css/common.css">
    <link rel="stylesheet" href="/resources/css/modal.css">
    <link rel="stylesheet" href="/resources/css/join-product.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/resources/javascript/common.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <style>
        .modal {
            height: 2190px;
        }

        .modal_body {
            top: 67%;
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

        .password-wrapper {
            position: relative;
            display: inline-block;
        }

        .eye-icon {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
        }

        .div-1 {
            width: 58%;
            place-content: space-between;
            display: flex;
            font-weight: bold;
        }

        .mtb {
            margin-top: 20px;
            font-weight: bold;
        }

        .r {
            color: red;
        }

    </style>
</head>
<%@ include file="include/header.jsp" %>
<div class="body">
    <%@ include file="include/product-header.jsp" %>
    <div class="title">적금 상품 가입</div>

    <%
        String savingName = request.getParameter("savingName");
        String petName = request.getParameter("petName");
        String joinPeriod = request.getParameter("joinPeriod");
        String endDate = request.getParameter("endDate");
        String accountNumber = request.getParameter("accountNumber");
        String finalAmount = request.getParameter("finalAmount");
        String interestAmount = request.getParameter("interestAmount");
        String rate = request.getParameter("rate");
        String primeRate = request.getParameter("prime_rate");
    %>

    <form>
        <br>
        <div>기본 정보</div>
        <br>
        <table class="table">
            <tr>
                <td class="form-label">출금 계좌번호</td>
                <td>
                    <div style="display: flex">
                        <select class="form-dropdown" id="accountNumberSelection" required onchange="updateBalance()">
                        </select>
                        <div class="color">
                            <div style="display: flex">
                                <div>현재 잔액:</div>
                                <div id="current_balance" style="font-weight: bold"></div>
                            </div>
                            <div style="display: flex">
                                <div>출금 가능 금액:</div>
                                <div id="able_balance" style="font-weight: bold"></div>
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
                                   required>
                            <div id="pwMessage"></div>
                        </div>
                        <button class="Button" id="confirmButton">확인</button>
                    </div>
                </td>
            </tr>
        </table>
        <br>
        <div>상품 정보</div>
        <br>
        <table class="table">
            <tr>
                <td class="form-label">반려견 정보</td>
                <td>
                    <% if (petName != null) { %>
                    <%=petName%>
                    <%} else {%>
                    <select class="form-dropdown" id="petSelection" required>
                        <option selected disabled>반려견을 선택하세요.</option>
                    </select>
                    <%
                        }
                    %>
                </td>
            </tr>
            <tr>
                <td class="form-label">적금 계좌명</td>
                <td>
                    <% if (savingName != null) { %>
                    <%=savingName%>
                    <%} else {%>
                    <input type="text" class="input-form" id="accountName" required>
                    <%
                        }
                    %>
                </td>
            </tr>
            <tr>
                <td class="form-label">이체 주기</td>
                <td>
                    <div class="pe" id="transferCycle" required>
                        <input type="radio" id="period1" name="period" value="매주" checked>
                        <label for="period1">매주</label>
                        <input type="radio" id="period2" name="period" value="매월">
                        <label for="period2">매월</label>
                        <% if (savingName != null) {%>
                        <div style="font-size: 15px; color: var(--primary-color); margin-top: 20px">* 일 단위로 이자를 계산합니다.
                        </div>
                        <% } %>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="form-label">가입 기간</td>
                <td>
                    <% if (joinPeriod != null) { %>
                    <%=joinPeriod%>개월
                    <div id="endDateMessage">적금 만기 예정일은 <%=endDate.split(" ")[0]%> 입니다.</div>
                    <%} else {%>
                    <input type="number" class="input-form" id="joinPeriod"
                           style="text-align: end" required><span
                        id="period_text"></span>
                    <div id="conditionMessage2" class="mt-2 text-danger"></div>
                    <div id="endDateMessage"></div>
                    <%
                        }
                    %>
                </td>
            </tr>
            <tr>
                <td class="form-label">가입 금액</td>
                <td>
                    <div style="display: flex">
                        <input type="text" class="input-form" id="joinAmount" style="text-align: end"
                               onkeyup="inputNumberFormat(this)"
                               required><span style="align-self: center;">원</span>
                        <% if (savingName != null) { %>
                        <div style="display: flex; align-items: center;" id="endAmountWeek">
                            <img src="/resources/img/calculator.png" height="30px"
                                 style="cursor:pointer; margin-left: 40px;">
                            <span style="cursor:pointer;">계산</span>
                        </div>
                        <% } else { %>
                        <div style="display: flex; align-items: center;" id="endAmount">
                            <img src="/resources/img/calculator.png" height="30px"
                                 style="cursor:pointer; margin-left: 40px;">
                            <span style="cursor:pointer;">계산</span>
                        </div>
                        <% } %>
                    </div>
                    <div id="conditionMessage1" class="mt-2 text-danger"></div>

                    <div id="endAmountMessage" style="display: none">
                        <% if (savingName != null) { %>
                        <div style="display: flex">
                            <img src="/resources/img/prior-rate.png" width="40px"
                                 style="margin-top: 30px; margin-right: 5px">
                            <div class="part0"
                                 style="font-size: 20px; margin-top: 40px; font-weight: bold; color: var(--primary-color); "></div>

                        </div>
                        <% } %>
                        <div class="part1 mtb" style="font-size: 22px; margin-top: 45px"></div>
                        <div class="div-1">
                            <div class="mtb">원금:</div>
                            <div class="part2 mtb"></div>
                        </div>
                        <div class="div-1">
                            <div class="mtb">이자:</div>
                            <div class="part3 mtb"></div>
                        </div>

                        <div class="div-1">
                            <div style="margin-top: 20px;"> 이자 과세:</div>
                            <div class="part4 mtb"></div>
                        </div>
                        <div style="width: 58%">
                            <hr>
                        </div>
                        <div class="div-1">
                            <div class="mtb r">총 예상 만기 수령 금액:</div>
                            <div class="part5 mtb r"></div>
                        </div>
                        <div class="part6" style="font-size: 14px; margin-top: 23px"></div>
                        <% if (savingName != null) { %>
                        <div class="part7" style="font-size: 14px; margin-top: 5px"></div>
                        <% } %>
                    </div>
                </td>
            </tr>
            <% if (savingName == null) { %>
            <tr>
                <td class="form-label">적금 계좌 비밀번호</td>
                <td>
                    <div style="display: flex">
                        <div>
                            <div class="password-wrapper">
                                <input type="password" class="input-form" id="savingPassword" pattern="\d*"
                                       maxlength="6" required>
                                <i class="eye-icon fas fa-eye-slash" onclick="togglePasswordVisibility()"></i>
                            </div>

                            <div id="savingPwMessage"></div>
                        </div>
                    </div>
            </tr>
            <% }%>
            <tr>
                <td class="form-label">자동이체 SMS 통보</td>
                <td>
                    <div class="pe" id="transferSMS" required>
                        <input type="radio" id="transferSMSyes" name="transferSMS" value="Y" checked><label
                            for="transferSMSyes">신청함</label>
                        <input type="radio" id="transferSMSno" name="transferSMS" value="N"><label for="transferSMSno">신청안함</label>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="form-label">적금 만기 SMS 통보</td>
                <td>
                    <div class="pe" id="finishSMS" required>
                        <input type="radio" id="finishSMSyes" name="finishSMS" value="Y" checked><label
                            for="finishSMSyes">신청함</label>
                        <input type="radio" id="finishSMSno" name="finishSMS" value="N"><label
                            for="finishSMSno">신청안함</label>
                    </div>
                </td>
            </tr>
        </table>

    </form>
    <div style="text-align: center">
        <button type="button" class="Button" id="joinButton">가입하기</button>
    </div>

    <div class="modal">
        <div class="modal_body">
            <div class="category">
                <img width="42px" id="categoryImg"
                     style="padding-left: 5px; padding-top: 3px; margin-right: 15px;">
                <span id="category" style="font-size: 26px; color: var(--primary-color);}"></span>
            </div>

            <div class="contents">
                <div class="first-content">
                    <img src=""/>
                    <span id="pet-name"></span>
                    <span id="account-name"></span>
                    <span>에 가입되었습니다.</span>
                </div>
                <div class="second-content">
                    <img src="/resources/img/checked.png" width="100px"/>
                </div>
                <div class="third-content" style="padding-bottom: 30px">
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
</div>
<%
    String guest_id = (String) session.getAttribute("guest_id");
    String guest_name = (String) session.getAttribute("name");
    String phone = (String) session.getAttribute("phone");
%>
<script>

    function togglePasswordVisibility() {
        const passwordInput = document.getElementById('savingPassword');
        const eyeIcon = document.querySelector('.eye-icon');

        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            eyeIcon.classList.remove('fa-eye-slash');
            eyeIcon.classList.add('fa-eye');
        } else {
            passwordInput.type = "password";
            eyeIcon.classList.remove('fa-eye');
            eyeIcon.classList.add('fa-eye-slash');
        }
    }

    let flag1 = false;
    let flag2 = false;
    let endDateFormat = null;

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

            if ('<%=petName%>' == 'null') {
                $.ajax({
                    url: '/pets',
                    method: 'GET',
                    data: {
                        guest_id: guest_id
                    },
                    dataType: 'json',
                    success: function (data) {
                        const petSelection = document.getElementById('petSelection');
                        data.forEach(function (pet) {
                            const option = document.createElement('option');
                            option.value = pet.pet_id;
                            option.textContent = pet.name;
                            petSelection.appendChild(option);
                        });
                    },
                    error: function (xhr, status, error) {
                        console.error('Error fetching pet list:', error);
                    }
                });
            }

            $.ajax({
                url: '/depositaccounts',
                method: 'GET',
                data: {
                    guest_id: guest_id
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
                        guest_id: guest_id,
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
            });

            const joinAmountInput = document.getElementById('joinAmount');
            const joinPeriodInput = document.getElementById('joinPeriod');
            const conditionMessage1 = document.getElementById('conditionMessage1');
            const conditionMessage2 = document.getElementById('conditionMessage2');

            const minBalance = parseFloat('${param.min_balance}');
            const minPeriod = parseFloat('${param.min_period}');
            const maxBalance = parseFloat('${param.max_balance}');
            const maxPeriod = parseFloat('${param.max_period}');

            function toggleJoinButton() {
                const joinAmount = parseFloat(joinAmountInput.value.replace(/,/g, ''));
                const joinPeriod = joinPeriodInput ? parseFloat(joinPeriodInput.value) : null;

                let message1 = (joinAmount < minBalance || joinAmount > maxBalance) ? '가입 금액을 확인해주세요.' : '';
                let message2 = (joinPeriod < minPeriod || joinPeriod > maxPeriod) ? '가입 기간을 확인해주세요.' : '';

                conditionMessage1.textContent = message1;
                if (conditionMessage2) {
                    conditionMessage2.textContent = message2;
                }

                flag2 = joinAmount >= minBalance && joinAmount <= maxBalance && (joinPeriod == null ? true : (joinPeriod >= minPeriod && joinPeriod <= maxPeriod));
            }


            function endDate() {
                const joinPeriod = parseInt(joinPeriodInput.value);
                const endDate = calculateEndDate(joinPeriod);
                const endDateMessage = document.getElementById('endDateMessage');
                let message3 = '';
                if (joinPeriod >= minPeriod && joinPeriod <= maxPeriod) {
                    message3 += "적금 만기 예정일은 " + endDate + " 입니다.";
                }
                endDateMessage.textContent = message3;
            }


            function calculateEndDate(months) {
                const today = new Date();
                const endDateFormat = new Date(today);
                endDateFormat.setMonth(today.getMonth() + months);
                const year = endDateFormat.getFullYear();
                const month = String(endDateFormat.getMonth() + 1).padStart(2, '0');
                const day = String(endDateFormat.getDate()).padStart(2, '0');
                return year + '-' + month + '-' + day;
            }

            if (joinPeriodInput) {
                joinPeriodInput.addEventListener('input', toggleJoinButton);
                joinPeriodInput.addEventListener('input', endDate);
            }
            joinAmountInput.addEventListener('input', toggleJoinButton);

            const productInfo = JSON.parse(sessionStorage.getItem("selectedProduct"));

            if (productInfo) {
                $("#productImg").attr("src", "/resources/img/" + productInfo.image);
                $("#productCategory").text(productInfo.category + " 펫 적금");
                $("#categoryImg").attr("src", "/resources/img/" + productInfo.image);
                $("#category").text(productInfo.category + " 적금");
                $("#productDescription").text(productInfo.description);
                $("#productRate").text("금리: " + productInfo.rate);
                $("#productMinPeriod").text("최소 기간: " + productInfo.min_period);
                $("#productMinBalance").text("최소 잔액: " + productInfo.min_balance.toLocaleString());
            }

            function getWeeksBetweenDates(endDate) {
                // 오늘부터 목표 날짜(date)까지의 기간을 계산
                const oneDay = 24 * 60 * 60 * 1000; // 1일의 밀리초 수
                startDate = new Date();
                endDate = new Date(endDate);
                const daysDifference = Math.round((endDate - startDate) / oneDay);

                // 매주 동일한 요일에 돈을 넣을 수 있는 횟수 계산
                let contributions = Math.floor(daysDifference / 7);

                // 오늘이 목표 요일 이후인 경우 한 번 더 넣을 수 있음
                if (startDate.getDay() <= daysDifference % 7) {
                    contributions++;
                }

                return contributions;
            }

            function joinSavingLogic() {
                // 먼저 계좌 번호 생성
                const accountNumber = createAccountNumber();

                var radioButtons = document.getElementsByName('transferSMS');

                var selectedValue = '';

                for (var i = 0; i < radioButtons.length; i++) {
                    if (radioButtons[i].checked) {
                        selectedValue = radioButtons[i].value;
                        break;
                    }
                }
                var radioButtons2 = document.getElementsByName('finishSMS');
                var selectedValue2 = '';

                for (var i = 0; i < radioButtons2.length; i++) {
                    if (radioButtons2[i].checked) {
                        selectedValue2 = radioButtons2[i].value;
                        break;
                    }
                }
                const radioButtons3 = document.getElementsByName('period');
                let selectedValue3 = '';
                for (var i = 0; i < radioButtons3.length; i++) {
                    if (radioButtons3[i].checked) {
                        selectedValue3 = radioButtons3[i].value;
                        break;
                    }
                }

                const selectedOption = document.getElementById('accountNumberSelection').options[document.getElementById('accountNumberSelection').selectedIndex];
                const selectedAccountNumber = selectedOption.textContent.split(" ")[0];
                const amount = document.getElementById('joinAmount').value.replace(/,/g, '')
                const end_date = calculateEndDate(parseInt(joinPeriodInput.value));
                const join_period = joinPeriodInput.value;
                const final_amount_month = String(parseInt(amount) * parseInt(join_period));
                const final_amount_week = String(getWeeksBetweenDates(end_date) * parseInt(amount));

                const requestData = {
                    account_number: accountNumber,
                    join_period: join_period,
                    end_date: end_date,
                    category: JSON.parse(sessionStorage.getItem("selectedProduct")).category,
                    guest_id: '<%= guest_id %>',
                    saving_name: document.getElementById('accountName').value,
                    pet_id: document.getElementById("petSelection").value,
                    sms_transfer: selectedValue,
                    sms_maturity: selectedValue2,
                    deposit_account_number: selectedAccountNumber,
                    period: selectedValue3,
                    amount: amount,
                    contribution_amount: amount,
                    contribution_ratio: 100,
                    final_amount: (selectedValue3 === "매월") ? final_amount_month : final_amount_week,
                    interest_amount: calculateTotalInterest(),
                    saving_pw: document.getElementById('savingPassword').value
                };
                let account_number_parts = selectedAccountNumber.toString().split('-');
                let account_number = account_number_parts[0] + "******" + account_number_parts[3];

                document.getElementById('account-name').textContent = document.getElementById('accountName').value;
                console.log(requestData);
                $.ajax({
                    url: "/join-savingaccounts",
                    type: "POST",
                    data: JSON.stringify(requestData),
                    contentType: 'application/json',
                    success: function (response) {
                        console.log(response)
                        if (response === "적금 생성 성공") {
                            if (requestData.sms_transfer) {
                                let content = '[Web발신]\n[HanaPet]\n' + '<%=guest_name%>님의 출금계좌(' + account_number + ') 자동이체 등록';
                                console.log(content)
                                sendSmsRequest(content)
                                content = '[Web발신]\n[HanaPet]\n' + account_number + '\n출금' + ((Number)(requestData.amount)).toLocaleString() + '원\n자동이체';
                                console.log(content)
                                sendSmsRequest(content)
                            }
                            modal.style.display = "block";
                        } else {
                            console.error("insert 실패");
                        }
                    },
                    error: function () {
                        console.log("Error post.");
                    }
                });

            }

            function sendSmsRequest(content) {
                const requestData = {
                    recipientPhoneNumber: '<%=phone%>',
                    content: content
                };

                fetch('/user/sms', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(requestData)
                })
                    .then(response => response.json())
                    .then(data => {
                        console.log(data);
                    })
                    .catch(error => {
                        console.error('Error sending SMS request:', error);
                        alert('인증번호 전송 중 오류가 발생했습니다.');
                    });
            }

            function joinInvitedSavingLogic() {
                var radioButtons = document.getElementsByName('transferSMS');

                var selectedValue = '';

                for (var i = 0; i < radioButtons.length; i++) {
                    if (radioButtons[i].checked) {
                        selectedValue = radioButtons[i].value;
                        break;
                    }
                }
                var radioButtons2 = document.getElementsByName('finishSMS');

                var selectedValue2 = '';

                for (var i = 0; i < radioButtons2.length; i++) {
                    if (radioButtons2[i].checked) {
                        selectedValue2 = radioButtons2[i].value;
                        break;
                    }
                }
                const radioButtons3 = document.getElementsByName('period');

                let selectedValue3 = '';

                for (var i = 0; i < radioButtons3.length; i++) {
                    if (radioButtons3[i].checked) {
                        selectedValue3 = radioButtons3[i].value;
                        break;
                    }
                }

                const selectedOption = document.getElementById('accountNumberSelection').options[document.getElementById('accountNumberSelection').selectedIndex];
                const selectedAccountNumber = selectedOption.textContent.split(" ")[0];

                const requestData = {
                    guest_id: '<%= guest_id %>',
                    account_number: '<%=accountNumber%>',
                    sms_transfer: selectedValue,
                    sms_maturity: selectedValue2,
                    deposit_account_number: selectedAccountNumber,
                    amount: document.getElementById('joinAmount').value.replace(/,/g, ''),
                    period: selectedValue3,
                    category: JSON.parse(sessionStorage.getItem("selectedProduct")).category,
                    contribution_amount: document.getElementById('joinAmount').value.replace(/,/g, ''),
                    final_amount: finalAmount,
                    interest_amount: interest,
                    pet_name: '<%=petName%>'
                };

                let account_number_parts = selectedAccountNumber.toString().split('-');
                let account_number = account_number_parts[0] + "******" + account_number_parts[3];
                console.log(requestData);
                document.getElementById('account-name').textContent = '<%=savingName%>';
                document.getElementById('pet-name').textContent = '<%=petName%>' + '를 위한 ';
                $.ajax({
                    url: "/join-invited",
                    type: "POST",
                    data: JSON.stringify(requestData),
                    contentType: 'application/json',
                    success: function (response) {
                        console.log(response)
                        if (response === "초대 적금 가입 성공") {
                            if (requestData.sms_transfer) {
                                let content = '[Web발신]\n[HanaPet]\n' + '<%=guest_name%>님의 출금계좌(' + account_number + ') 자동이체 등록';
                                sendSmsRequest(content)
                                content = '[Web발신]\n[HanaPet]\n' + account_number + '\n출금' + ((Number)(requestData.amount)).toLocaleString() + '원\n자동이체';
                                sendSmsRequest(content)
                            }
                            modal.style.display = "block";
                        } else {
                            console.error("초대 적금 가입 실패");
                        }
                    },
                    error: function () {
                        console.log("Error post.");
                    }
                });

            }

            let accountName = "";
            document.getElementById('joinButton').addEventListener('click', function (event) {
                if ('<%=savingName%>' == null) {
                    accountName = document.getElementById("accountName").value;
                } else {
                    accountName = '<%=savingName%>'
                }

                if (flag1 && flag2 && !(accountName.trim() === "")) {
                    if ('<%=petName%>' == 'null') {
                        joinSavingLogic();
                    } else {
                        console.log("들어옴")
                        joinInvitedSavingLogic();
                    }

                } else {
                    if (!flag1) alert("계좌 비밀번호를 확인해주세요.");
                    else if (accountName.trim() === "") alert("적금 계좌명을 입력해주세요.");
                    else alert("가입 조건을 확인해주세요.");
                    event.preventDefault();
                }
            });

            function createAccountNumber() {
                let accountNumber = '343-';
                const digits = '0123456789';
                const random = Math.random;

                for (let i = 0; i < 6; i++) {
                    const digit = Math.floor(random() * 10);
                    accountNumber += digits[digit];
                }

                accountNumber += '-';

                for (let i = 0; i < 5; i++) {
                    const digit = Math.floor(random() * 10);
                    accountNumber += digits[digit];
                }

                return accountNumber;
            }

            function calculateTotalInterest() {
                const startDate = new Date();
                const endDate = new Date($("#endDateMessage").text().split(" ")[3]);
                const amount = document.getElementById('joinAmount').value.replace(/,/g, '');

                const monthlyInterestRate = (parseFloat('<%=rate%>') / 100) / 12;
                const months = (endDate.getFullYear() - startDate.getFullYear()) * 12 + (endDate.getMonth() - startDate.getMonth());

                let totalInterest = 0.0;
                for (let i = 1; i <= months; i++) {
                    totalInterest += (amount * monthlyInterestRate * i);
                }

                console.log(totalInterest);

                return Math.floor(totalInterest);
            }

            const ed = "<%= endDate %>";
            let cnt = 0;

            $.ajax({
                url: '/getCnt',
                method: 'GET',
                data: {
                    account_number: '<%=accountNumber%>'
                },
                dataType: 'json',
                success: function (data) {
                    console.log("cnt" + data);
                    if (cnt < 4) {
                        cnt = data;
                    } else if (cnt >= 4) {
                        cnt = 3;
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error fetching:', error);
                }
            });

            function calculateInterestDaily() {
                const startDate = new Date();
                startDate.setHours(0, 0, 0, 0);
                const endDate = new Date(ed);
                const amount = parseFloat(document.getElementById('joinAmount').value.replace(/,/g, '')); // 입력된 값을 부동 소수점 숫자로 변환

                // 연 이자율을 일 단위 이자율로 변환
                const dailyInterestRate = ((parseFloat('<%=rate%>') + parseFloat('<%=primeRate%>') * cnt) / 100) / 365; // 연 이자율을 365일로 나누어 일 단위로 계산

                // 기간 계산 (일 단위)
                const millisecondsPerDay = 24 * 60 * 60 * 1000;
                const days = Math.floor((endDate - startDate) / millisecondsPerDay) + 1; // 오늘 날짜 포함, 종료 날짜 포함

                // 총 이자 계산
                // 예를 들어 9/18 ~ 10/17 만기라면
                // 1. 9/18 ~ 10/17까지 총 30일 => (amount * dailyInterestRate * 30일)
                // 2. 9/25 ~ 10/17까지 총 23일 => (amount * dailyInterestRate * 23일)
                // ...
                // 5. 10/16 ~ 10/17까지 총 2일 => (amount * dailyInterestRate * 2일)
                // 공식 : (amount *  dailyInterestRate) * (30 + 23 + 16 + 9 + 2)
                // (30 + 23 + 16 + 9 + 2) 이 부분을 표현하면 n부터 7씩 빼면서 더이상 못 뺄 때까지 더하는 공식 -> calculateSum(n)
                const totalInterest = amount * dailyInterestRate * calculateSum(days);

                return Math.floor(totalInterest); // 정수로 버림된 총 이자를 반환
            }

            function calculateSum(n) {
                let sum = 0;
                while (n >= 1) {
                    sum += n;
                    n -= 7;
                }
                return sum;
            }

            $('#endAmount').click(function () {
                const interest = calculateTotalInterest();
                const joinAmount = document.getElementById('joinAmount').value.replace(/,/g, '');
                const joinPeriod = document.getElementById('joinPeriod').value;
                const principal = joinAmount * joinPeriod;
                const real = Math.floor(principal + interest * 0.846);

                let text1 = joinPeriod + '개월 동안 ' + Number(joinAmount).toLocaleString() + '원 적금 시 (연금리 ' + parseFloat('<%=rate%>') + '%)';
                let text2 = Number(principal).toLocaleString() + '원';
                let text3 = ' + ' + Number(interest).toLocaleString() + '원';
                let text4 = ' - ' + Number(Math.ceil(interest * 0.154)).toLocaleString() + '원';
                let text5 = Number(real).toLocaleString() + '원';
                let text6 = '* 일반 과세의 경우는 이자금액의 연 15.4% (이자소득 14% + 주민세 1.4%)가 원천징수됩니다.';

                document.querySelector('#endAmountMessage .part1').textContent = text1;
                document.querySelector('#endAmountMessage .part2').textContent = text2;
                document.querySelector('#endAmountMessage .part3').textContent = text3;
                document.querySelector('#endAmountMessage .part4').textContent = text4;
                document.querySelector('#endAmountMessage .part5').textContent = text5;
                document.querySelector('#endAmountMessage .part6').textContent = text6;

                $('#endAmountMessage').css('display', 'block');
            });

            const interestAmountInt = parseInt('<%= interestAmount %>', 10); // 개설자의 이자금액
            const finalAmountInt = parseInt('<%= finalAmount %>', 10); // 개설자의 총 원금

            let finalAmount = 0;
            let interest = 0;

            $('#endAmountWeek').click(function () {
                let aloneInterest = 0; // 참여자 혼자의 이자율 계산
                let alonePrincipal = 0; // 참여자 혼자의 원금
                const joinAmount = document.getElementById('joinAmount').value.replace(/,/g, ''); // 참여자의 가입 금액

                const radioWeekly = document.getElementById("period1");
                if (radioWeekly.checked) { // 매주일 때
                    aloneInterest = calculateInterestDaily(); // 참여자 혼자의 이자율 계산
                    alonePrincipal = joinAmount * calculateWeeksBetweenDates(); // 참여자 혼자의 원금
                } else { // 매월일 때
                    aloneInterest = calculateTotalInterest();
                    console.log(aloneInterest + "이게 혼자 매월 이자")
                    alonePrincipal = joinAmount * '<%=joinPeriod%>';
                }

                const changeOriginInterest = parseInt(((interestAmountInt * ((parseFloat('<%= rate %>') + parseFloat('<%=primeRate%>>') * cnt))) / ((parseFloat('<%= rate %>') + parseFloat('<%=primeRate%>') * (cnt - 1)))), 10); // 이전에 이자금액 변경 (우대 금리 적용됨)
                finalAmount = finalAmountInt + alonePrincipal; // 최종 원금
                interest = aloneInterest + changeOriginInterest; // 세전 이자금액
                const interestAmount = Math.floor(interest * 0.846); // 세후 이자금액
                const real = finalAmount + interestAmount; // 실제 총 만기 시 금액

                let selectedValue = document.querySelector('input[name="period"]:checked').value;

                let text0 = '${sessionScope.name}님이 공유 적금에 참여하시면, 적금 참여자 총 ' + (cnt + 1) + '명으로 우대 금리 (+ ' + parseFloat(parseFloat('<%=primeRate%>>') * cnt).toFixed(1) + '%) 적용';
                let text1 = '기존 적금 참여자와 함께 ' + selectedValue + ' ' + Number(joinAmount).toLocaleString() + '원 적금 시 (연금리 ' + parseFloat((parseFloat('<%= rate %>') + parseFloat('<%=primeRate%>>') * cnt)).toFixed(1) + '%)';
                let text2 = Number(finalAmount).toLocaleString() + '원';
                let text3 = ' + ' + Number(interest).toLocaleString() + '원';
                let text4 = ' - ' + Number(Math.ceil(interest * 0.154)).toLocaleString() + '원';
                let text5 = Number(real).toLocaleString() + '원';
                let text6 = '* 일반 과세의 경우는 이자금액의 연 15.4% (이자소득 14% + 주민세 1.4%)가 원천징수됩니다.';
                let text7 = '* 만기 수령 시 모든 금액은 적금 개설자의 계좌로 입금됩니다.';

                document.querySelector('#endAmountMessage .part0').textContent = text0;
                document.querySelector('#endAmountMessage .part1').textContent = text1;
                document.querySelector('#endAmountMessage .part2').textContent = text2;
                document.querySelector('#endAmountMessage .part3').textContent = text3;
                document.querySelector('#endAmountMessage .part4').textContent = text4;
                document.querySelector('#endAmountMessage .part5').textContent = text5;
                document.querySelector('#endAmountMessage .part6').textContent = text6;
                document.querySelector('#endAmountMessage .part7').textContent = text7;

                $('#endAmountMessage').css('display', 'block');

            });

            // 오늘부터 적금 만기일까지 주 단위로 납입을 몇번 하는지
            function calculateWeeksBetweenDates() {
                const startDate = new Date();
                const endDate = new Date(ed);

                const millisecondsPerDay = 24 * 60 * 60 * 1000; // 1일의 밀리초 수
                const daysBetween = Math.floor((endDate - startDate) / millisecondsPerDay);

                const targetDayOfWeek = startDate.getDay(); // 시작 날짜의 요일을 가져옴

                let weeks = 0;
                for (let i = 0; i < daysBetween; i++) {
                    if (startDate.getDay() === targetDayOfWeek) {
                        weeks++;
                    }
                    startDate.setDate(startDate.getDate() + 1); // 다음 날짜로 이동
                }
                return weeks;
            }
            updateJoinPeriodLabel();

            function updateJoinPeriodLabel() {
                const radioWeekly = document.getElementById("period1");
                const periodText = document.getElementById("period_text");

                if (radioWeekly.checked) {
                    periodText.innerText = "주";
                } else {
                    periodText.innerText = "개월";
                }
            }

            const radioButtons = document.getElementsByName("period");
            radioButtons.forEach((radio) => {
                radio.addEventListener("change", updateJoinPeriodLabel);
            });

            const confirmButton = document.getElementById("confirmBtn");

            confirmButton.addEventListener("click", () => {
                modal.style.display = "none";
                window.location.href = '/card';
            });
        }
    );


</script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        document.getElementById('petSelection').addEventListener('change', function () {
            var selectedOption = this.options[this.selectedIndex].text;
            document.getElementById('pet-name').textContent = selectedOption + '를 위한 ';
        });
    });
</script>
<script>
    const modal = document.querySelector('.modal');
    const btnOpenPopup = document.querySelector('.btn-open-popup');

    btnOpenPopup.addEventListener('click', () => {
        modal.style.display = 'block';
    });
</script>
<%@ include file="include/footer.jsp" %>