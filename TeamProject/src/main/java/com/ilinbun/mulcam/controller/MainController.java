package com.ilinbun.mulcam.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;
import java.util.Optional;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ilinbun.mulcam.dto.BragBoard;
import com.ilinbun.mulcam.dto.CommBoard;
import com.ilinbun.mulcam.dto.PlaceReview;
import com.ilinbun.mulcam.dto.Shareboard;
import com.ilinbun.mulcam.dto.User;
import com.ilinbun.mulcam.service.BragService;
import com.ilinbun.mulcam.service.CommService;
import com.ilinbun.mulcam.service.PlaceReviewService;
import com.ilinbun.mulcam.service.ShareService;
import com.ilinbun.mulcam.service.UserService;

@Controller
@RequestMapping("/")
public class MainController {

	@Autowired
	BragService bragService;
	
	@Autowired
	UserService userService;

	@Autowired
	HttpSession session;
	
	@Autowired
	ShareService shareService;
	
	@Autowired
	CommService commService;
	
	@Autowired
	PlaceReviewService placeReviewService;
	
	@Autowired
	private ServletContext servletContext;
	

	@GetMapping({ "", "/index" })
	public String Main(Model model) {
		try {
			List<BragBoard> bestbragList = bragService.bragBest();
			List<BragBoard> bragList=bragService.getBragboardList(1, 8); //첫번째 페이지에서 가져오는 의미
			model.addAttribute("bragList", bragList);
			model.addAttribute("bestbragList", bestbragList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "main";
	}

	// 회원가입 폼
	@GetMapping("/join")
	public String getJoin(@ModelAttribute User user) {
		return "default/user/joinForm";
	}

	// 닉네임 중복체크
	@PostMapping("/nickCheck")
	@ResponseBody
	public String nickCheck(@RequestParam("nickname") String nickname) throws Exception {
		System.out.println("nickCheck 진입");
		System.out.println("전달받은 nickname : " + nickname);
		String msg = userService.nickCheck(nickname);
		System.out.println("확인 결과 : " + msg);
		return msg;
	}

	// 이메일 중복체크
	@PostMapping("/emailCheck")
	@ResponseBody
	public String emailCheck(@RequestParam("email") String email) throws Exception {
		System.out.println("emailCheck 진입");
		System.out.println("전달받은 email : " + email);
		String msg = userService.emailCheck(email);
		System.out.println("확인 결과 : " + msg);
		return msg;
	}

	// 회원가입 기능 컨트롤러
	@PostMapping("/join")
	public String postJoin(String email, String nickname, String password, int honbabLevel, MultipartFile profileImg, Model model,HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("postJoin() join");
//		if (bindingResult.hasErrors()) {
//			System.out.println("if join");
//			List<FieldError> list = bindingResult.getFieldErrors();
//			Map<String, String> errorMsg = new HashMap<>();
//
//			for (int i = 0; i < list.size(); i++) {
//				System.out.println("for join");
//				String field = list.get(i).getField();
//				String message = list.get(i).getDefaultMessage();
//				errorMsg.put(field, message); 
//			}
//			model.addAttribute("errorMsg", errorMsg);
//			System.out.println(errorMsg);
//			return "default/user/joinForm";
//		}
		String profileImgName = profileImg.getOriginalFilename();
		System.out.println(profileImgName);
		//프로필 이미지 첨부가 있다면
		if(!profileImgName.equals("")){
			System.out.println("프로필 이미지가 Null이 아니면");
			String path = servletContext.getRealPath("/profile/");
			String filename = profileImg.getOriginalFilename();
			File destFile = new File(path + filename);
			System.out.println(profileImg.isEmpty());
			System.out.println(destFile);
			PrintWriter writer = null;
			JSONObject json = new JSONObject();
			
			profileImg.transferTo(destFile);
			writer = response.getWriter();
			response.setContentType("text/html;charset=utf-8");
			response.setCharacterEncoding("utf-8");
			json.append("uploaded", 1);
			json.append("filename", filename);
			json.append("url", "/profile/" + filename);
			writer.println(json);
		} else if(profileImgName.equals("")) {
			System.out.println("프로필 이미지가 널이면");
			profileImgName = "DEFAULT.png";
		}
		System.out.println(email +", "+nickname +", "+ password +", "+ honbabLevel +", "+ profileImgName);
		userService.makeUser(email,nickname,password,honbabLevel,profileImgName);
		return "redirect:/loginSuccess";
	}
	
	

	// 회원가입 완료 폼
	@GetMapping("/loginSuccess")
	public String loginSuccess() {
		return "default/user/joinSuccessForm";
	}

	// 로그인 폼
	@GetMapping("/login")
	public String loginForm() {
		return "default/user/loginForm"; 
	}

	// 로그인 기능 컨트롤러
	@PostMapping("/login")
	public String login(String email, String nickname, String password, boolean rememberEmail, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out.println("login() join");
		try {
			User user = userService.loginUser(email, password);
			user.setPassword(null);
			HttpSession session = request.getSession();
			session.setAttribute("user", user);

			// 쿠키기능(로그인저장)
			if (rememberEmail) {
				// 1. 쿠키를 생성
				Cookie cookie = new Cookie("email", email);
				// 2. 응답에 저장
				response.addCookie(cookie);
			} else {
				// 1. 쿠키를 생성
				Cookie cookie = new Cookie("email", email);
				// 쿠키의 유효기간 0으로 설정
				cookie.setMaxAge(0);
				// 2. 응답에 저장
				response.addCookie(cookie);
			}
		} catch (Exception e) {
			e.printStackTrace();
			String msg = URLEncoder.encode("아이디와 비밀번호를 확인해주세요", "utf-8");
			return "redirect:/login?msg=" + msg;
		}
		return "redirect:/";
	}

	// 로그아웃 컨트롤러
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	// 비밀번호 찾기 폼
	@GetMapping("/searchPwd")
	public String searchPwd() {
		return "default/user/searchPwdForm";
	}

	// 마이 페이지 폼
	@GetMapping("/myPage")
	public String myPage(HttpSession session, Model model) throws Exception {
		session.getAttribute("email");
		return "user/myPageForm";
	}

	// 정보 수정 페이지 폼
	@GetMapping("/editInfo")
	public String editInfo() {
		return "user/editInfoForm";
	}
	
	// 정보수정
	@PostMapping("/infoUpdate")
	public String infoUpdate(MultipartFile profileImg, String email, String nickname, String originPass, String password, int honbabLevel, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String msg = "";
		System.out.println("infoUpdate() join");
		User user = (User)session.getAttribute("user");
		String dbPass = userService.getPwd(user.getEmail());
		
		
//		String path = this.servletContext.getRealPath("/profile/");
//		File destFile = new File(path + profileImg);
//		System.out.println(path);
//		System.out.println(destFile);
		String profileImgName = profileImg.getOriginalFilename();
		
		System.out.println("변경 할 닉네임 : " + nickname);
		System.out.println("기존패스워드 : " + originPass);
		System.out.println("db패스워드 : " + dbPass);
		System.out.println("변경할 패스 : " + password);
		System.out.println("새로운 프로필 이미지 : " + profileImgName);
		System.out.println("혼밥레벨 : " + honbabLevel);
		// 입력패스워드와 DB에 있는 사용자의 패스워드가 같다면 
		try {
			if(originPass.equals(dbPass)) {
				// 사용중이던 비밀번호로 변경하려는 멍청이라면, 에러메시지와 함께 redirect
				if (dbPass.equals(password)) {
					System.out.println("1");
					msg = URLEncoder.encode("기존 비밀번호와 같습니다. 다른 비밀번호로 설정해주세요.", "utf-8");
					return "redirect:/editInfo?msg=" + msg;
				}
				// 새로운 비밀번호를 입력하지 않았다면, 기존비밀번호로 설정
				if  (password.equals("")) {
					System.out.println("2");
					password = dbPass;
				}
				// 공백으로 닉네임이 넘어간다면, 기존 닉네임으로 설정 (닉네임 글자수 및 동일닉네임 체크는 ajax로 해결)
				if (nickname.equals("")) {
					System.out.println("3");
					nickname = user.getNickname();
				}
				// 프로필 이미지가 비어있으면, 기존 프로필사진 그대로 유지// 프로필 이미지가 변경되었으면 변경된 이미지 저장
				if (profileImgName.equals("")) {
					System.out.println("4");
					profileImgName = user.getProfileImg();
				} else {
					String path = servletContext.getRealPath("/profile/");
					String filename = profileImg.getOriginalFilename();
					File destFile = new File(path + filename);
					System.out.println(profileImg.isEmpty());
					System.out.println(destFile);
					PrintWriter writer = null;
					JSONObject json = new JSONObject();
					
					profileImg.transferTo(destFile);
					writer = response.getWriter();
					response.setContentType("text/html;charset=utf-8");
					response.setCharacterEncoding("utf-8");
					json.append("uploaded", 1);
					json.append("filename", filename);
					json.append("url", "/profile/"+ filename);
					writer.println(json);
					
					System.out.println(writer);
					System.out.println(json);
					
					System.out.println(path);
					System.out.println(destFile);
				}
				System.out.println("5");
				
				userService.updateInfo(email, nickname, password, profileImgName, honbabLevel);	
			// DB에 있는 비밀번호와 입력패스워드가 다르다면
			} else {
				msg = URLEncoder.encode("기존 비밀번호가 틀렸습니다. 다시 확인해주세요.", "utf-8");
				return "redirect:/editInfo?msg=" + msg;
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("오류발생");
		}
		return"redirect:/myPage";
	}
	
	@GetMapping("/profile/{filename}")
	public void fileview(@PathVariable String filename, HttpServletRequest request, HttpServletResponse response) {
		String path = servletContext.getRealPath("/profile/");
		File file = new File(path + filename);
		String sfilename = null;
		FileInputStream fis = null;
		
		try {
			if (request.getHeader("User-Agent").indexOf("MSIE") > -1) {
				sfilename = URLEncoder.encode(file.getName(), "utf-8");
			} else {
				sfilename = new String(file.getName().getBytes("utf-8"), "ISO-8859-1");
			}
			response.setCharacterEncoding("utf-8");
			response.setContentType("application/octet-stream;charset=utf-8");

			response.setHeader("Content-Disposition", "attachment; filename=" + sfilename);
			OutputStream out = response.getOutputStream();
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (Exception e) {
				}
			}
		}
		
	}
	
	
	
	
	//마이페이지에 혼밥자랑 게시글 출력
	@ResponseBody
	@PostMapping("/MybragPosting")
	public List<BragBoard> bragPosting() throws Exception {
		User user = (User) session.getAttribute("user");
		List<BragBoard> myBragList = bragService.MyBragBoard(user.getIdx());
		return myBragList;
	}
	
	//마이페이지에 반찬공유 게시글 출력
		@ResponseBody
		@PostMapping("/MysharePosting")
		public List<Shareboard> sharePosting() throws Exception {
			User user = (User) session.getAttribute("user");
			List<Shareboard> myShareList = shareService.MyShareBoard(user.getIdx());
			return myShareList;
		}
		
		//마이페이지에 커뮤니티 게시글 출력
		@ResponseBody
		@PostMapping("/MycommunityPosting")
		public List<CommBoard> communityPosting() throws Exception {
			User user = (User) session.getAttribute("user");
			List<CommBoard> myCommunityList = commService.MyCommunityBoard(user.getIdx());
			return myCommunityList;
		}
		
		//마이페이지에 혼밥리뷰 게시글 출력
		@ResponseBody
		@PostMapping("/MyreviewPosting")
		public List<PlaceReview> reviewPosting() throws Exception {
			User user = (User) session.getAttribute("user");
			List<PlaceReview> myReviewList = placeReviewService.MyReviewBoard(user.getIdx());
			return myReviewList;
		}
		//회원삭제 폼
		@GetMapping("/deleteUserForm")
		public String deleteUserForm() throws Exception {
			return "default/user/deleteUserForm";
		}
		
		//회원 탈퇴 기능
		@PostMapping("/deleteUser")
		public String deleteUser(User user,HttpSession session) throws Exception {
			System.out.println("deleteUser() Join");
			
			//현재 세션에 저장되있는 유저객체(실제 로그인 되어있는 사용자의 객체정보)를 얻어와 변수에 저장
			User user2 = (User)session.getAttribute("user");
			String oldPass = userService.getPwd(user.getEmail());
			
			System.out.println("세션에 저장된 유저 객체 : "+user2);
			System.out.println("탈퇴 폼에 입력된 이메일 : " + user.getEmail());
			System.out.println("탈퇴 폼에 입력된 비밀번호 : " + user.getPassword());
			System.out.println("세션 유저의 이메일 " + user2.getEmail());
			System.out.println("세션 유저의 비밀번호(DB에서 추출) " + oldPass);
			System.out.println(Optional.ofNullable(user2.getPassword()).isPresent());
			
			//문제점 .. 로그인 할 때 password를 null로 바꿨기 때문에 세션에서 비밀번호를 얻어올 수 없음..
			// 일단 로그인에서 setPassword(null)을 뺴서 해결하겠습니다..
		
			//회원탈퇴에서 넘어온 비밀번호를 변수에 저장
			String newPass = user.getPassword();
			
			
			if((user.getEmail().equals(user2.getEmail())) ) {
				System.out.println("이메일 일치");
				if(oldPass.equals(newPass)) {
					System.out.println("비밀번호도 일치");
					userService.userDelete(user);
					session.invalidate();
					System.out.println("회원탈퇴성공");
					return "redirect:/";
				} else {
					System.out.println("이메일은 일치하나 비밀번호는 불일치");
					String msg = URLEncoder.encode("이메일과 비밀번호를 다시 확인해주세요", "utf-8"); 
					return "redirect:/deleteUserForm?msg=" + msg;
				}
			} else {
				System.out.println("이메일이 불일치해서 비밀번호까진 확인도 못함");
				String msg = URLEncoder.encode("이메일과 비밀번호를 다시 확인해주세요", "utf-8");
				return "redirect:/deleteUserForm?msg=" + msg;
			}
			
		}
		
		
		
		
		

		
		
		
		

}
