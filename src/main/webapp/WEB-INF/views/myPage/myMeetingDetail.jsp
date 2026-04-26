<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리동네.zip</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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

*{box-sizing: border-box;}

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
    width: 70%;
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
    font-size:20px;
    color: #5e361a;
}

.titleDiv, .categoryDiv, .descDiv, .locationDiv, .descTextDiv{
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
	width: 70%;
	padding-left: 2px;
	white-space: pre-wrap;
	word-break: break-all;
}

.title, .category, .desc, .location, .openChatLink, .openChatPw{
	font-weight: bold;
    font-size: 23px;
    color: #5e361a;
}

.categoryDiv{
	display:flex;
	gap:10px;
}

.inputLink, .inputPw{
	padding:5px;
	background-color: #fbe5c0;
	border-radius: 10px;
	border:none;
	font-size:15px;
	width: 400px;
	word-break: break-all;
	white-space: normal; 
}

.openChatWrapper{
	display:flex;
	gap: 300px;
}

.openChatPwDiv{
	padding-left: 50px;
}

.categoryDetail {
    display: inline-block;
    line-height : 25px;
    font-size: 12px;
    padding: 3px 8px;
    border-radius: 5px;
    background-color: #FFB300;
    height: 28px;
    color: #3e5e40;
    font-weight: bold;
}

.bottomBtn {
    margin-top: 20px;
    margin-bottom: 10px;
    margin-left: 600px;
    align-items: center;
}

.backBtn, .updateBtn, .completeBtn, .cancelBtn{
	width: 350px;
    height: 40px;
    background-color: #FFB300;
    border:none;
    border-radius: 10px;
    color: #5e361a;
    font-size: 17px;
    font-weight: bold;
    cursor: pointer;
	transition: all 0.2s ease;
}

.backBtn:hover, .updateBtn:hover,
.completeBtn:hover, .cancelBtn:hover {
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	background-color: #fecc56;
	color: #A66A3F;
}

