<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리동네.zip</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script
	src="//t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="icon" type="image/png" sizes="512x512" href="/resources/images/pavicon.png">
<style>
@font-face {
	font-family: 'GMarketSans';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansLight.woff')
		format('woff');
	font-weight: 300;
	font-display: swap;
}

@font-face {
	font-family: 'GMarketSans';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff')
		format('woff');
	font-weight: 500;
	font-display: swap;
}

@font-face {
	font-family: 'GMarketSans';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansBold.woff')
		format('woff');
	font-weight: 700;
	font-display: swap;
}

button, body {
	font-family: 'GMarketSans', sans-serif;
	color: #5e361a;
}

body {
	margin: 0;
	background-color: #F2D3A2;
}

.container {
	position : relative;
	z-index: 2;
	width: 100%;
	min-height: 100vh;
	background-color: #fbe5c0;
}

.topBar {
	display: flex;
	padding-left: 20px;
	font-weight: bold;
	color: #A66A3F;
	border-bottom: 2px solid #A66A3F;
	height: 100px;
	line-height: 100px;
	background-color: #F2D3A2;
	justify-content: space-between; 
    align-items: center;
    padding: 0 20px;
	
}

.mainTitle{
	min-width:500px;
	font-size: 50px;
}

.backBtnDiv{
	position: relative;
    top: 20px;
    right : 20px;
}

.divTotal {
	padding-top: 30px;
	margin: auto;
	margin-top: 20px;
	width: 1000px;
	height: 750px;
	text-align: center;
	border-radius: 60px;
	background-color: #F2D3A2;
	box-shadow: 0 6px 15px rgba(0,0,0,0.3);
	position: relative;
    z-index: 1;
}

.form-row {
	display: flex;
	align-items: center;
	margin-bottom: 15px;
}

label {
	width: 120px;
	text-align: right;
	margin-right: 10px;
	margin-left: 230px;
	font-weight: bold;
}

.id, .email, .code {
	margin-right: 10px;
}

.id, .pw1, .pw2, .name, .nickname, .phone, .id_num, .email, .code,
	.zonecode, .address1, .address2 {
	width: 300px;
	padding: 5px;
}

.code {
	margin-left: 89px;
}

.zonecode {
	margin-top: 15px;
	margin-right: 15px;
	width: 100px;
}

.zonecodeLabel {
	margin-top: 15px;
}

.searchBtn {
	margin-top: 15px;
}

.readonly {
	background-color: rgb(232, 190, 127);
}

.agreeBtn {
	width: 15px;
	height: 15px;
	margin-top: 20px;
}

hr {
	margin-top: 20px;
	width: 700px;
	border-color: #A66A3F;
}

.signUpDiv {
	margin-top: 30px;
}

.duplCheck, .signUpBtn, .authCheck, .confirmBtn, .searchBtn, .backBtn {
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	border-radius: 10px;
	font-weight: bold;
}

.signUpBtn {
	height: 40px;
	width: 90px;
}

.agreeDiv {
	font-size: small;
}

.use, .notUse, .correct, .incorrect, .ok, .no, .insertId, .x_id, .doDuplCheck,
.insertPw, .x_pw, .insertName, .x_name, .insertNickname, .x_nickname, .insertPhone, .x_phone,
.insertSsn, .x_ssn, .x_date, .insertZonecode, .insertEmail, .x_email, .applyCode, .usedEmail,
.noApplyCode, .retryEmail {
	display: none;
	font-size: small;
	margin-top: -15px;
}

.use, .correct, .ok, .applyCode, .codeOk {
	color: #286708;
}

.notUse, .incorrect, .no, .insertId, .x_id, .doDuplCheck, .insertPw, .x_pw,
.insertName, .x_name, .insertNickname, .x_nickname, .insertPhone, .x_phone,
.insertSsn, .x_ssn, .insertZonecode, .insertCheckBox, .insertEmail, .x_email, .usedEmail,
.noApplyCode, .retryEmail, .insertCode, .codeNo, .x_date {
	color: #de4f28;
}

.insertCode, .codeOk, .codeNo, .insertCheckBox{
	display: none;
	font-size: small;
}

