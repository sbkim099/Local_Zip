<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리동네.zip</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
	integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2ad57018f836bb74c10d919e862f189a&libraries=clusterer"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script
	src="//t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="icon" type="image/png" sizes="512x512" href="/resources/images/pavicon.png">
</head>

<style>
@font-face {
	font-family: 'GMarketSans';
	src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansLight.woff') format('woff');
	font-weight: 300;
	font-display: swap;
}

@font-face {
	font-family: 'GMarketSans';
	src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
	font-weight: 500;
	font-display: swap;
}

@font-face {
	font-family: 'GMarketSans';
	src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansBold.woff') format('woff');
	font-weight: 700;
	font-display: swap;
}

*{box-sizing: border-box;}

button, body {
	font-family: 'GMarketSans', sans-serif;
}

body {
	margin: 0;
	background-color: #fbe5c0;
}

.container {
	position : relative;
	z-index: 2;
	width: 100%;
}

.mainTitle {
	width: 100%;
	font-weight: bold;
	font-size: 50px;
	color: #A66A3F;
	border-bottom: 2px solid #A66A3F;
	background-color: #F2D3A2;
	height: 100px;
	line-height: 100px;
	display: flex;
	padding: 0 20px;
	justify-content: space-between; 
	align-items: center;
	box-sizing: border-box;
}

.meetingDetail {
	margin: auto;
    width: 1060px;
    border-radius: 10px;
    background-color: #fbe5c0;
    padding: 35px;
 	margin-top: 30px;
    background-color: #F2D3A2;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}

.card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: bold;
    font-size:20px;
    color: #5e361a;
}

.titleDiv, .categoryDiv, .descDiv, .locationDiv, .descTextDiv, .peopleNumDiv{
	padding:10px;
	border-bottom: 1px dotted #A66A3F;
}

.openChatLinkDiv, .openChatPwDiv{
	padding:10px;
}

.descText{
	font-weight: bold;
    font-size: 23px;
    color: #5e361a;
    border: none;
    padding-left: 2px;
}

.descTextDetail{
	padding-top: 10px;
	border: none;
	width: 100%;
	padding-left: 2px;
}

.title, .category, .desc, .location, .openChatLink, .openChatPw, .peopleNum{
	font-weight: bold;
    font-size: 23px;
    color: #5e361a;
}

.categoryDiv{
	display: flex;
    flex-direction: column;
    gap: 8px;
    padding: 10px;
    border-bottom: 1px dotted #A66A3F;
}

.openChatWrapper{
	display:flex;
	gap: 50px;
}

.bottomBtn {
    display: flex;
    justify-content: center;
    gap: 20px;
    margin-top: 20px;
    margin-bottom: 10px;
}

.requestBtn, .backBtn{
	cursor: pointer;
	transition: all 0.2s ease;
	width: 350px;
	height: 40px;
	background-color: #FFB300;
	border: none;
	border-radius: 10px;
	color: #5e361a;
	font-size: 17px;
	font-weight: bold;
	flex-shrink: 0;
}

.requestBtn:hover, .backBtn:hover {
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	background-color: #fecc56;
	color: #A66A3F;
}

.requestBtn:active, .backBtn:active{
	transform: translateY(2px);
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.requestBtn, .backBtn {
	cursor: pointer;
	transition: all 0.2s ease;
}

.clubName{
	width: 100%;
	height: 35px;
	top: 30px;
    left: 0;
    box-shadow: 0 4px 10px rgba(0,0,0,0.2);
    z-index: 10;
    font-family: 'GMarketSans';
    border-radius: 5px;
    background-color: #fbe5c0;
    color: #A66A3F;
    font-size: 12px;
    padding: 2px;
    outline: none;
}

.detailContent{
	width: 100%;
	height: 300px;
	top: 30px;
    left: 0;
    box-shadow: 0 4px 10px rgba(0,0,0,0.2);
    z-index: 10;
    font-family: 'GMarketSans';
    border: 1px solid #A66A3F;
    border-radius: 5px;
    background-color: #fbe5c0;
    color: #A66A3F;
    font-size: 12px;
    padding: 2px;
    outline: none;
}

.categoryGuide{
	font-size: 14px;
  	color: #5e361a;
}

.report{
	width: 200px;
  	height: 32px;
    top: 30px;
    left: 0;
    width: 150px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.2);
    z-index: 10;
    font-family: 'GMarketSans';
    border: 1px solid #A66A3F;
    border-radius: 5px;
    background-color: #F2D3A2;
    color: #A66A3F;
    font-size: 12px;
    padding: 2px;
    outline: none;
}

textarea{
    resize: none;
}