.backBtn:active, .updateBtn:active,
.completeBtn:active, .cancelBtn:active {
	transform: translateY(2px);
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.completeBtn, .cancelBtn{
	display: none;
}

.leftImg, .rightImg{
	width: 450px;
	height: 170px;
	z-index: 10;
	position: absolute;
}

.leftImg{
    left: 0;
}

.rightImg{
	right: 0;
}

.updateDiv[contenteditable="true"]{
	border: 1px solid #FFB300;
	border-radius: 5px;
	padding: 5px;
}

.updateDiv[contenteditable="true"]:focus {
	outline: none;
	border: 1px solid #FFB300;
}
</style>
</head>
<body>
<form class="frm" action="/meeting/update" method="post">
		<div class="container">
			<div class="top-section">
				<div class="mainTitle">
					<span>모임 상세</span>
				</div>
				
				
			</div>
				<c:forEach var="i" items="${list}">
					<div class="meetingDetail" data-seq="${i.meet_seq}">
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
							<div class="descTextDetail updateDiv">${i.meet_detailcontents}</div>
						</div>
						
						<div class="locationDiv">	
							<div class="location">활동지역</div>	
							<div class="locationDetail">${i.mem_address1}</div>
						</div>
						
						<div class="openChatWrapper">
							<div class="openChatLinkDiv">	
								<div class="openChatLink">카톡 오픈채팅 링크</div>	
								<div class="inputLink updateDiv">${i.meet_kakaolink}</div>
							</div>
							
							<div class="openChatPwDiv">
								<div class="openChatPw">카톡 오픈채팅 패스워드</div>
								<div class="inputPw updateDiv">${i.meet_kakaopw}</div>
							</div>
						</div>
					</div>
				</c:forEach>
		</div>
		<input type="hidden" class="seqInput" name="seq">
		<input type="hidden" class="update_contents" name="meet_detailcontents">
		<input type="hidden" class="update_kakaolink" name="meet_kakaolink">
		<input type="hidden" class="update_kakaopw" name="meet_kakaopw">
		<div class="bottomBtn">
			<c:forEach var="i" items="${list}">
				<c:choose>
					<c:when test="${i.mem_id == loginId }">
						<button class="updateBtn" type="button">수정하기</button>
						<button class="completeBtn" type="button">수정완료</button>
						<button class="cancelBtn" type="button">수정취소</button>
						<button class="backBtn" type="button">뒤로가기</button>
					</c:when>
					<c:otherwise>
						<button class="backBtn" type="button" style="margin-left:180px">뒤로가기</button>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
	</form>
	<img class="leftImg" src="/resources/images/왼쪽 모서리 풀.png">
	<img class="rightImg" src="/resources/images/오른쪽 모서리 풀.png">	
	<script>
		let meet_detailcontents = $(".descTextDetail");
		let meet_kakaolink = $(".inputLink");
		let meet_kakaopw = $(".inputPw");
		
		$(".updateBtn").on("click",function(){
			
			meet_detailcontents.data("originContents", meet_detailcontents.html());
			meet_kakaolink.data("originLink", meet_kakaolink.html());
			meet_kakaopw.data("originPw", meet_kakaopw.html());
			
			$(".updateBtn").css({"display":"none"});
			$(".backBtn").css({"display":"none"});
			$(".completeBtn").css({"display":"inline"});
			$(".cancelBtn").css({"display":"inline"});
			
			$(".updateDiv").attr("contenteditable","true");
		});
		
		$(".cancelBtn").on("click",function(){
			
			let originContents = meet_detailcontents.data("originContents");
			let originLink = meet_kakaolink.data("originLink");
			let originPw = meet_kakaopw.data("originPw");
			
			meet_detailcontents.html(originContents);
			meet_kakaolink.html(originLink);
			meet_kakaopw.html(originPw);
			
			$(".updateBtn").css({"display":"inline"});
			$(".backBtn").css({"display":"inline"});
			$(".completeBtn").css({"display":"none"});
			$(".cancelBtn").css({"display":"none"});
			
			$(".updateDiv").removeAttr("contenteditable");
		});

		$(document).on("click", ".completeBtn", function(e){
			e.preventDefault();
			// 1. 데이터 추출
	   	    let contents = $(".descTextDetail").html();
	   	    let kakaolink = $(".inputLink").html();
	   	 	let kakaopw = $(".inputPw").html();
			let seq = $(".meetingDetail").data("seq");
			let frm = $(".frm");
			
			let contentText = document.querySelector(".descTextDetail").innerText; 
	   	    let linkText = document.querySelector(".inputLink").innerText; 
	   	 	let pwText = document.querySelector(".inputPw").innerText;
	   	 	
	   	    let contentLimit = 500;
	   	    let linkLimit = 100;
			let pwLimit = 8;
			
			if(contents == "" || contents == "<br>"){
	             Swal.fire({
	               icon: "info",
	               title: "Wait  !",
	               text: "내용을 입력해주세요.",
	               iconColor: "#FFB300",
	               confirmButtonColor: "#FFB300"
	            });
	              return;
	          }
	          if(kakaolink == "" || kakaolink == "<br>"){
	              Swal.fire({
	                icon: "info",
	                title: "Wait  !",
	                text: "카카오톡 링크를 입력해주세요.",
	                iconColor: "#FFB300",
	                confirmButtonColor: "#FFB300"
	             });
	               return;
	           }
	          
	          let regex = /^https:\/\/open\.kakao\.com\/o\/[a-zA-Z0-9]+$/;
	          if(!regex.test(kakaolink)){
				Swal.fire({
					icon: "info",
					title: "Wait  !",
					text: "카카오톡 링크 형식이 맞지 않습니다.",
					iconColor: "#FFB300",
					confirmButtonColor: "#FFB300"
				});
				return;
			   }
	          
	          if(kakaopw == "" || kakaopw == "<br>"){
	              Swal.fire({
	                icon: "info",
	                title: "Wait  !",
	                text: "패스워드를 입력해주세요.",
	                iconColor: "#FFB300",
	                confirmButtonColor: "#FFB300"
	             });
	               return;
	           }
	          
	          if (contentText.length > contentLimit) {
	              let currentContentLen = contentText.length;
	              let overContent = contentText.substring(contentLimit, contentLimit + 100);
	              
	              Swal.fire({
	                  icon: "warning",
	                  title: "내용 글자수 초과!",
	                  html: "현재 내용은 <b>" + currentContentLen + "자</b>입니다. (제한: 500자)<br><br>" +
	                        "<div style='color:red; background:#fff1f1; padding:15px; border-radius:5px; text-align:left; font-size:13px; border:1px solid #ffcccc; word-break: break-all;'>" +
	                        "<b>내용 뒷부분을 삭제해주세요:</b><br><br>" +
	                        "<span style='color:#555;'>... " + overContent + "</span></div>",
	                  iconColor: "#EB0000",
	                  confirmButtonColor: "#FFB300"
	              });
	              return;
	          }
	          if (linkText.length > linkLimit) {
	              let currentLinkLen = linkText.length;
	              let overLink = linkText.substring(linkLimit, linkLimit + 50); 

	              Swal.fire({
	                  icon: "warning",
	                  title: "링크 글자수 초과!",
	                  html: "현재 링크가 <b>" + currentLinkLen + "자</b>입니다. (제한: 100자)<br><br>" +
	                        "<div style='color:red; background:#fff1f1; padding:15px; border-radius:5px; text-align:left; font-size:14px; border:1px solid #ffcccc; white-space: pre-wrap; word-break: break-all;'>" +
	                        "<b>이 부분부터 삭제해주세요:</b><br><br>" +
	                        "<span style='color:#555;'>... " + overLink + "</span></div>",
	                  iconColor: "#EB0000",
	                  confirmButtonColor: "#FFB300"
	              });
	              return;
	          }
	          if (pwText.length > pwLimit) {
	              let currentPwLen = pwText.length;
	              let overPw = pwText.substring(pwLimit, pwLimit + 10); 

	              Swal.fire({
	                  icon: "warning",
	                  title: "패스워드 글자수 초과!",
	                  html: "현재 패스워드가 <b>" + currentPwLen + "자</b>입니다. (제한: 8자)<br><br>" +
	                        "<div style='color:red; background:#fff1f1; padding:15px; border-radius:5px; text-align:left; font-size:14px; border:1px solid #ffcccc; white-space: pre-wrap; word-break: break-all;'>" +
	                        "<b>이 부분부터 삭제해주세요:</b><br><br>" +
	                        "<span style='color:#555;'>... " + overPw + "</span></div>",
	                  iconColor: "#EB0000",
	                  confirmButtonColor: "#FFB300"
	              });
	              return;
	          }
	          
			$.ajax({
				url : "/meeting/updateReportCheck",
				type : "post",
				data : {
					target_seq : seq
				}
			}).done(function(resp){
					if(resp == "fail"){
					Swal.fire({
			             icon: "error",
		                 title: "Fail !",
		                 text: "신고된 모임은 수정할 수 없습니다.",
		                 iconColor: "#EB0000",
		                 confirmButtonColor: "#FFB300"
		        		});
					
						let originContents = meet_detailcontents.data("originContents");
						let originLink = meet_kakaolink.data("originLink");
						let originPw = meet_kakaopw.data("originPw");
						
						meet_detailcontents.html(originContents);
						meet_kakaolink.html(originLink);
						meet_kakaopw.html(originPw);
						
						$(".updateBtn").css({"display":"inline"});
						$(".backBtn").css({"display":"inline"});
						$(".completeBtn").css({"display":"none"});
						$(".cancelBtn").css({"display":"none"});
						
						$(".updateDiv").removeAttr("contenteditable");
						return;
						location.reload();
					}else if(resp == "success"){
						$(".seqInput").val(seq);
			          	$(".update_contents").val($(".descTextDetail").html());
						$(".update_kakaolink").val($(".inputLink").html());
						$(".update_kakaopw").val($(".inputPw").html());
			          	frm.submit();
					}
				})
			});
		
		$(document).on("keydown", ".descTextDetail[contenteditable='true']", function(e){
		    if(e.key === "Enter"){
		        e.preventDefault(); // 기본 동작 막기
		
		        document.execCommand("insertLineBreak"); // 줄바꿈 삽입
		    }
		});
		
		$(document).on("keydown", ".inputLink[contenteditable='true']", function(e) {
		    if (e.key === "Enter") {
		        e.preventDefault();
		    }
		});
		
		$(document).on("keydown", ".inputPw[contenteditable='true']", function(e) {
		    if (e.key === "Enter") {
		        e.preventDefault();
		    }
		});
		
		$(".backBtn").on("click",function(){
			location.replace("/meeting/myMeeting");
		});
	</script>
</body>
</html>