.duplCheck:hover,
.authCheck:hover,
.confirmBtn:hover,
.searchBtn:hover,
.signUpBtn:hover,
.backBtn:hover{
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0,0,0,0.3);
	background-color: #fecc56;
	color: #A66A3F;
}

.duplCheck:active,
.authCheck:active,
.confirmBtn:active,
.searchBtn:active,
.signUpBtn:active,
.backBtn:active{
	transform: translateY(2px);
	box-shadow: 0 2px 5px rgba(0,0,0,0.2);
}

.duplCheck, .authCheck, .confirmBtn, .searchBtn, .signUpBtn, .backBtn{
	cursor: pointer;
	transition: all 0.2s ease;
}

.leftImg, .rightImg{
	position: absolute;
	width: 400px;
	height: 155px;
	z-index: -1;
	pointer-events: none;
	bottom: 0;
}

.leftImg{
    left: 0;
}

.rightImg{
	right: 0;
}

input{
	outline: none;
}

a {
    color:#FF8200;
}

.swal2-icon.swal2-info .swal2-icon-content {
	font-size: 50px;
	transform: translateY(5px);
	line-height: 70px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="topBar">
			<div class="mainTitle">우리 동네.zip 회원가입</div>
			<div class="backBtnDiv">
				<a href="/"><input class="backBtn" type="button" value="뒤로가기"></a>
			</div>
		</div>
		<form action="/members/signup" class="frm">
			<div class="divTotal">
				<div class="form-row">
					<label>· ID : </label> <input name="mem_id" class="id" type="text"
						placeholder="아이디를 입력해주세요. [필수]"> <input class="duplCheck"
						type="button" value="중복확인">
				</div>
				<div class="use">중복되지 않은 아이디입니다.</div>
				<div class="notUse">이미 사용 중인 아이디입니다.</div>
				<div class="insertId">아이디를 입력해주세요.</div>
				<div class="x_id">아이디를 다시 설정해주세요. 4~12자의 영문 소문자, 숫자, 언더바만 사용 가능</div>
				<div class="doDuplCheck">아이디 중복확인을 해주세요.</div>
				
				<div class="form-row">
					<label>· PW : </label> <input name="mem_password" class="pw1"
						type="password" placeholder="비밀번호를 입력해주세요. [필수]">
				</div>
				<div class="form-row">
					<label>· PW 확인 : </label> <input class="pw2" type="password"
						placeholder="비밀번호를 동일하게 입력해주세요. [필수]">
				</div>
				<div class="correct">비밀번호가 일치합니다.</div>
				<div class="incorrect">비밀번호가 일치하지 않습니다.</div>
				<div class="insertPw">비밀번호를 입력해주세요.</div>
				<div class="x_pw">비밀번호를 다시 설정해주세요. 8~16자의 영문 대소문자,숫자,특수문자(!@#$%^&*) 사용 가능</div>
				
				<div class="form-row">
					<label>· NAME : </label> <input name="mem_name" class="name"
						type="text" placeholder="이름을 입력해주세요. [필수]">
				</div>
				<div class="insertName">이름을 입력해주세요.</div>
				<div class="x_name">공백 없는 2~10글자의 이름만 등록 가능합니다.(한/영어 소문자)</div>
				
				<div class="form-row">
					<label>·NICKNAME : </label> <input name="mem_nickname"
						class="nickname" type="text" placeholder="닉네임을 입력해주세요. [필수]">
				</div>
				<div class="insertNickname">닉네임을 입력해주세요.</div>
				<div class="x_nickname">공백 없는 2~10글자의 닉네임만 등록 가능합니다.(한/영어 소문자)</div>
				
				<div class="form-row">
					<label>· PHONE : </label> <input name="mem_phone" class="phone"
						type="text" placeholder="휴대폰 번호를 입력해주세요. ('-' 제외) [필수]">
				</div>
				<div class="insertPhone">연락처를 입력해주세요.</div>
				<div class="x_phone">연락처 형식은 010********(8자) 입니다.</div>
				
				<div class="form-row">
					<label>·ID NUMBER : </label> <input name="mem_ssn" class="id_num"
						type="text" placeholder="주민등록번호를 입력해주세요. ('-' 포함) [필수]">
				</div>
				<div class="insertSsn">주민등록번호를 입력해주세요.</div>
				<div class="x_ssn">주민등록번호 형식이 맞지 않습니다.</div>
				<div class="x_date">존재하지 않는 날짜입니다. 다시 입력해주세요.</div>
				
				<div class="form-row">
					<label>· EMAIL : </label> <input name="mem_email" class="email"
						type="text" placeholder="이메일 주소를 입력해주세요. [필수]">
						
						<input class="authCheck" type="button" value="인증번호 전송">
				</div>
				<div class="insertEmail">이메일 주소를 입력해주세요.</div>
				<div class="x_email">잘못된 이메일 형식입니다.</div>
				<div class="applyCode">이메일로 인증번호를 발송했습니다.</div>
				<div class="usedEmail">이미 사용되고 있는 이메일입니다. 다른 이메일을 입력해주세요.</div>
				<div class="noApplyCode">인증번호 발송 실패했습니다.</div>
				<div class="retryEmail">이메일 인증이 완료되지 않았거나 만료되었습니다. 다시 인증해주세요.</div>
				
				<div>
					<input class="code" type="text" placeholder="인증번호를 입력해주세요. [필수]">
					<input class="confirmBtn" type="button" value="인증">
				</div>
				<div class="insertCode">인증코드를 입력해주세요.</div>
				<div class="codeOk">인증되었습니다.</div>
				<div class="codeNo">인증에 실패했습니다. 다시 시도해주세요.</div>
				
				<div class="form-row">
					<label class="zonecodeLabel">·ZONECODE:</label> <input
						name="mem_zip_code" class="zonecode readonly" type="text" readonly placeholder="필수">
					<input class="searchBtn" type="button" value="찾기">
				</div>
				<div class="insertZonecode">우편번호 찾기를 눌러주세요.</div>
				
				
				<div class="form-row">
					<label>· ADDRESS :</label> <input name="mem_address1"
						class="address1 readonly" type="text" readonly placeholder="필수">
				</div>
				
				<div class="form-row">
					<label>· DETAIL :</label> <input name="mem_address2"
						class="address2" type="text" placeholder="상세 주소(최대15자)를 입력해주세요.(선택사항)" maxlength="15">
				</div>
				
				<input type="hidden" name="mem_dong" class="dong">
				
				<div class="agreeDiv">
					<input class="agreeBtn" type="checkbox"> [필수] I agree to the
					<a href="#" onclick="openPopup(); return false;">Terms of Use and Privacy Policy</a>
				</div>
				<div class="insertCheckBox">약관동의는 필수입니다.</div>
				
				<hr>
				<div class="signUpDiv">
					<button class="signUpBtn">Sign Up</button>
				</div>
			</div>
		</form>
		
		<img class="leftImg" src="/resources/images/왼쪽 모서리 풀.png">
    	<img class="rightImg" src="/resources/images/오른쪽 모서리 풀.png">
	</div>

	<script>
		// id 중복체크 기능
		let idChecked = false;

		$(".duplCheck").on("click", function() {
			if ($(".id").val() == "") {
				$(".insertId").show();
				$(".doDuplCheck").hide();
				$(".use").hide();
				$(".notUse").hide();
				$(".x_id").hide();
				return false;
			} else {
				$.ajax({
					url : "/members/duplCheck",
					dataType : "json",
					data : {
						mem_id : $(".id").val()
					}
				}).done(function(resp) {
					if (resp == "0") {
						$(".insertId").hide();
						$(".use").show();
						$(".notUse").hide();
						$(".doDuplCheck").hide();
						$(".x_id").hide();
						idChecked = true;
					} else {
						$(".insertId").hide();
						$(".notUse").show();
						$(".use").hide();
						$(".doDuplCheck").hide();
						$(".x_id").hide();
						idChecked = false;
					}
				});
			}
		});

		$(".id").on("input", function() {
			idChecked = false;
			$(".use").hide();
			$(".notUse").hide();
			$(".insertId").hide();
			$(".doDuplCheck").hide();
			$(".x_id").hide();
		});
		
		let pw1 = document.getElementsByClassName("pw1")[0];
		let pw2 = document.getElementsByClassName("pw2")[0];
		
		$(".pw2").on("input", function() {
			$(".correct").hide();
			$(".incorrect").show();
			$(".insertPw").hide();
			$(".x_pw").hide();
			
			if (pw1.value != pw2.value) {
				$(".insertPw").hide();
				$(".correct").hide();
				$(".incorrect").show();
				$(".x_pw").hide();
			}else {
				$(".insertPw").hide();
				$(".correct").show();
				$(".incorrect").hide();
				$(".x_pw").hide();
			}
		});
		
		$(".name").on("input", function() {
			$(".insertName").hide();
			$(".x_name").hide();
		});
		
		$(".nickname").on("input", function() {
			$(".insertNickname").hide();
			$(".x_nickname").hide();
		});
		
		$(".phone").on("input", function() {
			$(".insertPhone").hide();
			$(".x_phone").hide();
		});
		
		$(".id_num").on("input", function() {
			$(".insertSsn").hide();
			$(".x_ssn").hide();
			$(".x_date").hide();
		});
		
		$(".email").on("input", function() {
			$(".insertEmail").hide();
			$(".x_email").hide();
			$(".applyCode").hide();
			$(".usedEmail").hide();
			$(".noApplyCode").hide();
			$(".retryEmail").hide();
			
			$(".insertCode").hide();
			$(".codeOk").hide();
			$(".codeNo").hide();
			$(".code").val("");
		});
		
		$(".code").on("input", function() {
			$(".insertCode").hide();
			$(".codeOk").hide();
			$(".codeNo").hide();
		});
		
		$(".searchBtn").on("click", function() {
			$(".insertZonecode").hide();
		});
		
		$(".agreeBtn").on("click", function() {
			$(".insertCheckBox").hide();
		});
		
		//인증번호 전송
		$(".authCheck").on("click", function() {
			if ($(".email").val() == "") {
				$(".insertEmail").show();
				$(".x_email").hide();
				$(".applyCode").hide();
				$(".usedEmail").hide();
				$(".noApplyCode").hide();
				$(".retryEmail").hide();
				return false;
			} else {
				$.ajax({
					url : "/auth/mailCheck",
					type: "post",
					data : {
						email : $(".email").val(),
						auth_type : 1
					}
				}).done(function(resp) {
					if (resp == "success") {
						$(".insertEmail").hide();
						$(".x_email").hide();
						$(".applyCode").show();
						$(".usedEmail").hide();
						$(".noApplyCode").hide();
						$(".retryEmail").hide();
					}else if(resp == "duplicate"){
						$(".insertEmail").hide();
						$(".x_email").hide();
						$(".applyCode").hide();
						$(".usedEmail").show();
						$(".noApplyCode").hide();
						$(".retryEmail").hide();
					} else {
						$(".insertEmail").hide();
						$(".x_email").hide();
						$(".applyCode").hide();
						$(".usedEmail").hide();
						$(".noApplyCode").show();
						$(".retryEmail").hide();
					}
				});
			}
		});

		//인증번호 확인
		$(".confirmBtn").on("click", function() {
			if($(".code").val() == ""){
				$(".insertCode").show();
				$(".codeOk").hide();
				$(".codeNo").hide();
			}else{
				$.ajax({
					url : "/auth/verify",
					type: "post",
					data : {
						email : $(".email").val(),
						auth_code : $(".code").val()
					}
				}).done(function(resp) {
					if (resp == "success") {
						$(".insertCode").hide();
						$(".codeOk").show();
						$(".codeNo").hide();
					} else {
						$(".insertCode").hide();
						$(".codeOk").hide();
						$(".codeNo").show();
					}
				});
			}
		});
		
		// 주소(찾기)
		let searchBtn = document.getElementsByClassName("searchBtn")[0];
		searchBtn.onclick = function() {
			new kakao.Postcode(
					{
						oncomplete : function(data) {
							document.getElementsByClassName("zonecode")[0].value = data.zonecode;
							document.getElementsByClassName("address1")[0].value = data.roadAddress;
							document.getElementsByClassName("dong")[0].value = data.bname;
						}
					}).open();
			let insertZonecode = document.getElementsByClassName(".insertZonecode")[0];
			insertZonecode.style.display = "none";
		}

		// 정규표현식 검사
		let frm = document.getElementsByClassName("frm")[0];
		frm.onsubmit = function(e) {
			//기본 제출 막기
			
			// id
			let id = document.getElementsByClassName("id")[0];
			
			if (id.value == "") {
				$(".insertId").show();
				$(".use").hide();
				$(".notUse").hide();
				$(".x_id").hide();
				$(".doDuplCheck").hide();
				
				id.focus();
				return false;
			} else {
				let regex = /^[a-z\d_]{4,12}$/;
				let idResult = regex.test(id.value);
				if (!idResult) {
					$(".x_id").show();
					$(".insertId").hide();
					$(".use").hide();
					$(".notUse").hide();
					$(".doDuplCheck").hide();
					
					id.value = "";
					id.focus();
					return false;
				}
			}

			if (!idChecked) {
				$(".doDuplCheck").show();
				$(".x_id").hide();
				$(".insertId").hide();
				$(".use").hide();
				$(".notUse").hide();
				return false;
			}

			// pw
			let pw1 = document.getElementsByClassName("pw1")[0];
			let pw2 = document.getElementsByClassName("pw2")[0];

			if (pw1.value == "" || pw2.value == "") {
				$(".insertPw").show();
				$(".correct").hide();
				$(".incorrect").hide();
				$(".x_pw").hide();
				return false;
			} else {
				let regex = /^[A-Za-z\d!@#$%^&*]{8,16}$/;
				let pwResult = regex.test(pw1.value);
				if (!pwResult) {
					$(".insertPw").hide();
					$(".correct").hide();
					$(".incorrect").hide();
					$(".x_pw").show();
					pw1.value = "";
					pw1.focus();
					return false;
				}else if (pw1.value != pw2.value) {
					$(".insertPw").hide();
					$(".correct").hide();
					$(".incorrect").show();
					$(".x_pw").hide();
					return false;
				}else{
					$(".insertPw").hide();
					$(".correct").show();
					$(".incorrect").hide();
					$(".x_pw").hide();
				}
			}

			// name
			let name = document.getElementsByClassName("name")[0];
			if (name.value == "") {
				$(".insertName").show();
				$(".x_name").hide();
				name.focus();
				return false;
			} else {
				let regex = /^[가-힣]{2,10}$|^[a-z]{2,10}$/;
				nameResult = regex.test(name.value);
				if (!nameResult) {
					$(".insertName").hide();
					$(".x_name").show();
					name.value = "";
					name.focus();
					return false;
				}
			}

			// nickname
			let nickname = document.getElementsByClassName("nickname")[0];
			if (nickname.value == "") {
				$(".insertNickname").show();
				$(".x_nickname").hide();
				name.focus();
				return false;
			} else {
				let regex = /^[가-힣]{2,10}$|^[a-z]{2,10}$/;
				nicknameResult = regex.test(nickname.value);
				if (!nicknameResult) {
					$(".insertNickname").hide();
					$(".x_nickname").show();
					nickname.value = "";
					nickname.focus();
					return false;
				}
			}

			// phone
			let phone = document.getElementsByClassName("phone")[0];
			if (phone.value == "") {
				$(".insertPhone").show();
				$(".x_phone").hide();
				phone.focus();
				return false;
			} else {
				let regex = /^010[\d]{8}$/;
				let phoneResult = regex.test(phone.value);
				if (!phoneResult) {
					$(".insertPhone").hide();
					$(".x_phone").show();
					phone.value = "";
					phone.focus();
					return false;
				}
			}

			// ssn
			let ssn = document.getElementsByClassName("id_num")[0];
			
			function isValidBirthDate(ssn) {
			    const birth = ssn.substring(0, 6);

			    let year = parseInt(birth.substring(0, 2));
			    let month = parseInt(birth.substring(2, 4));
			    let day = parseInt(birth.substring(4, 6));

			    const genderCode = ssn.charAt(7);

			    if (genderCode === "1" || genderCode === "2") {
			        year += 1900;
			    } else if (genderCode === "3" || genderCode === "4") {
			        year += 2000;
			    }

			    const date = new Date(year, month - 1, day);

			    return (
			        date.getFullYear() === year &&
			        date.getMonth() === month - 1 &&
			        date.getDate() === day
			    );
			}
			
			if (ssn.value == "") {
				$(".insertSsn").show();
				$(".x_ssn").hide();
				$(".x_date").hide();
				ssn.focus();
				return false;
			} else {
				let regex = /^(\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01]))-[1-4]\d{6}$/;
				let ssnResult = regex.test(ssn.value);
				if (!ssnResult) {
					$(".insertSsn").hide();
					$(".x_ssn").show();
					$(".x_date").hide();
					ssn.value = "";
					ssn.focus();
					return false;
				}
				if (!isValidBirthDate(ssn.value)) {
			        $(".insertSsn").hide();
			        $(".x_ssn").hide();
			        $(".x_date").show();
			        ssn.value = "";
			        ssn.focus();
			        return false;
			    }
			}

			// email
			let email = document.getElementsByClassName("email")[0];

			if (email.value == "") {
				$(".insertEmail").show();
				$(".x_email").hide();
				$(".applyCode").hide();
				$(".usedEmail").hide();
				$(".noApplyCode").hide();
				$(".retryEmail").hide();
				email.focus();
				return false;
			} else {
				let regex = /^[a-z\d_]+@[a-z]+\.[a-z]+\.?[a-z]+?$/;
				let emailResult = regex.test(email.value);
				if (!emailResult) {
					$(".insertEmail").hide();
					$(".x_email").show();
					$(".applyCode").hide();
					$(".usedEmail").hide();
					$(".noApplyCode").hide();
					$(".retryEmail").hide();
					email.value = "";
					email.focus();
					return false;
				}
			}

			// code
			let code = document.getElementsByClassName("code")[0];
			if (code.value == "") {
				$(".insertCode").show();
				$(".codeOk").hide();
				$(".codeNo").hide();
				code.focus();
				return false;
			}

			// zonecode
			let zonecode = document.getElementsByClassName("zonecode")[0];
			if (zonecode.value == "") {
				$(".insertZonecode").show();
				zonecode.focus();
				return false;
			}
			
			// address1 - 서울시만 가입 가능
			let address1 = document.getElementsByClassName("address1")[0];
			let regex = /^(서울)|(서울시)|(서울특별)|(서울특별시)/;
			let address1Result = regex.test(address1.value);
			if (!address1Result) {
				Swal.fire({
					icon: "info",
					title: "Sorry  !",
					text: "현재는 서울시 기준으로만 서비스를 제공 중입니다.",
					iconColor: "#FFB300",
					confirmButtonColor: "#FFB300"
				});
				zonecode.value = "";
				address1.value = "";
				return false;
			}
			
			// agreeBtn
			let agreeBtn = document.getElementsByClassName("agreeBtn")[0];
			if (!agreeBtn.checked) {
				$(".insertCheckBox").show();
				agreeBtn.focus();
				return false;
			}
			
			//이메일 인증 최종확인(회원가입 버튼 눌렀을 때)
			$.ajax({
				url : "/auth/isVerified",
				type : "post",
				data : {email : $(".email").val()}
			}).done(function(resp){
				if(resp=="1"){
					Swal.fire({
						icon: "success",
						title: "Welcome  !",
						text: "회원가입을 축하드립니다.",
						iconColor: "#FFB300",
						confirmButtonColor: "#FFB300"
					}).then((result) => {
						if(result.isConfirmed) {
							frm.submit();
						}
					});
					
				}else{
					$(".insertEmail").hide();
					$(".x_email").hide();
					$(".applyCode").hide();
					$(".usedEmail").hide();
					$(".noApplyCode").hide();
					$(".retryEmail").show();
				}
			});
			return false;
		}
		
		function openPopup() {
			var width = 605;
		    var height = 730;
			
		    // 중앙 정렬
		    var left = window.screenX + (window.outerWidth / 2) - (width / 2);
		    var top = window.screenY + (window.outerHeight / 2) - (height / 2);
			
			window.open(
		        "/members/terms",
		        "termsPopUp",
		        "width="+ width + ",height=" + height + ",left=" + left + ",top="+ top + ",resizable=no,scrollbars=no"
		    );
		}
	</script>
</body>
</html>