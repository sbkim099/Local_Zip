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

* {
	box-sizing: border-box;
}

button, body {
	font-family: 'GMarketSans', sans-serif;
}

body {
	margin: 0;
	background-color: #fbe5c0;
}

.container {
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
	width: 1400px;
	border-radius: 10px;
	background-color: #fbe5c0;
	padding: 35px;
	margin-top: 60px;
	background-color: #F2D3A2;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}

.card-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-weight: bold;
	font-size: 20px;
	color: #5e361a;
}

.titleDiv, .categoryDiv, .descDiv, .locationDiv, .descTextDiv {
	padding: 10px;
	border-bottom: 1px dotted #A66A3F;
}

.openChatLinkDiv, .openChatPwDiv {
	padding: 10px;
}

.descText {
	font-weight: bold;
	font-size: 23px;
	color: #5e361a;
	border: none;
	padding-left: 2px;
}

.descTextDetail {
	padding-top: 10px;
	border: none;
	width: 70%;
	padding-left: 2px;
	white-space: pre-wrap;
	word-break: break-all;
}

.title, .category, .desc, .location, .openChatLink, .openChatPw {
	font-weight: bold;
	font-size: 23px;
	color: #5e361a;
}

.categoryDiv {
	display: flex;
	gap: 10px;
}

.inputLink, .inputPw {
	padding: 5px;
	background-color: #fbe5c0;
	border-radius: 10px;
	border: none;
	font-size: 15px;
	width: 400px;
	word-break: break-all;
	white-space: normal;
}

.openChatWrapper {
	display: flex;
	gap: 300px;
}

.openChatPwDiv {
	padding-left: 50px;
}

.categoryDetail {
	display: inline-block;
	line-height: 25px;
	font-size: 12px;
	padding: 3px 8px;
	border-radius: 5px;
	background-color: #FFB300;
	height: 28px;
	color: #3e5e40;
	font-weight: bold;
}

.bottomBtn {
	display: flex;
	justify-content: center;
	gap: 20px;
	margin-top: 20px;
	margin-bottom: 10px;
}

.requestBtn, .backBtn, .myMeetingBtn {
	width: 350px;
	height: 40px;
	background-color: #FFB300;
	border: none;
	border-radius: 10px;
	color: #5e361a;
	font-size: 17px;
	font-weight: bold;
	transition: all 0.2s ease;
	cursor: pointer;
}

.requestBtn:hover, .backBtn:hover, .myMeetingBtn:hover {
   transform: translateY(-3px);
   box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
   background-color: #fecc56;
   color: #A66A3F;
}

.requestBtn:active, .backBtn:active, .myMeetingBtn:active {
	transform: translateY(2px);
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

p {
	font-size: 13px;
	color: #5e361a;
}

.applied-Btn, .joined-Btn {
	width: 350px;
	height: 40px;
	border: none;
	border-radius: 10px;
	background-color: #bebebe;
	color: #5e361a;
	cursor: not-allowed;
	box-shadow: none;
}

.closing-btn {
	width: 350px;
	height: 40px;
	border: none;
	border-radius: 10px;
	background-color: #FF9D6E;
	color: #666;
	cursor: not-allowed;
	box-shadow: none;
}

.leftImg, .rightImg {
	position: absolute;
	width: 450px;
	height: 170px;
	z-index: -1;
	pointer-events: none;
}

.leftImg {
	left: 0;
}

.rightImg {
	right: 0;
}

</style>
</head>
<body>

	<div class="container">
		<div class="top-section">
			<div class="mainTitle">
				<span>모임 상세</span>
			</div>
			
			
		</div>
			<c:forEach var="i" items="${list}">
				<div class="meetingDetail">
					<div class="titleDiv">
						<div class="title">모임명</div>
						<div class="titleDetail">${i.meet_title}</div>
					</div>
					
					<div class="categoryDiv">
						<div class="category">카테고리</div>
						<div class="categoryDetail">${i.meet_category}</div>
					</div>
					
					<div class="descDiv">
						<div class="desc">간단한 한 줄 소개</div>
						<div class="descDetail">${i.meet_introcontents}</div>
					</div>
					
					<div class="descTextDiv">
						<div class="descText">자세한 소개글</div>
						<div class="descTextDetail">${i.meet_detailcontents}</div>
					</div>
					
					<div class="locationDiv">	
						<div class="location">활동지역</div>
						<div class="locationDetail">${i.mem_address1}</div>
					</div>
					
					<div class="openChatWrapper">
						<div class="openChatLinkDiv">	
							<div class="openChatLink">카톡 오픈채팅 링크</div>	
							<div class="inputLink">${i.meet_kakaolink}</div>
						</div>
						
						<div class="openChatPwDiv">
							<div class="openChatPw">카톡 오픈채팅 패스워드</div>
						<c:choose>
							<c:when test="${admin == 1 or count == 1 or host == 1}">
								<div class="inputPw">${i.meet_kakaopw}</div>
							</c:when>
							<c:when test="${admin == 0 or count == 0 or host == 0}">
								<div class="inputPw">******</div>
								<p>＊비밀번호 확인은 모임 승인 또는 참여 후 가능합니다.</p>
							</c:when>
						</c:choose>
						</div>
					</div>
				</div>
				<div class="bottomBtn">
					<c:choose>
						<c:when test="${appliedSet.contains(i.meet_seq)}">
							<button class="applied-Btn" type="button">승인대기중</button>
						</c:when>
						<c:when test="${i.meet_currentpeople >= i.meet_maxpeople}">
					        <button class="closing-btn" disabled>모집마감</button>
					    </c:when>
					    <c:when test="${loginId == i.mem_id or joinedSet.contains(i.meet_seq)}">
							<a href="/meeting/myMeeting"><button class="myMeetingBtn" type="button">내 모임으로 이동</button></a>
						</c:when>
						<c:when test="${loginId != i.mem_id and admin == 0}">
							<button class="requestBtn" type="submit" data-meet-seq="${i.meet_seq}">신청하기</button>
						</c:when>
					</c:choose>
						<a href="/meeting/list?category=${category}&cpage=${cPage}"><button class="backBtn" type="button">뒤로가기</button></a>
				</div>
			</c:forEach>
			
		</div>
		<img class="leftImg" src="/resources/images/왼쪽 모서리 풀.png">
    	<img class="rightImg" src="/resources/images/오른쪽 모서리 풀.png">
		
		<script>
			$(".requestBtn").on("click", function(){
				let meet_seq = $(this).data("meet-seq");
				// 팝업창 크기
				let width = 800;
				let height = 400;
	
			    // window.screenX : 브라우저가 모니터에서 시작하는 위치
			    // window.outerWidth / 2 : 브라우저의 가운데 위치
			    // width / 2 : 팝업의 절반
			    let left = window.screenX + (window.outerWidth / 2) - (width / 2);
			    let top = window.screenY + 80; // 상단에서 80px

			    let popup = window.open(
			    	"/meetingMember/applyForm?meet_seq=" + meet_seq,
			        "",
			        `width=${width},height=${height}`
			    );

			    if (popup) {
			        popup.resizeTo(width, height);
			        popup.moveTo(left, top);
			        popup.focus();
			    } 
			});
		</script>
</body>
</html>