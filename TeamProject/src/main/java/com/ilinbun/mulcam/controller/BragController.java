package com.ilinbun.mulcam.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
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
import org.springframework.web.servlet.ModelAndView;

import com.ilinbun.mulcam.dto.BragBoard;
import com.ilinbun.mulcam.dto.PageInfo;
import com.ilinbun.mulcam.dto.User;
import com.ilinbun.mulcam.service.BragService;

@Controller
@RequestMapping("/brag")
public class BragController {
	@Autowired
	HttpSession session;
	
	@Autowired
	private BragService bragService;

	@Autowired
	private ServletContext servletContext;

	@Autowired(required = false) // 이건 왜 한거지?
	BragBoard bragboard;

	// 이달의 혼밥 사진 나타내는 컨트롤러
	@GetMapping("")
	public String Main(Model model) {
		try {
			
			bragboard = bragService.bragBest1();
			model.addAttribute("BragBest1", bragboard);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "brag/main";
	}
	
//	@RequestMapping(value="boardlist", method= {RequestMethod.GET, RequestMethod.POST})
//	public ModelAndView boardList(@RequestParam(value="page", required=false, defaultValue="1") int page) {
//		ModelAndView mav=new ModelAndView();
//		PageInfo pageInfo=new PageInfo();
//		try {
//			List<Board> articleList=boardService.getBoardList(page, pageInfo);
//			mav.addObject("pageInfo", pageInfo);
//			System.out.println(pageInfo);
//			mav.addObject("articleList", articleList);
//			System.out.println(articleList);
//			mav.setViewName("/board/listform");
//		} catch(Exception e) {
//			e.printStackTrace();
//			mav.addObject("err", e.getMessage());
//			mav.setViewName("/board/err");
//		}
//		return mav;
//	}
//	// 혼밥자랑 게시판
//	@GetMapping("/brag")
//	public String brag() {
//		return "brag/brag";
//	}
//	// 1. (일반) 자랑게시판 brag list 출력(사진 형태로), brag_list
		@GetMapping("/brag")
		public ModelAndView brag_list(@RequestParam(value="page", required=false, defaultValue="1") int page) {
			// User userInfo = (User) session.getAttribute("user");
			ModelAndView mav=new ModelAndView();
			PageInfo pageInfo=new PageInfo();
			pageInfo.setPage(page);
			try {
				List<BragBoard> bragList=bragService.getBragboardList(page);
				for(BragBoard brag : bragList) {
					Document doc=Jsoup.parse(brag.getContent());
					Elements img= doc.select("img");
					String src = img.attr("src");
					brag.setContent(src);
				}

				pageInfo=bragService.getPageInfo(pageInfo);
				// mav.addObject("userInfo", userInfo);
				mav.addObject("pageInfo", pageInfo);
				mav.addObject("bragList", bragList);
				mav.setViewName("brag/brag");
			} catch(Exception e) {
				e.printStackTrace();
				mav.addObject("err", e.getMessage());
				mav.setViewName("err");
			}
			return mav;
		}
		
		
//		@GetMapping("/today_select/{today_articleNo}")
//		public ModelAndView today_select(@PathVariable int today_articleNo, @RequestParam(value="page", required=false, defaultValue="1")int page) {
//			ModelAndView mav =new ModelAndView("today_select");						
//			PageInfo pageInfo = new PageInfo();
//			System.out.println(today_articleNo);
//			System.out.println(pageInfo);
//			
//			
//			// 로그인한 유저 아이디 가져오기 (세션)
//			String user_id = "testUser";
//			// 지금 들어온 게시물의 no를 통해 작성자 아이디 가져오기
//			//String writerid ="{today_user_id}"
//			String writerid="testUser";
//			Boolean modiAndDel = false;
//			
//			if (user_id.equals(writerid)) {
//				modiAndDel = true;
//			} 
//			mav.addObject("modiAndDel", modiAndDel);
//			
//			try {
//				System.out.println("try 들어옴");
//				
//				Today todayselect = todayService.getTBoard(today_articleNo);
//				mav.addObject("pageInfo", pageInfo);
//			    mav.addObject("todayselect", todayselect);
//				System.out.println(page);
//				
//				} catch(Exception e) {
//					e.printStackTrace();
//					mav.addObject("err", e.getMessage());
//					mav.setViewName("/err");
//				}
//			return mav;
//		}

		//게시글 보기 viewDetail
		@GetMapping("/brag/viewdetail/{articleNo}")
		public ModelAndView boardDetail(@PathVariable int articleNo) {
			// User userinfo = (User) session.getAttribute("user");
			User userinfo = new User(1, "mockup@mock.up", "목업", "", "#", 5, 1);
			ModelAndView mav=new ModelAndView();
			try {
				bragboard=bragService.getBragBoard(articleNo);
				mav.addObject("user", userinfo);
				mav.addObject("bboard", bragboard);
				
				Document doc=Jsoup.parse(bragboard.getContent());
				Elements img= doc.select("img");
				String src = img.attr("src");
				
				mav.addObject("imgSrc", src);
				mav.setViewName("brag/viewDetail");
			} catch(Exception e) {
				e.printStackTrace();
				mav.addObject("err", e.getMessage());
				mav.setViewName("err");
			}
			return mav;
		}

		// 글보기?? 훈이꺼 reviewForm controller
		@PostMapping("/{id}")
		public ModelAndView placeInfo(@PathVariable String id) throws Exception {
			ModelAndView mv = new ModelAndView("brag/brag/view");
			bragboard = bragService.bragBoardQueryByID(id);
			mv.addObject("bragboard", bragboard);

			return mv;
		}

		
		

	// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!여기서부터 CKEditor부분!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

	@ResponseBody
	@PostMapping("/upload")
	public void fileupload(@RequestParam(value = "upload") MultipartFile file, HttpServletRequest request,
			HttpServletResponse resp) {
		String path = servletContext.getRealPath("/bragupload/");
		String filename = UUID.randomUUID().toString() + "." + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf('.')+1);
		File destFile = new File(path + filename);
		PrintWriter writer = null;
		//JsonObject json = new JsonObject();
		JSONObject json = new JSONObject();
		try {
			file.transferTo(destFile);
			writer = resp.getWriter();
			resp.setContentType("text/html;charset=utf-8");
			resp.setCharacterEncoding("utf-8");
			json.append("uploaded", 1);
			json.append("fileName", filename);
			json.append("url", "/brag/fileview/" + filename);
//			json.addProperty("uploaded", 1);
//			json.addProperty("fileName", filename);
//			json.addProperty("url", "/fileview/" + filename);

			writer.println(json);

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@GetMapping(value = "/fileview/{filename}")
	public void fileview(@PathVariable String filename, HttpServletRequest request, HttpServletResponse response) {
		String path = servletContext.getRealPath("/bragupload/");
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
			// response.setHeader("Content-Disposition", "attachment;
			// filename=\""+sfilename+"\";");
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

	@PostMapping("/bragwrite")
	public String bragwriteform(@RequestParam String title, 
			@RequestParam String content,
			@RequestParam String moonpa, 
			@RequestParam String location, 
			@RequestParam int idx, 
			Model model) {
		
		
		try {
			BragBoard bragboard = new BragBoard(idx, Boolean.parseBoolean(moonpa), title, location, 0, content);			
			Document doc=Jsoup.parse(bragboard.getContent());
			
			Elements img= doc.select("img");
			String src = img.attr("src");
			String newSrc =src.substring(src.indexOf("brag/fileview/")+("brag/fileview/").length());
			doc.select("img").attr("src", "/bragupload/"+newSrc);
			bragboard.setContent(doc.select("body > p").toString());
			
			bragService.regBragBoard(bragboard);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		model.addAttribute("title", title);
		model.addAttribute("content", content.trim());
		return "result"; //resultForm다시
	}

	// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1111CKEditor끝!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11

	// BEST 게시판
	@GetMapping("/best")
	public String Best() {
		return "brag/best";
	}




	//글쓰기 --> CKEditor와 결합 해봄
	  
	  @GetMapping("/writeform") public String bragwriteform(Model model) { //
	  HttpSession session = null; //이거는 가라데이터. 로그인 되면 session에서 받아 올거야!!!!!!!!
	  String test = "th@th.com"; model.addAttribute("email", test); 
	  return "brag/writeForm"; 
	  }
	
//	@PostMapping("bragwrite")
//	public ModelAndView bragWrite(@ModelAttribute Bragboard bragboard) {
//		ModelAndView mav=new ModelAndView();
//		System.out.println("문제");
//		//예외처리 시 응답으로 보여줄 jsp 화면이 다르기 때문에 생성자에 viewName을 담지 않았다.
//		try {
//			if(!bragboard.getFile().isEmpty()) { //file input태그는 required 형태가 아니므로
//				//넘어온 데이터가 있을 경우에만 파일 처리를 한다.
//				String path=servletContext.getRealPath("/bragupload/"); //webapp에 만들어줌. 근데 boardupload(다른 사람들)도 있는데 갠찮나?
//				File destFile=new File(path+bragboard.getFile().getOriginalFilename());
//				bragboard.setImgfilename(bragboard.getFile().getOriginalFilename());
//				//Board 객체의 멤버변수값 초기화하는 작업
//				bragboard.getFile().transferTo(destFile);
//				//서버 저장 경로(destFile)에 매개변수로 가져온 파일 객체(board.getFile())를 복사하여 저장(transferTo)
//			}
//			bragService.regBragBoard(bragboard); //bragboard를 DB에 저장함
//			mav.setViewName("redirect:/brag/brag");
//			//foward방식으로 넘겨주는것이 아니라 redirect로 다시 일반게시판 컨트롤러로 요청한다.
//		} catch(Exception e) {
//			e.printStackTrace();
//			mav.addObject("err", "새글 등록 실패");
//			mav.setViewName("/main/err");
//		}
//		return mav;
//	}

//기존 훈 코드. RequestPart로 했었다
//	@ResponseBody
//	@PostMapping("/bragwrite")
//	public ResponseEntity<String> bragwrite(@RequestPart("key") Map<String, String> param,
//			@RequestPart(value = "file", required = true) MultipartFile file) {
//		ResponseEntity<String> result = null;
//
//		// Map<String, Object> result = new HashMap<String, Object>();
//
//		System.out.println(file.getOriginalFilename());
//		System.out.println(param.get("content"));
//		System.out.println(param.get("email"));
//		System.out.println(param.get("moonpa"));
//
//		try {
//			// 이미지 파일의 이름을 바꿔봅시다
//			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
//			Date now = new Date();
//			String nowTime = sdf.format(now);
//
//			System.out.println("파일 업로드 시도");
//			String path = servletContext.getRealPath("/bragupload/");
//			System.out.println(path);
//
//			File destFile = new File(path + nowTime + "_" + file.getOriginalFilename());
//			System.out.println("1");
//			System.out.println(destFile.getAbsolutePath());
//			file.transferTo(destFile);
//			System.out.println("SUCCESS");
//
//			BragBoard bb = new BragBoard(
//					/* param.get("reviewContent"), */
//					Integer.parseInt("2"), Boolean.parseBoolean(param.get("moonpa")), param.get("title"),
//					param.get("location"), 0, nowTime + "_" + file.getOriginalFilename(), param.get("content"));
//
//			bragService.regBragBoard(bb);
//			result = new ResponseEntity<String>("success", HttpStatus.OK);
//			// boardService.regBoard(board);
//			// mv.setViewName("redirect:/board/boardlist");
//		} catch (Exception e) {
//			e.printStackTrace();
//			result = new ResponseEntity<String>("failed", HttpStatus.BAD_REQUEST);
//			// mv.addObject("err", "새 글 등록 실패");
//			// mv.addObject("/board/err");
//		}
//
//		return result;
//	}




	//CKEditor!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!글보기!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//	@GetMapping("/today_select/{today_articleNo}")
//	public ModelAndView today_select(@PathVariable int today_articleNo, @RequestParam(value="page", required=false, defaultValue="1")int page) {
//		ModelAndView mav =new ModelAndView("today_select");						
//		PageInfo pageInfo = new PageInfo();
//		System.out.println(today_articleNo);
//		System.out.println(pageInfo);
//		
//		
//		// 로그인한 유저 아이디 가져오기 (세션)
//		String user_id = "testUser";
//		// 지금 들어온 게시물의 no를 통해 작성자 아이디 가져오기
//		//String writerid ="{today_user_id}"
//		String writerid="testUser";
//		Boolean modiAndDel = false;
//		
//		if (user_id.equals(writerid)) {
//			modiAndDel = true;
//		} 
//		mav.addObject("modiAndDel", modiAndDel);
//		
//		try {
//			System.out.println("try 들어옴");
//			
//			Today writeselect = BragService.getArticleNo(articleNo);
//			//mav.addObject("pageInfo", pageInfo);
//		    mav.addObject("writeselect", writeselect);
//			System.out.println(page);
//			
//			} catch(Exception e) {
//				e.printStackTrace();
//				mav.addObject("err", e.getMessage());
//				mav.setViewName("/err");
//			}
//		return mav;
//	}
	

	// // 5.취소요청
	// @PostMapping("/today_postcancle")
	// public String todayPostcancle() {
	// 	return "today";
	// }


	// // 7.좋아요요청 ajax
	// @PostMapping("/today_likes")
	// public boolean todayLikes() {
	// 	return false;
	// }

	// // 9.수정요청
	// @PostMapping("/today_modify")
	// public ModelAndView todayModify() {
	// 	ModelAndView mav = new ModelAndView();
	// 	return mav;
	// }

	// // 10.삭제요청
	// @PostMapping("/today_delete")
	// public ModelAndView todayDelete() {
	// 	ModelAndView mav = new ModelAndView();
	// 	return mav;
	// }

	// // 7. 목록누르면 today로 돌아가기
	// @GetMapping("/today_list")
	// public String today_list() {
	// 	return "today";
	// }
//CKEditor!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!여기까지!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

	// 글수정 (내 글일경우가능)
	@GetMapping(value = "/modifyform")
	public ModelAndView bragmodifyform(@RequestParam(value = "articleNo") int articleNo) {
		ModelAndView mav = new ModelAndView();
		try {
			BragBoard Bragboard = bragService.getArticleNo(articleNo);
			mav.addObject("article", Bragboard);
			mav.setViewName("brag/modifyForm");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("err", e.getMessage());
			mav.setViewName("/brag/err");
		}
		return mav;
	}

	@PostMapping(value = "/bragmodify")
	public ModelAndView bragmodify(@ModelAttribute BragBoard bragboard) {
		ModelAndView mav = new ModelAndView();
		try {
			bragService.modifyBragBoard(bragboard);
			mav.addObject("articleNo", bragboard.getArticleNo());
			mav.setViewName("redirect:/brag/viewDetail");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("err", e.getMessage());
			mav.setViewName("brag/err");
		}
		return mav;
	}

	// 글삭제 (내 글일경우가능)
//		@PostMapping(value="bragdelete")
//		public ModelAndView bragdelete(@RequestParam(value="board_num")int boardNum,
//				@RequestParam(value="page")int page, @RequestParam(value="board_pass")String boardPass) {
//			ModelAndView mav=new ModelAndView();
//			try {
//				boardService.removeBoard(boardNum, boardPass);
//				mav.addObject("page", page);
//				mav.setViewName("redirect:brag/{$ }");
//			} catch(Exception e) {
//				e.printStackTrace();
//				mav.addObject("err", e.getMessage());
//				mav.setViewName("brag/err");
//			}
//			return mav;
//		}
//		
//		@GetMapping(value="file_down")
//		public void filedownload(@RequestParam(value="downFile") String filename,
//				HttpServletRequest request, HttpServletResponse response) {
//			String path=servletContext.getRealPath("/boardupload/");
//			File file=new File(path+filename);
//			String sfilename=null;
//			FileInputStream fis=null;
//			try {
//				if(request.getHeader("User-Agent").indexOf("MSIE")>-1) {
//					sfilename=URLEncoder.encode(file.getName(), "UTF-8");
//				} else { 
//					sfilename=new String(file.getName().getBytes("UTF-8"), "ISO-8859-1");
//				}
//				response.setCharacterEncoding("UTF-8");
//				response.setContentType("application/octet-stream; charest=UTF-8");
//				response.setHeader("Content-Disposition", "attachment; filename="+sfilename);
//				fis=new FileInputStream(file);
//				FileCopyUtils.copy(fis, out);
//				out.flush(); 
//				
//			} catch(Exception e) {
//				e.printStackTrace();
//			} finally {
//				if(fis!=null) {
//					try{
//						fis.close();
//					} catch(Exception e) {
//						e.printStackTrace();
//					}
//				}
//			}
//		}

//		//detail에서 답변을 눌렀을 때 화면 전환 (댓글로 변경하기)
//		@GetMapping(value="replyform")
//		public ModelAndView replyform(@RequestParam(value="board_num")int boardNum,
//				@RequestParam(value="page")int page) {
//			ModelAndView mav=new ModelAndView();
//			try {
//				mav.addObject("boardNum", boardNum);
//				mav.addObject("page", page);
//				mav.setViewName("/board/replyform");
//			} catch(Exception e) {
//				e.printStackTrace();
//				mav.addObject("err", e.getMessage());
//				mav.setViewName("/board/err");
//			}
//			return mav;
//		}
//		
//		@PostMapping(value="boardreply")
//		public ModelAndView boardreply(@ModelAttribute Board board,
//				@RequestParam(value="page")int page) {
//			//현재 파라미터로 가져온 boradNum은 원글의 번호에 해당한다.
//			//이를 가지고 DB에서 select를 하여 ref,lev,seq를 참고한다.
//			ModelAndView mav=new ModelAndView();
//			try {
//				boardService.regReply(board);
//				mav.addObject("page", page);
//				mav.setViewName("redirect:/board/boardlist");
//			} catch(Exception e) {
//				e.printStackTrace();
//				mav.addObject("err", e.getMessage());
//				mav.setViewName("/board/err");
//			}
//			return mav;
//		}

}
