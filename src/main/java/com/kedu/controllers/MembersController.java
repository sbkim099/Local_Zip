package com.kedu.controllers;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.kedu.dao.AdminQaDAO;
import com.kedu.dao.BoardDAO;
import com.kedu.dao.MembersDAO;
import com.kedu.dao.VisitLogDAO;
import com.kedu.dto.BlackListDTO;
import com.kedu.dto.BoardDTO;
import com.kedu.dto.MembersDTO;

@Controller
@RequestMapping("/members")
public class MembersController {
	
	@Autowired
	private MembersDAO dao;
	@Autowired
	private Gson gson;
	@Autowired
	private VisitLogDAO vdao;	
	@Autowired
	private BoardDAO BoardDao;
	@Autowired
	private AdminQaDAO adao;
	
	// 회원가입 창으로 이동 클릭 시
	@RequestMapping("/join")
	public String join() {
		return "members/joinform";
	}
	
	// 아이디 중복체크
	@ResponseBody
	@RequestMapping("/duplCheck")
	public String duplCheck(String mem_id) {
		int duplCheck = dao.duplCheck(mem_id);
		String result = gson.toJson(duplCheck);
		return result;
	}
	
	// 로그인 경유 후 아래 로그인으로 이동
	@RequestMapping("/loginUi")
	public String loginUI() throws Exception {
		return "members/login";
	}
	
	// 회원가입 창에서 약관 동의서 확인 url 클릭 시
	@RequestMapping("/terms")
	public String terms() {
		return "members/terms";
	}
	
	// 회원가입 완료 버튼 클릭 시
	@RequestMapping("/signup")
	public String signup(MembersDTO dto, String mem_dong, HttpSession session) {

	    String ssn = dto.getMem_ssn();
	    String genderCode = ssn.substring(7, 8);

	    if (genderCode.equals("1") || genderCode.equals("3")) {
	        dto.setMem_gender(1);
	    } else if (genderCode.equals("2") || genderCode.equals("4")) {
	        dto.setMem_gender(2);
	    }
	    
	    session.setAttribute("dong", mem_dong);
	    dao.insert(dto);
	    return "redirect:/members/loginUi";
	}
	// 로그인, (메인)닉네임 출력(새로운거), 로그인 alert 기능
	@RequestMapping("/login")
	public String login(HttpSession session, String mem_id, String mem_password, RedirectAttributes rttr) throws Exception {
		
		if(mem_id == null || mem_id.trim().equals("") || mem_password == null || mem_password.trim().equals("")) {
			rttr.addFlashAttribute("msg", "empty");
			rttr.addFlashAttribute("mem_id", mem_id); // 로그인 실패 시, id 살리기
			return "redirect:/members/loginUi";
		}
		
		int result = dao.login(mem_id,  mem_password);
		
		if(result == 1) {
			
			List<BlackListDTO> blackList = adao.selectById(mem_id);
			
			if(blackList != null && !blackList.isEmpty()) {
				BlackListDTO black = blackList.get(0);
				
				if(black.getEnd_date() != null) {
					try {
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						Date endDate = sdf.parse(black.getEnd_date());
						Date now = new Date();
						
						if(endDate.after(now)) {
								Calendar cal = Calendar.getInstance();
							    cal.setTime(endDate);
							    int endYear = cal.get(Calendar.YEAR);
	
							    String dateResult = "";
						    if (endYear > 2099) {
						        dateResult = "영구 정지";
						    }else {
						    	SimpleDateFormat displaySdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분");
						    	dateResult = displaySdf.format(endDate);
							}
								rttr.addFlashAttribute("msg", "banned");
								rttr.addFlashAttribute("endDate", dateResult);
								return "redirect:/members/loginUi";
						}else {
							adao.deleteBlackList(mem_id);
							dao.updateMemberStatus(mem_id);
						}
					}catch(Exception e) {
						e.printStackTrace();
						rttr.addFlashAttribute("lmsg", "loginFail");
						return "redirect:/members/loginUi";
					}
				}
			}
			
			String nickname = dao.nickname(mem_id);
			String dong = dao.address(mem_id); // 로그인 아이디로 주소 저장(00동 출력용)
			int role = dao.getRole(mem_id);
			session.setAttribute("role", role);
			session.setAttribute("loginId", mem_id); 
			session.setAttribute("nickname", nickname);
			session.setAttribute("dong", dong);// 로그인 아이디로 주소 저장(00동 출력용)
			
			int exists = vdao.existsToday(mem_id); // 총 방문수 통계 구하는 로직
				if(exists == 0) {
					vdao.insertTodayVisit(mem_id);
				}
			return "redirect:/";
		} else if(result == 2){
			String nickname = dao.nickname(mem_id);
			
			session.setAttribute("loginId", mem_id);
			session.setAttribute("nickname", nickname);
			
			int role = dao.getRole(mem_id);
			session.setAttribute("role", role);
			
			String dong = dao.address(mem_id); 
			session.setAttribute("dong", dong);
			
			return "redirect:/admin/adminPage";
		}else if(result == 3) {
			rttr.addFlashAttribute("msg", "fail");
			rttr.addFlashAttribute("mem_id", mem_id);
		}else if(result == 0){
			rttr.addFlashAttribute("msg", "pwFail");
			rttr.addFlashAttribute("mem_id", mem_id);
		}else {
			rttr.addFlashAttribute("msg", "idFail");
			rttr.addFlashAttribute("mem_id", mem_id);
		}
		
		return "redirect:/members/loginUi";
		}
	