.kakaotalk{
	width: 600px;
	height: 35px;
	top: 30px;
    left: 0;
    box-shadow: 0 4px 10px rgba(0,0,0,0.2);
    z-index: 10;
    font-family: 'GMarketSans';
    border: 1px solid #A66A3F;
    border-radius: 5px;
    background-color: #fbe5c0;
    color: #A66A3F;
    font-size: 12px;
    padding: 2px;
    outline: none;
}

.kakaotalkPw {
	width: 300px;
	height: 35px;
	top: 30px;
    left: 0;
    box-shadow: 0 4px 10px rgba(0,0,0,0.2);
    z-index: 10;
    font-family: 'GMarketSans';
    border: 1px solid #A66A3F;
    border-radius: 5px;
    background-color: #fbe5c0;
    color: #A66A3F;
    font-size: 12px;
    padding: 2px;
    outline: none;
}

#peopleNumber{
	width: 200px;
}

.leftImg, .rightImg{
	position: absolute;
	width: 450px;
	height: 170px;
	z-index: -1;
	pointer-events: none;
	bottom: -300px;
}

.leftImg{
    left: 0;
}

.rightImg{
	right: 0;
}

.swal2-icon.swal2-info .swal2-icon-content {
    font-size: 50px;
    transform: translateY(5px);
    line-height: 70px;
}

.searchDiv{
	display: flex;
	gap: 5px;
}

.searchBtn{
	width: 40px;
    height: 20px;
    background-color: #FFB300;
    border:none;
    border-radius: 10px;
    color: #5e361a;
    font-size: 13px;
    font-weight: bold;
    cursor: pointer;
}
</style>
<body>
<form action="/meeting/meetGenerate" class="frm" method="post" onsubmit="return checkForm();">
	<div class="container">
		<div class="top-section">
			<div class="mainTitle">
			<span>새 모임 만들기</span>
			</div>
			
			<input type="hidden" name="mem_id" value="${loginId}">
			<input type="hidden" name="mem_nickname" value="${nickname}">
			</div>
			
				<div class="meetingDetail">
					<div class="titleDiv">
						<div class="title">모임명</div>
						<div class="titleDetail"><input id="title" name="meet_title" class="clubName" maxlength="50" type="text" style="border: #fbe5c0" placeholder="모임명을 작성해주세요."></div>
					</div>
					
					<div class="categoryDiv">
						<div class="category">카테고리</div>
							<select id="category" name="meet_category" class="report">
								<option value="" class="report-menu">--선택하세요--</option>
								<option value="운동" class="report-menu">운동</option>
								<option value="문화" class="report-menu">문화</option>
								<option value="취미" class="report-menu">취미</option>
								<option value="스터디" class="report-menu">스터디</option>
							</select>
					</div>
					
					<div class="peopleNumDiv">	
						<div class="peopleNum">정원수</div>	
						<div class="peopleNumDetail"><input id="peopleNumber" name="meet_maxpeople" class="clubName" type="number" min="5" max="30" step="1" style="border: #fbe5c0" placeholder="모임의 정원수를 선택해 주세요."></div>
					</div>
					
					<div class="descDiv">
						<div class="desc">간단한 한 줄 소개</div>
						<div class="descDetail"><input id="intro" name="meet_introcontents" class="clubName" maxlength="100" style="border: #fbe5c0" type="text" placeholder="한 줄 소개를 작성해 주세요"></div>
					</div>
					
					<div class="descTextDiv">
						<div class="descText">자세한 소개글</div>
						<div class="descTextDetail"><textarea id="detail" name="meet_detailcontents" class="detailContent" maxlength="500" style="border: #fbe5c0" type="text" placeholder="모임을 소개해 주세요"></textarea></div>
					</div>
					
					<div class="locationDiv">	
						<div class="searchDiv">
							<div class="location">활동지역</div><input type="button" value="찾기" class="searchBtn">
						</div>
						<div class="locationDetail"><input id="address" name="mem_address1" class="clubName" maxlength="33" type="text" style="border: #fbe5c0" placeholder="활동지역을 검색해 주세요" readonly></div>
					</div>
					
					<div class="openChatWrapper">
						<div class="openChatLinkDiv">	
							<div class="openChatLink">카톡 오픈채팅 링크</div>	
							<div class="inputLink"><input id="link" name="meet_kakaolink" class="kakaotalk" maxlength="100" type="text" style="border: #fbe5c0" placeholder="카톡 오픈채팅 링크를 붙여넣어주세요"></div>
						</div>
						
						<div class="openChatPwDiv">
							<div class="openChatPw">카톡 오픈채팅 패스워드</div>
							<div class="inputPw"><input id="pw" name="meet_kakaopw" class="kakaotalkPw" maxlength="8" type="text" style="border: #fbe5c0" placeholder="카톡 오픈채팅 비밀번호를 넣어주세요"></div>
						</div>
					</div>
			</div>
	</div>
		<div class="bottomBtn">
			<button class="requestBtn" type="submit">추가하기</button>
			
			<a href="/meeting/list?category=all"><button class="backBtn" type="button">뒤로가기</button></a>
		</div>
		<div>
			<img class="leftImg" src="/resources/images/왼쪽 모서리 풀.png">
	    	<img class="rightImg" src="/resources/images/오른쪽 모서리 풀.png">
    	</div>
