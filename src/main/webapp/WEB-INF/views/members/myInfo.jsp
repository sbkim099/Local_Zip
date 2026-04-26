<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리동네.zip</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="//t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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

.mainTitle{
	min-width:500px;
	font-size: 50px;
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

.backBtnDiv{
	position: relative;
    top: 20px;
    right : 20px;
}

.divTotal {
	padding-top: 60px;
	margin: auto;
	margin-top: 100px;
	width: 1000px;
	height: 570px;
	text-align: center;
	border-radius: 60px;
	background-color: #F2D3A2;
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	position: relative;
	z-index: 1;
}

.labelBox {
	display: flex;
	align-items: center;
	gap: 8px;
	width: 220px;
	font-weight: bold;
}

.form-row {
	display: flex;
	align-items: center;
	margin-bottom: 30px;
	margin-left: 300px;
}

.valueBox {
	display: flex;
	align-items: center;
	gap: 10px;
}

.form-row>div:not(.labelBox) {
	margin-left: 10px;
}

.emptyIcon {
	width: 20px;
	display: inline-block;
}

.icon {
	width: 20px;
	text-align: center;
}

.btnDiv {
	margin-top: 30px;
}

.searchBtn {
	margin-left: 5px;
	margin-top: -3px;
}

.searchBtn, .backBtn {
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	border-radius: 10px;
	font-weight: bold;
}

.updateBtn, .deleteBtn, .completeBtn, .cancelBtn {
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	border-radius: 10px;
	font-weight: bold;
	font-size: medium;
	width: 80px;
	height: 40px;
}

.completeBtn, .cancelBtn, .searchBtn {
	display: none;
}

.updateBtn, .completeBtn {
	margin-right: 30px;
}

.backBtn {
	height: 30px;
	font-weight: bold;
}

.searchBtn:hover, .updateBtn:hover, .deleteBtn:hover, .completeBtn:hover,
.cancelBtn:hover, .backBtn:hover {
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	background-color: #fecc56;
	color: #A66A3F;
	transition: all 0.2s ease;
}

.searchBtn:active, .updateBtn:active, .deleteBtn:active, .completeBtn:active,
.cancelBtn:active, .backBtn:active {
	transform: translateY(2px);
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

hr {
	margin-top: 30px;
	width: 700px;
	border-color: #A66A3F;
}

.leftImg, .rightImg {
	position: absolute;
	width: 400px;
	height: 155px;
	z-index: -1;
	pointer-events: none;
	bottom: 0;
}

.leftImg {
	left: 0;
}

.rightImg {
	right: 0;
}

.swal2-icon.swal2-info .swal2-icon-content {
	font-size: 50px;
	transform: translateY(5px);
	line-height: 70px;
}

.swal2-icon.swal2-question .swal2-icon-content {
	font-size: 50px;
	transform: translateY(5px);
	line-height: 70px;
}

.swal2-icon.swal2-warning .swal2-icon-content {
	font-size: 50px; 
	transform: translateY(5px);
	line-height: 70px;
}

.updateDiv{
	width: 250px;
    display: inline-block;
    white-space: nowrap;
    overflow: hidden;
    vertical-align: middle;
    text-align: left;
}

.updateDiv[contenteditable="true"] {
	border: 1px solid #FFB300;
	border-radius: 5px;
	padding: 5px;
}

.updateDiv[contenteditable="true"]:focus {
	outline: none;
	border: 1px solid #FFB300;
	background-color: #fbe5c0;
}
</style>
</head>
<body>
	<div class="container">
		<div class="topBar">
			<div class="mainTitle">내 정보.zip</div>
			<div class="backBtnDiv">
				<a href="/members/mypage"><input class="backBtn" type="button" value="내.zip으로 가기"></a>
			</div>
		</div>
		<form action="/members/update" method="post" class="frm">
			<div class="divTotal">
				<div class="form-row">
					<div class="labelBox">
						<i class="fa-solid fa-user fa-lg icon"></i> <span class="lavel"> NAME : </span>
					</div>
					<div class="name">${list.mem_name}</div>
				</div>
				<div class="form-row">
					<div class="labelBox">
						<i class="fa-solid fa-address-card fa-lg icon"></i> <span class="lavel"> ID : </span>
					</div>
					<div class="id">${loginId }</div>
				</div>
				<div class="form-row">
					<div class="labelBox">
						<i class="fa-solid fa-envelope fa-lg icon"></i> <span class="lavel"> EMAIL : </span>
					</div>
					<div class="email">${list.mem_email}</div>
				</div>
				<div class="form-row">
					<div class="labelBox">
						<i class="fa-solid fa-user-pen fa-lg icon"></i> <span class="lavel"> NICKNAME : </span>
					</div>
					<div class="nickname updateDiv">${list.mem_nickname}</div>
				</div>
				<div class="form-row">
					<div class="labelBox">
						<i class="fa-solid fa-phone fa-lg icon"></i> <span class="lavel"> PHONE : </span>
					</div>
					<div class="phone updateDiv">${list.mem_phone}</div>
				</div>
				<div class="form-row">
					<div class="labelBox">
						<i class="fa-solid fa-house-chimney fa-lg icon"></i> <span class="lavel"> ZONECODE :</span>
					</div>
					<div class="valueBox">
						<div class="zonecode updateDiv">${list.mem_zip_code}</div>
						<input class="searchBtn save_cancelBtn" type="button" value="찾기">
					</div>
				</div>
				<div class="form-row">
					<div class="labelBox">
						<span class="emptyIcon"></span> <span class="lavel"> ADDRESS : </span>
					</div>
					<div class="address1 updateDiv">${list.mem_address1}</div>
				</div>
				<div class="form-row">
					<div class="labelBox">
						<span class="emptyIcon"></span> <span class="lavel"> DETAIL : </span>
					</div>
					<div class="address2 updateDiv">${list.mem_address2}</div>
				</div>
				<hr>

				<input type="hidden" id="input_nickname" name="mem_nickname"> <input type="hidden" id="input_phone"
					name="mem_phone"> <input type="hidden" id="input_zip_code" name="mem_zip_code"> <input
					type="hidden" id="input_address1" name="mem_address1"> <input type="hidden" id="input_address2"
					name="mem_address2"> <input type="hidden" id="input_dong" name="mem_dong" value="${mem_dong}"> <input
					type="hidden" id="origin_dong" value="${list.mem_dong}"> <input type="hidden" id="mem_id" name="mem_id"
					value="${loginId}">

				<div class="btnDiv">
					<input class="updateBtn update_deleteBtn" type="button" value="정보 수정"> <input
						class="deleteBtn update_deleteBtn" type="button" value="회원 탈퇴"> <input class="completeBtn save_cancelBtn"
						type="submit" value="수정 완료"> <input class="cancelBtn save_cancelBtn" type="button" value="수정 취소">
				</div>
			</div>
		</form>
		<img class="leftImg" src="/resources/images/왼쪽 모서리 풀.png"> <img class="rightImg"
			src="/resources/images/오른쪽 모서리 풀.png">
	</div>

	<script>
    	let origin_dong = "${list.mem_dong}";
    	let nickname = $(".nickname").html();
    	let phone = $(".phone").html();
    	let zip_code = $(".zonecode").html();
    	let address1 = $(".address1").html();
    	let address2 = $(".address2").html();
    	
    	
    	$(".updateBtn").on("click", function(){
    		$(".updateDiv").attr("contenteditable","true");
    		$(".zonecode, .address1").attr("contenteditable","false");
    		
    		$(".updateDiv").css({
    			"background-color": "#fbe5c0",
    			"border":"none",
    			"border-radius": "10px",
    			"word-break": "break-all",
    			"width":"fit-content"
    		})
    		
    		$(".labelBox").css({
    			"display": "flex"
    		})
    		
    		$(".lavel").css({
    	    	"flex-shrink": "0"
    		})
    		
    		$(".update_deleteBtn").css({
    			"display":"none"
   			})
    		
   			$(".save_cancelBtn").css({
   				"display":"inline"
  			})
    	})
    	
    	$(".cancelBtn").on("click", function(){
    		$(".nickname").html(nickname);
    		$(".phone").html(phone);
    		$(".zonecode").html(zip_code);
    		$(".address1").html(address1);
    		$(".address2").html(address2);
    		
    		$(".updateDiv").attr("contenteditable","false");
    		$(".updateDiv").css({
    			"background-color": "#F2D3A2"
    		})
    		
    		$(".update_deleteBtn").css({
    			"display":"inline"
   			})
    		
   			$(".save_cancelBtn").css({
   				"display":"none"
  			})
  			
  			
    	})
    	
    	
    	$(".searchBtn").on("click", function(){
    		new kakao.Postcode({
						oncomplete : function(data) {
							$(".zonecode").html(data.zonecode);
							$(".address1").html(data.roadAddress);
							
							$("#input_zip_code").html(data.zonecode);
							$("#input_address1").html(data.roadAddress);
							$("#input_dong").val(data.bname);
						}
					}).open();
    			})
    	
    	$(".frm").on("submit", function(e){
				e.preventDefault();
				
				// nickname 정규표현식
				let nickname = $(".nickname").text().trim();
				if (nickname == "") {
					Swal.fire({
						icon: "info",
						title: "Wait  !",
						text: "닉네임을 입력해주세요.",
						iconColor: "#FFB300",
						confirmButtonColor: "#FFB300"
					});
					$(".nickname").focus();
					return false;
				} else {
					let regex = /^[가-힣]{2,10}$|^[a-z]{2,10}$/;
					nicknameResult = regex.test(nickname);
					if (!nicknameResult) {
						Swal.fire({
    						icon: "info",
    						title: "Wait  !",
    						text: "공백 없는 2~10글자의 닉네임만 등록 가능합니다.(한/영어 소문자)",
    						iconColor: "#FFB300",
    						confirmButtonColor: "#FFB300"
    					});
						$(".nickname").text("");
						$(".nickname").focus();
						return false;
					}
				}
				
				// phone 정규표현식
				let phone = $(".phone").text().trim();
				if (phone == "") {
					Swal.fire({
						icon: "info",
						title: "Wait  !",
						text: "전화번호를 입력해주세요.",
						iconColor: "#FFB300",
						confirmButtonColor: "#FFB300"
					});
					$(".phone").focus();
					return false;
				} else {
					let regex = /^010[\d]{8}$/;
					let phoneResult = regex.test(phone);
					if (!phoneResult) {
						Swal.fire({
    						icon: "info",
    						title: "Wait  !",
    						text: "연락처 형식은 010********(8자) 입니다.",
    						iconColor: "#FFB300",
    						confirmButtonColor: "#FFB300"
    					});
						$(".phone").text("");
						$(".phone").focus();
						return false;
					}
				}
				
				// zonecode 정규표현식
				let zip_code = $(".zonecode").text().trim();
				if (zip_code == "") {
					Swal.fire({
						icon: "info",
						title: "Wait  !",
						text: "주소를 입력해주세요.",
						iconColor: "#FFB300",
						confirmButtonColor: "#FFB300"
					});
					$(".zonecode").focus();
					return false;
				}
				
				// address1 정규표현식
				let address1 = $(".address1").text().trim();
				let regex = /^(서울)|(서울시)|(서울특별)|(서울특별시)/;
				let address1Result = regex.test(address1);
				if (!address1Result) {
					Swal.fire({
						icon: "info",
						title: "Sorry  !",
						text: "현재는 서울시를 기준으로 한 서비스만 제공 중입니다.",
						iconColor: "#FFB300",
						confirmButtonColor: "#FFB300"
					});
					
					$(".zonecode").text("");
					$(".address1").text("");
					$(".zonecode").focus();
					return false;
				}
				
				if($("#input_dong").val().trim() == ""){
					$("#input_dong").val(origin_dong);
				};
				
	            $("#input_nickname").val($(".nickname").text().trim());
	            $("#input_phone").val($(".phone").text().trim());
	            $("#input_zip_code").val($(".zonecode").text().trim());
	            $("#input_address1").val($(".address1").text().trim());
	            $("#input_address2").val($(".address2").text().trim());
	            
	            this.submit();
		})
		
		$(".deleteBtn").on("click", function(e){
			e.preventDefault();
			
			Swal.fire({
			    icon: "question",
			    title: "Wait  !",
			    text: "정말 탈퇴하시겠습니까? 탈퇴 시 되돌릴 수 없습니다.",
			    iconColor: "#FFB300",
			    confirmButtonColor: "#FFB300",
			    showCancelButton: true,
			    confirmButtonText: "탈퇴",
			    cancelButtonText: "취소",
			    cancelButtonColor: "#d9d9d9"
			}).then((result) => {
		        if (result.isConfirmed) {
		        	Swal.fire({
		                icon: "success",
		                title: "Success  !",
		                text: "탈퇴되었습니다.",
		                iconColor: "#FFB300",
		                confirmButtonColor: "#FFB300"
		             }).then(()  => {
		            	 location.href = "/members/delete"; // 확인 누르면 이동
		             });
		        }
			})
		})
		
		$(document).on("keydown", ".updateDiv[contenteditable='true']", function(e){
			    if(e.key === "Enter"){
			        e.preventDefault(); // 기본 동작 막기
			}
		});
    	
    	
    	// updateDiv에 글자 입력 시 실시간 체크
    	$(document).on("input", ".updateDiv[contenteditable='true']", function() {
    	    let limit = 0;
    	    
    	    // 필드별 글자수 제한 (한 줄에 들어갈 적당한 길이로 조절하세요)
    	    if ($(this).hasClass("nickname")) limit = 10;
    	    else if ($(this).hasClass("phone")) limit = 11;
    	    else if ($(this).hasClass("address2")) limit = 15;
    	    else limit = 20; // 나머지 기본값
    	    
    	    let content = $(this).text();
    	    
    	    // 제한된 글자수보다 길어지면 강제로 자르기
    	    if (content.length > limit) {
    	        $(this).text(content.substring(0, limit));
    	        
    	        let range = document.createRange(); // 글자가 잘린 후 커서가 맨 앞으로 가는 현상 방지 (커서를 맨 뒤로 보냄)
    	        let sel = window.getSelection();
    	        range.selectNodeContents(this);
    	        range.collapse(false);
    	        sel.removeAllRanges();
    	        sel.addRange(range);
    	    }
    	});
		
    </script>
</body>
</html>