	// 마이페이지 아이콘 클릭 시
	@RequestMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		session.getAttribute("nickname");
		String loginId = (String)session.getAttribute("loginId");
		
		int meetingCount = dao.meetingCount(loginId);
		model.addAttribute("meetingCount",meetingCount);
		
		int writeCount = BoardDao.MyWriteCount(loginId); // 마이페이지에서 작성글 수 보여주는 메서드
		model.addAttribute("writeCount",writeCount);
		
		int likeCount = BoardDao.MyLikeCount(loginId); // 마이페이지에서 관심 게시글 수 보여주는 메서드
		model.addAttribute("likeCount",likeCount);
		
		if(loginId == null) {
			return "redirect:/members/loginUi";
		}
		Integer role = (Integer) session.getAttribute("role");
		
		if(role == 0){
			return "redirect:/admin/adminPage";
		}else {		
			return "members/mypage";
		}
	}
	
	// 마이페이지 > 내 정보 버튼 클릭 시
	@RequestMapping("/myInfo")
	public String myInfo(HttpSession session, Model model) throws Exception{
		String id = (String)session.getAttribute("loginId");
		MembersDTO list = dao.selectAll(id);
		
		model.addAttribute("list",list);
		return "members/myInfo";
	}
	
	//로그아웃 버튼 > 홈으로 이동
	@RequestMapping("/logout")
	public String logout(HttpSession session) throws Exception {
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping("/update")
	public String update(MembersDTO dto, HttpSession session) throws Exception {
		
		session.setAttribute("nickname", dto.getMem_nickname());
		session.setAttribute("dong", dto.getMem_dong());
		dao.updateById(dto, dto.getMem_id());
		return "redirect:/members/myInfo";
	}
	
	@RequestMapping("/delete")
	public String delete(HttpSession session) {
		String id = (String)session.getAttribute("loginId");
		dao.deleteById(id); // 회원탈퇴 mem_status => 1로 업데이트. XX 아예 삭제로 변경함.
		session.invalidate();
		return "redirect:/";
	}
	
	// 마이페이지 > 작성글(모아보기)를 눌렀을 때,
	@RequestMapping("/myPosts")
	public String myPosts(HttpSession session, Model model, int cPage) throws Exception{
		
		String mem_id = (String)session.getAttribute("loginId");
		
		int start = (cPage-1)*10+1;
		int end = cPage*10;
		List<BoardDTO> list = BoardDao.getPostsNavi(mem_id,start,end);
		
		//게시글 갯수 가져오기
		int totalCount = BoardDao.getTotalPosts(mem_id); // 내가 작성한 글 목록 보여주는
		
		model.addAttribute("listAll",list);
		model.addAttribute("cPage",cPage);
		model.addAttribute("totalCount",totalCount);
		
		return "members/myPosts";
	}
	
	
	// 마이페이지 > 관심 게시글을 눌렀을 때,
	@RequestMapping("/myLikes")
	public String myLikes(HttpSession session, Model model, int cPage) throws Exception{
		
		String mem_id = (String)session.getAttribute("loginId");
		
		int start = (cPage-1)*10+1;
		int end = cPage*10;
		List<BoardDTO> navi = BoardDao.getLikesNavi(mem_id,start,end); // 네비게이터용 메서드 model로 안보냄.
		
		//게시글 갯수 가져오기
		int totalCount = BoardDao.getTotalLikes(mem_id); // 내가 작성한 글 목록 보여주는
		
		model.addAttribute("likeList", navi);
		model.addAttribute("cPage",cPage);
		model.addAttribute("totalCount",totalCount);
		
		return "members/myLikes";
	}
	
	@ExceptionHandler(Exception.class)
	   public String exceptionHandler(Exception e) {
	      e.printStackTrace();
	      return "error";
	   }
}