</form>
		
		<script>
		
		// 활동 지역 주소 설정
		let searchBtn = document.getElementsByClassName("searchBtn")[0];
		
		searchBtn.onclick = function() {
			
			new kakao.Postcode({
					oncomplete : function(data) {
						
						// 주소 정규표현식 - 서울시만 생성 가능
						let address = document.getElementById("address");
						let regex = /^(서울|서울시|서울특별|서울특별시)/;
						let addressResult = regex.test(data.roadAddress);
						
						if (!addressResult) {
							Swal.fire({
								icon: "info",
								title: "Sorry  !",
								text: "현재는 서울시를 기준으로 한 서비스만 제공 중입니다.",
								iconColor: "#FFB300",
								confirmButtonColor: "#FFB300"
							});
							address.value = "";
							return;
						}
						document.getElementById("address").value = data.roadAddress;
					}
				}).open();
			}
		
		
		$(".icon").on("click", function (e) {
		    $(".report").css({"display" : "inline"});
		});
		
		function checkForm() {
			let title = document.getElementById("title").value;
			let category = document.getElementById("category").value;
			let peopleNumber = document.getElementById("peopleNumber").value;
			let intro = document.getElementById("intro").value;
			let detail = document.getElementById("detail").value;
			let address = document.getElementById("address").value;
			let link = document.getElementById("link").value;
			let linkInput = document.getElementById("link");
			let pw = document.getElementById("pw").value;
			
			let regex = /^https:\/\/open\.kakao\.com\/o\/[a-zA-Z0-9]+$/;
			
			if(title == ""){
				Swal.fire({
					icon: "info",
					title: "Wait  !",
					text: "모임명을 입력해주세요.",
					iconColor: "#FFB300",
					confirmButtonColor: "#FFB300"
				});
				return false;
			} else if(category == "") {
				Swal.fire({
					icon: "info",
					title: "Wait  !",
					text: "카테고리를 선택해주세요.",
					iconColor: "#FFB300",
					confirmButtonColor: "#FFB300"
				});
				return false;
			} else if(peopleNumber == "") {
				Swal.fire({
					icon: "info",
					title: "Wait  !",
					text: "정원수를 선택해주세요.",
					iconColor: "#FFB300",
					confirmButtonColor: "#FFB300"
				});
				return false;
			} else if(intro == "") {
				Swal.fire({
					icon: "info",
					title: "Wait  !",
					text: "한 줄 소개를 작성해주세요.",
					iconColor: "#FFB300",
					confirmButtonColor: "#FFB300"
				});
				return false;
			} else if(detail == "") {
				Swal.fire({
					icon: "info",
					title: "Wait  !",
					text: "모임 소개를 작성해주세요.",
					iconColor: "#FFB300",
					confirmButtonColor: "#FFB300"
				});
				return false;
			} else if(address == "") {
				Swal.fire({
					icon: "info",
					title: "Wait  !",
					text: "활동 지역을 선택해주세요.",
					iconColor: "#FFB300",
					confirmButtonColor: "#FFB300"
				});
				return false;
			} else if(link == "") {
				Swal.fire({
					icon: "info",
					title: "Wait  !",
					text: "오픈채팅 링크를 넣어주세요.",
					iconColor: "#FFB300",
					confirmButtonColor: "#FFB300"
				});
				return false;
			}else if(!regex.test(link)){
				Swal.fire({
					icon: "info",
					title: "Wait  !",
					text: "카카오톡 링크 형식이 맞지 않습니다.",
					iconColor: "#FFB300",
					confirmButtonColor: "#FFB300"
				});
				linkInput.value = "";
				linkInput.focus();
				return false;
			}else if(pw == "") {
				Swal.fire({
					icon: "info",
					title: "Wait  !",
					text: "오픈채팅 비밀번호를 넣어주세요.",
					iconColor: "#FFB300",
					confirmButtonColor: "#FFB300"
				});
				return false;
			}
			return true;
		}
		
		</script>
</body>
</html>