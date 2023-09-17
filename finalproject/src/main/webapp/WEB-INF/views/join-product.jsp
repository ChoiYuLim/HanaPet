<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<head>
    <title>Join-Product</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link rel="stylesheet" href="/resources/css/common.css">
    <link rel="stylesheet" href="/resources/css/join-product.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
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
                            <!-- Ajax로 옵션 추가될 예정 -->
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
                    <input type="text" class="input-form" id="accountName" placeholder="적금 계좌명을 입력해주세요." required>
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
                    </div>
                </td>
            </tr>
            <tr>
                <td class="form-label">가입 기간</td>

                <td>
                    <% if (joinPeriod != null) { %>
                    <%=joinPeriod%>개월
                    <div id="endDateMessage"> 적금 만기 예정일은 <%=endDate.split(" ")[0]%> 입니다.</div>
                    <%} else {%>
                    <input type="number" class="input-form" id="joinPeriod" placeholder="적금 기간을 입력해주세요" required><span
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
                    <input type="number" class="input-form" id="joinAmount" placeholder="금액을 입력해주세요."
                           required><span>원</span>
                    <span onclick="endAmount()" style="cursor:pointer; margin-left: 30px;">계산</span>
                    <div id="conditionMessage1" class="mt-2 text-danger"></div>
                    <div id="endAmountMessage" style="margin-top: 20px;"></div>
                </td>
            </tr>
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

        <!-- 조건 충족 여부에 따른 가입 버튼 -->
        <div style="text-align: center">
            <button type="button" class="Button" id="joinButton">가입하기</button>
        </div>
    </form>

    <div id="myModal" class="modal">
        <%@ include file="include/saving-modal.jsp" %>
    </div>
</div>
</body>

<%
    String guest_id = (String) session.getAttribute("guest_id");
%>
<script>
    let flag1 = false;
    let flag2 = false;
    let endDateFormat = null;

    function calculateTotalInterest() {
        // 시작 날짜와 종료 날짜를 JavaScript Date 객체로 변환
        const startDate = new Date();
        const endDate = new Date($("#endDateMessage").text().split(" ")[3]);
        const amount = document.getElementById('joinAmount').value;

        // 월별 입금 금액 및 연 이자율 설정
        const monthlyInterestRate = (2.5 / 100) / 12;

        // 기간 계산 (월 단위)
        const months = (endDate.getFullYear() - startDate.getFullYear()) * 12 + (endDate.getMonth() - startDate.getMonth());

        // 총 이자 계산
        let totalInterest = 0.0;
        for (let i = 1; i <= months; i++) {
            totalInterest += (amount * monthlyInterestRate * i);
        }

        return totalInterest;
    }

    function endAmount() {
        const interest = calculateTotalInterest();
        const endAmountMessage = document.getElementById('endAmountMessage');
        const joinAmount = document.getElementById('joinAmount').value;
        const joinPeriod = document.getElementById('joinPeriod').value;
        const principal = joinAmount * joinPeriod;
        const real = Math.floor(principal + interest * 0.846);

        let message3 = '원금 ' + joinAmount + '원을 ' + joinPeriod + '개월 동안 적금 시 원금 ' + principal + '원, 이자 ' + interest + '원\n일반 세율 가입 시 총 ' + real + '원을 수령하시게 됩니다. 일반 과세의 경우는 이자금액의 연 15.4% (이자소득 14% + 주민세 1.4%)가 원천징수됩니다.';

        endAmountMessage.textContent = message3;
    }

    $(document).ready(function () {
        var guest_id = '<%= guest_id %>';

        if ('<%=petName%>' == 'null') {
            // Ajax로 강아지 목록 가져와서 옵션 추가
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


        // Ajax로 예금 계좌 목록 가져와서 옵션 추가
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
                    option.textContent = account.account_number;
                    accountNumberSelection.appendChild(option);
                });
                document.getElementById("current_balance").textContent = data[0].balance;
                document.getElementById("able_balance").textContent = data[0].balance;
            },
            error: function (xhr, status, error) {
                console.error('Error fetching account list:', error);
            }
        });

        // Ajax로 예금 계좌 비밀번호 일치 확인
        $("#confirmButton").click(function (event) {
            // 선택된 계좌 옵션의 text 가져오기
            const account_number = $("#accountNumberSelection option:selected").text();
            // 입력한 계좌 비밀번호 가져오기
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


        // 가입 버튼 활성화/비활성화 함수
        function toggleJoinButton() {
            const joinAmount = parseFloat(joinAmountInput.value);
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
            const today = new Date(); // 현재 날짜 가져오기
            const endDateFormat = new Date(today); // 현재 날짜를 복사하여 사용

            endDateFormat.setMonth(today.getMonth() + months); // 월을 더해 몇 개월 후의 날짜 계산

            // 날짜 포맷 설정 (예: "YYYY-MM-DD")
            const year = endDateFormat.getFullYear();
            const month = String(endDateFormat.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1을 해주고 2자리로 포맷
            const day = String(endDateFormat.getDate()).padStart(2, '0'); // 일자를 2자리로 포맷

            return year + '-' + month + '-' + day;
        }

        // 입력 값 변경 시 가입 버튼 상태 업데이트
        if (joinPeriodInput) {
            joinPeriodInput.addEventListener('input', toggleJoinButton);
            joinPeriodInput.addEventListener('input', endDate);
        }
        joinAmountInput.addEventListener('input', toggleJoinButton);


        // 세션에서 제품 정보 가져오기
        const productInfo = JSON.parse(sessionStorage.getItem("selectedProduct"));

        // 제품 정보를 화면에 표시
        if (productInfo) {
            $("#productImg").attr("src", "/resources/img/" + productInfo.image);
            $("#productCategory").text(productInfo.category + " 펫 적금");
            $("#productDescription").text(productInfo.description);
            $("#productRate").text("이자율: " + productInfo.rate);
            $("#productMinPeriod").text("최소 기간: " + productInfo.min_period);
            $("#productMinBalance").text("최소 잔액: " + productInfo.min_balance);
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

            // 라디오 버튼 그룹을 가져옵니다.
            var radioButtons = document.getElementsByName('transferSMS');

            // 선택된 값을 저장할 변수를 선언합니다.
            var selectedValue = '';

            // 라디오 버튼 그룹을 반복하면서 선택된 값을 찾습니다.
            for (var i = 0; i < radioButtons.length; i++) {
                if (radioButtons[i].checked) {
                    selectedValue = radioButtons[i].value;
                    break; // 선택된 값을 찾으면 반복을 종료합니다.
                }
            }
            var radioButtons2 = document.getElementsByName('finishSMS');

            // 선택된 값을 저장할 변수를 선언합니다.
            var selectedValue2 = '';

            // 라디오 버튼 그룹을 반복하면서 선택된 값을 찾습니다.
            for (var i = 0; i < radioButtons2.length; i++) {
                if (radioButtons2[i].checked) {
                    selectedValue2 = radioButtons2[i].value;
                    break; // 선택된 값을 찾으면 반복을 종료합니다.
                }
            }

            const radioButtons3 = document.getElementsByName('period');

            // 선택된 값을 저장할 변수를 선언합니다.
            let selectedValue3 = '';

            // 라디오 버튼 그룹을 반복하면서 선택된 값을 찾습니다.
            for (var i = 0; i < radioButtons3.length; i++) {
                if (radioButtons3[i].checked) {
                    selectedValue3 = radioButtons3[i].value;
                    break; // 선택된 값을 찾으면 반복을 종료합니다.
                }
            }

            const selectedOption = document.getElementById('accountNumberSelection').options[document.getElementById('accountNumberSelection').selectedIndex];
            const selectedAccountNumber = selectedOption.textContent;
            const amount = document.getElementById('joinAmount').value
            const end_date = calculateEndDate(parseInt(joinPeriodInput.value));
            const join_period = joinPeriodInput.value;
            const final_amount_month = String(parseInt(amount) * parseInt(join_period));
            const final_amount_week = String(getWeeksBetweenDates(end_date) * parseInt(amount));

            // 필요한 데이터를 객체로 만들어 전송
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
                interest_amount: calculateTotalInterest()
            };

            // 일단 테스트 완료!!!!!!!!!!!!!!!!!!!!!!!!!

            console.log(requestData);
            $.ajax({
                url: "/join-savingaccounts",
                type: "POST",
                data: JSON.stringify(requestData),
                contentType: 'application/json',
                success: function (response) {
                    console.log(response)
                    if (response === "적금 생성 성공") {
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

        function joinInvitedSavingLogic() {
            // 라디오 버튼 그룹을 가져옵니다.
            var radioButtons = document.getElementsByName('transferSMS');

            // 선택된 값을 저장할 변수를 선언합니다.
            var selectedValue = '';

            // 라디오 버튼 그룹을 반복하면서 선택된 값을 찾습니다.
            for (var i = 0; i < radioButtons.length; i++) {
                if (radioButtons[i].checked) {
                    selectedValue = radioButtons[i].value;
                    break; // 선택된 값을 찾으면 반복을 종료합니다.
                }
            }
            var radioButtons2 = document.getElementsByName('finishSMS');

            // 선택된 값을 저장할 변수를 선언합니다.
            var selectedValue2 = '';

            // 라디오 버튼 그룹을 반복하면서 선택된 값을 찾습니다.
            for (var i = 0; i < radioButtons2.length; i++) {
                if (radioButtons2[i].checked) {
                    selectedValue2 = radioButtons2[i].value;
                    break; // 선택된 값을 찾으면 반복을 종료합니다.
                }
            }

            const radioButtons3 = document.getElementsByName('period');

            // 선택된 값을 저장할 변수를 선언합니다.
            let selectedValue3 = '';

            // 라디오 버튼 그룹을 반복하면서 선택된 값을 찾습니다.
            for (var i = 0; i < radioButtons3.length; i++) {
                if (radioButtons3[i].checked) {
                    selectedValue3 = radioButtons3[i].value;
                    break; // 선택된 값을 찾으면 반복을 종료합니다.
                }
            }

            // accountNumberSelection 요소에서 현재 선택된 옵션을 가져옵니다.
            const selectedOption = document.getElementById('accountNumberSelection').options[document.getElementById('accountNumberSelection').selectedIndex];

            // 선택된 예금 계좌 번호를 가져옵니다.
            const selectedAccountNumber = selectedOption.textContent;

            // 필요한 데이터를 객체로 만들어 전송
            const requestData = {
                guest_id: '<%= guest_id %>',
                account_number: '<%=accountNumber%>',
                sms_transfer: selectedValue,
                sms_maturity: selectedValue2,
                deposit_account_number: selectedAccountNumber,
                amount: document.getElementById('joinAmount').value,
                period: selectedValue3,
                category: JSON.parse(sessionStorage.getItem("selectedProduct")).category,
                contribution_amount: 0,
                contribution_ratio: 0,
            };

            console.log(requestData);

            $.ajax({
                url: "/join-invited",
                type: "POST",
                data: JSON.stringify(requestData),
                contentType: 'application/json',
                success: function (response) {
                    console.log(response)
                    if (response === "초대 적금 가입 성공") {
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

        const modal = document.getElementById("myModal");
        let accountName = "";
        document.getElementById('joinButton').addEventListener('click', function (event) {
            if ('<%=savingName%>' == null) {
                accountName = document.getElementById("accountName").value; // 입력 필드의 값을 가져옵니다.
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
                event.preventDefault(); // 조건을 만족하지 않을 경우 폼 제출 및 페이지 이동 중지
            }
        });

        //모달 내에서 확인 버튼을 클릭하면 모달을 닫는 이벤트 핸들러
        const confirmButton = document.getElementById("confirmBtn");

        confirmButton.addEventListener("click", () => {
            modal.style.display = "none"; // 모달을 화면에서 숨김
            window.location.href = '/card'; // 페이지 이동 처리
        });

        function createAccountNumber() {
            let accountNumber = '';
            const digits = '0123456789';
            const random = Math.random;

            for (let i = 0; i < 14; i++) {
                const digit = Math.floor(random() * 10); // 0부터 9까지의 난수 생성
                accountNumber += digits[digit];
            }

            return accountNumber;
        }

    });

    function updateBalance() {
        // select 요소에서 선택한 값을 가져오기
        const selectedValue = document.getElementById("accountNumberSelection").value;

        // 선택한 값을 # 요소에 표시
        document.getElementById("current_balance").textContent = selectedValue;
        document.getElementById("able_balance").textContent = selectedValue;

        // 계좌 비밀번호 입력창 reset
        document.getElementById('accountPassword').value = "";
        document.getElementById('pwMessage').textContent = "";
        flag1 = false;

    }

    // 라디오 버튼 상태 변경 시 호출되는 함수
    function updateJoinPeriodLabel() {
        const radioWeekly = document.getElementById("period1");
        const periodText = document.getElementById("period_text");

        if (radioWeekly.checked) {
            periodText.innerText = "주";
        } else {
            periodText.innerText = "개월";
        }
    }

    // 페이지 로드 시 초기 호출
    updateJoinPeriodLabel();

    // 라디오 버튼 상태 변경 이벤트 핸들러 등록
    const radioButtons = document.getElementsByName("period");
    radioButtons.forEach((radio) => {
        radio.addEventListener("change", updateJoinPeriodLabel);
    });

</script>