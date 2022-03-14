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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

import com.ilinbun.mulcam.dto.CommBoard;
import com.ilinbun.mulcam.dto.PageInfo;
import com.ilinbun.mulcam.dto.User;
import com.ilinbun.mulcam.service.CommService;
import com.ilinbun.mulcam.service.UserService;

@Controller
@RequestMapping("/comm")
public class CommunityController {
	@Autowired
	HttpSession session;

	@Autowired
	private CommService commService;

	@Autowired
	private UserService userService;
	
	@Autowired
	private ServletContext servletContext;

	@Autowired(required = false) // 매개변수 없어도 OK. 나중에 고쳐야?
	CommBoard commboard;

	@GetMapping("")
	public String Main(Model m) {
		return "community/main";
	}
	
	
	@GetMapping("/listform")
		public ModelAndView comm_list(@RequestParam(value="page", required=false, defaultValue="1") int page) {
			ModelAndView mav=new ModelAndView();
			PageInfo pageInfo=new PageInfo();
			pageInfo.setPage(page);
			try {
				List<CommBoard> commList=commService.getCommBoardList(page);
				for(CommBoard comm : commList) {
					Document doc=Jsoup.parse(comm.getContent());
					Elements img= doc.select("img");
					String src = img.attr("src");
					comm.setContent(src);
				}
				pageInfo=commService.getPageInfo(pageInfo);
				mav.addObject("pageInfo", pageInfo);
				mav.addObject("commList", commList);
				mav.setViewName("community/board/listform");
			} catch(Exception e) {
				e.printStackTrace();
				mav.addObject("err", e.getMessage());
				mav.setViewName("main/err");
			}
			return mav;
		}


	
	

	/*
	 * @RequestMapping(value = "/boardlist", method = { RequestMethod.GET,
	 * RequestMethod.POST }) public ModelAndView boardList(@RequestParam(value =
	 * "page", required = false, defaultValue = "1") int page) { ModelAndView mv =
	 * new ModelAndView(); PageInfo pageInfo = new PageInfo(); try { List<CommBoard>
	 * articleList = CommService.getCommBoardList(page, pageInfo);
	 * mv.addObject("pageInfo", pageInfo); // 중요함 아무거나 적으면 안됨 똑같아야함
	 * mv.addObject("articleList", articleList);
	 * mv.setViewName("/community/board/listform"); } catch (Exception e) {
	 * e.printStackTrace(); mv.addObject("err", e.getMessage());
	 * mv.setViewName("/community/board/err"); } return mv; }
	 */

	// 글쓰기
	@GetMapping("/writeform")
	public String commwriteform(Model model) { 
		return "/community/board/writeform";
	}

	@PostMapping("/boardwrite")
	public String commwriteform(@RequestParam String title, @RequestParam String content, @RequestParam int idx,
			Model model) {
		try {
			//System.out.println(title+content+idx );
			User userInfo = (User) session.getAttribute("user");
			CommBoard commboard = new CommBoard(idx, title, 0, content);
			Document doc = Jsoup.parse(commboard.getContent());
			Elements img = doc.select("img");// 여기에 if 문으로 120~123까지는 묶여야되지 않나 HELP*
			
			if(!img.isEmpty()) {
			String src = img.attr("src");
			String newSrc = src.substring(src.indexOf("community/fileview/") + ("community/fileview/").length());
			doc.select("img").attr("src", "/commupload/" + newSrc);
			//System.out.println(doc.toString());
			}
			
			//System.out.println(doc.select("body > p").toString());
			commboard.setContent(doc.select("body > p").toString());
			commService.regCommBoard(commboard);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("title", title);
		model.addAttribute("content", content.trim());
		return "redirect:/comm/listform"; // 내가 쓴 글 보기viewform으로 이동으로 수정요.
	}

	@ResponseBody
	@PostMapping("/upload")
	public void fileupload(@RequestParam(value = "upload") MultipartFile file, HttpServletRequest request,
			HttpServletResponse resp) {
		String path = servletContext.getRealPath("/commupload/");
		String filename = UUID.randomUUID().toString() + "."
				+ file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf('.') + 1);
		File destFile = new File(path + filename);
		PrintWriter writer = null;
		// JsonObject json = new JsonObject();
		JSONObject json = new JSONObject();
		try {
			file.transferTo(destFile);
			writer = resp.getWriter();
			resp.setContentType("text/html;charset=utf-8");
			resp.setCharacterEncoding("utf-8");
			json.append("uploaded", 1);
			json.append("fileName", filename);
			json.append("url", "/comm/fileview/" + filename);
			// json.addProperty("uploaded", 1);
			// json.addProperty("fileName", filename);
			// json.addProperty("url", "/fileview/" + filename);
			writer.println(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@GetMapping(value = "/fileview/{filename}")
	public void fileview(@PathVariable String filename, HttpServletRequest request, HttpServletResponse response) {
		String path = servletContext.getRealPath("/commupload/");
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

	// 게시글보기 (viewDetail.jsp)
	@GetMapping("/community/viewform/{articleNo}")
	public ModelAndView boardDetail(@PathVariable int articleNo) {
		ModelAndView mav = new ModelAndView();
		try {
			commboard = commService.getCommBoard(articleNo); // 내가쓴글, 남이쓴글 확인
			
			User userinfo = commService.selectUserDetail(commboard.getIdx()); //유저 정보 가져오기
			
			int likes = commService.queryArticleLikes(articleNo);
			
			
			User user = (User) session.getAttribute("user");
			if(user != null) {
				System.out.println("유저 정보 인식");
				int didILiked = commService.queryIfILikeThis(articleNo, user.getIdx());
				System.out.println("이전에 누른 적 있음 : " +didILiked);
				mav.addObject("didILiked", didILiked);  //좋아요 유지
			}
			
			mav.addObject("likes", likes);
			
			mav.addObject("userinfo", userinfo);
	
			
			mav.addObject("cboard", commboard);
			
			Document doc = Jsoup.parse(commboard.getContent()); // content중에 사진만 가져오기
			Elements img = doc.select("img"); // 우선 무수한 요소 중 img만 추출
			String src = img.attr("src"); // String으로 변환

			mav.addObject("imgSrc", src); // mav에 넣기
			mav.setViewName("community/board/viewform"); // 경로이름 설정
			
			int idx = commboard.getIdx();
			String nickname = userService.getUserNick(idx);
			// 리턴타입 String, 파라미터타입 int
			// select 닉네임 from 유저테이블 where idx=#{idx}
			mav.addObject("nickname", nickname);
			
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("err", e.getMessage());
			mav.setViewName("err");
		}
		return mav;
	}

	// 게시글보기 --> same
	@PostMapping("/{id}")
	public ModelAndView placeInfo(@PathVariable String id) throws Exception {
		ModelAndView mv = new ModelAndView("/community/view");
		commboard = commService.CommBoardQueryByID(id);
		mv.addObject("commboard", commboard);

		return mv;
	}

	// 구현 전 코드들
	// // 글쓰기 에서 취소요청
	// @PostMapping("/today_postcancle")
	// public String todayPostcancle() {
	// return "today";
	// }

	// // 목록누르면 list로 돌아가기
	// @GetMapping("/today_list")
	// public String today_list() {
	// return "today";
	// }

	// // 좋아요요청 ajax
	// @PostMapping("/today_likes")
	// public boolean todayLikes() {
	// return false;
	// }

	// 글수정 (내 글일경우가능)@@@@@@@@@@
	@GetMapping(value = "/modifyform")
	public ModelAndView modifyform(@RequestParam(value = "articleNo") int articleNo) {
		ModelAndView mav = new ModelAndView();
		try {
			CommBoard commboard = commService.getArticleNo(articleNo);
			mav.addObject("article", commboard);
			mav.setViewName("community/board/modifyform");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("err", e.getMessage());
			mav.setViewName("community/board/err");
		}
		return mav;
	}

	@PostMapping(value = "/modifyform")
	public ModelAndView modifyform(@ModelAttribute CommBoard commboard) {
		ModelAndView mav = new ModelAndView();
		try {
			commService.modifyCommBoard(commboard);
			mav.addObject("articleNo", commboard.getArticleNo());
			mav.setViewName("redirect:/comm/community/viewform/{articleNo}");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("err", e.getMessage());
			mav.setViewName("community/board/err");
		}
		return mav;
	}
	
	
	
	@GetMapping(value = "deleteform")
	public ModelAndView deleteform(@RequestParam(value = "articleNo") int articleNo,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("articleNo", articleNo);
		mv.addObject("page", page);
		mv.setViewName("/community/board/deleteform");
		return mv;
	}

	@PostMapping(value = "boarddelete")
	public ModelAndView boarddelete(@RequestParam(value = "articleNo") int articleNo,
			/* @RequestParam(value = "board_pass") String boardPass, */
			@RequestParam(value = "page", required = false, defaultValue = "1") int page) {
		ModelAndView mv = new ModelAndView();
		try {
			commService.removeCommBoard(articleNo);
			mv.addObject("page", page);
			mv.setViewName("redirect:/comm/listform");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("err", e.getMessage());
			mv.setViewName("/community/board/err");
		}
		return mv;
	}
	
	  //  좋아요
		@ResponseBody
		@PostMapping("/likes")
		public ResponseEntity<String> toggleLikes(@RequestParam("articleNo") String articleNo, 
				@RequestParam("idx") String idx) {
			ResponseEntity<String> result = null;
			
			int rNo = Integer.parseInt(articleNo);
			int useridx = Integer.parseInt(idx);
			
			int processed = 0;
			try {
				if(commService.queryIfILikeThis(rNo, useridx)>0) {
					commService.removeArticleLikes(rNo, useridx);
					processed = -1;
				} else {
					commService.addArticleLikes(rNo, useridx);
					processed = 1;
				}
				Integer val = commService.queryArticleLikes(rNo);
				JSONObject robj = new JSONObject();
				robj.put("currentLikes", val);
				robj.put("processed", processed);
				
				result = new ResponseEntity<String>(robj.toString() , HttpStatus.OK);
//				result = new ResponseEntity<String>("" , HttpStatus.OK);
			} catch(Exception e) {
				e.printStackTrace();
				result = new ResponseEntity<String>("", HttpStatus.BAD_REQUEST);
			}
			
			return result;	
		}
	
	
	
	

//		@ResponseBody
//		@PostMapping("/upload")
//		public void fileupload(@RequestParam(value = "upload") MultipartFile file, HttpServletRequest request,
//				HttpServletResponse resp) {
//			String path = servletContext.getRealPath("boardupload/");
//			String filename = UUID.randomUUID().toString() + "." + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf('.')+1);
//			File destFile = new File(path + filename);
//			PrintWriter writer = null;
//			//JsonObject json = new JsonObject();
//			JSONObject json = new JSONObject();
//			try {
//				file.transferTo(destFile);
//				writer = resp.getWriter();
//				resp.setContentType("text/html;charset=utf-8");
//				resp.setCharacterEncoding("utf-8");
//				json.append("uploaded", 1);
//				json.append("fileName", filename);
//				json.append("url", "/board/fileview/" + filename);
//
//				System.out.println(json);
//				writer.println(json);
//
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
//		}
//
//		@GetMapping(value = "/fileview/{filename}")
//		public void fileview(@PathVariable String filename, HttpServletRequest request, HttpServletResponse response) {
//			String path = servletContext.getRealPath("/boardupload/");
//			File file = new File(path + filename);
//			String sfilename = null;
//			FileInputStream fis = null;
//
//			try {
//				if (request.getHeader("User-Agent").indexOf("MSIE") > -1) {
//					sfilename = URLEncoder.encode(file.getName(), "utf-8");
//				} else {
//					sfilename = new String(file.getName().getBytes("utf-8"), "ISO-8859-1");
//				}
//				response.setCharacterEncoding("utf-8");
//				response.setContentType("application/octet-stream;charset=utf-8");
//				// response.setHeader("Content-Disposition", "attachment;
//				// filename=\""+sfilename+"\";");
//				response.setHeader("Content-Disposition", "attachment; filename=" + sfilename);
//				OutputStream out = response.getOutputStream();
//				fis = new FileInputStream(file);
//				FileCopyUtils.copy(fis, out);
//				out.flush();
//			} catch (Exception e) {
//				e.printStackTrace();
//			} finally {
//				if (fis != null) {
//					try {
//						fis.close();
//					} catch (Exception e) {
//					}
//				}
//			}
//		}
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	// @@@@@@@@    커뮤니티    @@@@@@@@@
//	
//	@GetMapping("/writeform") // 뒤에 url 주소 적는 곳
//	public String writeform() {
//		return "community/board/writeform";
//	}
//
//	@PostMapping("boardwrite")
//	public ModelAndView boardWrite(@ModelAttribute Comm_board board) {
//		ModelAndView mv = new ModelAndView();
//		try {
//			if (!board.getFile().isEmpty()) { // 파일 첨부시 파일 업로드
//				String path = servletContext.getRealPath("/boardupload/");
//				File destFile = new File(path + board.getFile().getOriginalFilename());
//				board.setBoard_filename(board.getFile().getOriginalFilename());
//				// 파일명을 변수에 담은것. 인서트하려고.DB에 넣기위에
//				board.getFile().transferTo(destFile);
//			} // 파일 객체 만들어서 저장 업로드.
//			boardService.regBoard(board);
//			mv.setViewName("redirect:/comm/boardlist");
//		} catch (Exception e) {
//			e.printStackTrace();
//			mv.addObject("err", "새글 등록 실패");
//			mv.setViewName("/community/board/err");
//		}
//		return mv;
//	}
//
//	
//	@RequestMapping(value = "/boardlist", method = { RequestMethod.GET, RequestMethod.POST })
//	public ModelAndView boardList(@RequestParam(value = "page", required = false, defaultValue = "1") int page) {
//		ModelAndView mv = new ModelAndView();
//		PageInfo pageInfo = new PageInfo();
//		try {
//			List<Comm_board> articleList = boardService.getBoardList(page, pageInfo);
//			mv.addObject("pageInfo", pageInfo); // 중요함 아무거나 적으면 안됨 똑같아야함
//			mv.addObject("articleList", articleList);
//			mv.setViewName("/community/board/listform");
//		} catch (Exception e) {
//			e.printStackTrace();
//			mv.addObject("err", e.getMessage());
//			mv.setViewName("/community/board/err");
//		}
//		return mv;
//	}
//	
//	
//
//	@GetMapping(value = "/boarddetail")
//	public ModelAndView boardDetail(@RequestParam(value = "board_num") int boardNum,
//			@RequestParam(value = "page", required = false, defaultValue = "1") int page) {
//		ModelAndView mv = new ModelAndView();
//		try {
//			Comm_board board = boardService.getBoard(boardNum);
//			mv.addObject("article", board);
//			mv.addObject("page", page);
//			mv.setViewName("/community/board/viewform");
//		} catch (Exception e) {
//			e.printStackTrace();
//			mv.addObject("err", e.getMessage());
//			mv.setViewName("/community/board/err");
//		}
//		return mv;
//	}
//
//	@GetMapping(value = "/replyform")
//	public ModelAndView replyform(@RequestParam(value = "board_num") int boardNum,
//			@RequestParam(value = "page") int page) {
//		ModelAndView mv = new ModelAndView();
//		mv.addObject("page", page);
//		mv.addObject("boardNum", boardNum);
//		mv.setViewName("/community/board/replyform");
//		return mv;
//	}
//
//	@PostMapping(value = "boardreply")
//	public ModelAndView boardreply(@ModelAttribute Comm_board board, @RequestParam(value = "page") int page) {
//		ModelAndView mv = new ModelAndView();
//		try {
//			boardService.regReply(board);
//			mv.addObject("page", page);
//			mv.setViewName("redirect:/comm/boardlist");
//		} catch (Exception e) {
//			e.printStackTrace();
//			mv.addObject("err", e.getMessage());
//			mv.setViewName("/community/board/err");
//		}
//		return mv;
//	}
//
//	@GetMapping(value = "modifyform")
//	public ModelAndView modifyform(@RequestParam(value = "board_num") int boardNum) {
//		ModelAndView mv = new ModelAndView();
//		try {
//			Comm_board board = boardService.getBoard(boardNum);
//			mv.addObject("article", board);
//			mv.setViewName("/community/board/modifyform");
//		} catch (Exception e) {
//			e.printStackTrace();
//			mv.addObject("err", e.getMessage());
//			mv.setViewName("/community/board/err");
//
//		}
//		return mv;
//	}
//
//	@PostMapping(value = "boardmodify")
//	public ModelAndView boardmodify(@ModelAttribute Comm_board board) {
//		ModelAndView mv = new ModelAndView();
//		try {
//			boardService.modifyBoard(board);
//			mv.addObject("board_num", board.getBoard_num());
//			mv.setViewName("redirect:/comm/boarddetail");
//		} catch (Exception e) {
//			e.printStackTrace();
//			mv.addObject("err", e.getMessage());
//			mv.setViewName("/community/board/err");
//		}
//		return mv;
//	}
//
//	@GetMapping(value = "deleteform")
//	public ModelAndView deleteform(@RequestParam(value = "board_num") int boardNum,
//			@RequestParam(value = "page", required = false, defaultValue = "1") int page) {
//		ModelAndView mv = new ModelAndView();
//		mv.addObject("board_num", boardNum);
//		mv.addObject("page", page);
//		mv.setViewName("/community/board/deleteform");
//		return mv;
//	}
//
//	@PostMapping(value = "boarddelete")
//	public ModelAndView boarddelete(@RequestParam(value = "board_num") int boardNum,
//			@RequestParam(value = "board_pass") String boardPass,
//			@RequestParam(value = "page", required = false, defaultValue = "1") int page) {
//		ModelAndView mv = new ModelAndView();
//		try {
//			boardService.removeBoard(boardNum, boardPass);
//			mv.addObject("page", page);
//			mv.setViewName("redirect:/comm/boardlist");
//		} catch (Exception e) {
//			e.printStackTrace();
//			mv.addObject("err", e.getMessage());
//			mv.setViewName("/community/board/err");
//		}
//		return mv;
//	}
//	
//	
//	
//	//@@@@@@@@@@@@@@@   공지사항   @@@@@@@@@@@@@@@@@
//	
//
//	
//	@GetMapping("/writeformN") // 뒤에 url 주소 적는 곳
//	public String writeformN() {
//		return "community/notice/writeformN";
//	}
//
//	@PostMapping("boardwriteN")
//	public ModelAndView boardWriteN(@ModelAttribute Comm_board board) {
//		ModelAndView mv = new ModelAndView();
//		try {
//			if (!board.getFile().isEmpty()) { // 파일 첨부시 파일 업로드
//				String path = servletContext.getRealPath("/boardupload/");
//				File destFile = new File(path + board.getFile().getOriginalFilename());
//				board.setBoard_filename(board.getFile().getOriginalFilename());
//				// 파일명을 변수에 담은것. 인서트하려고.DB에 넣기위에
//				board.getFile().transferTo(destFile);
//			} // 파일 객체 만들어서 저장 업로드.
//			boardService.regBoard(board);
//			mv.setViewName("redirect:/comm/boardlistN");
//		} catch (Exception e) {
//			e.printStackTrace();
//			mv.addObject("err", "새글 등록 실패");
//			mv.setViewName("/community/notice/errN");
//		}
//		return mv;
//	}
//
//	
//	@RequestMapping(value = "/boardlistN", method = { RequestMethod.GET, RequestMethod.POST })
//	public ModelAndView boardListN(@RequestParam(value = "page", required = false, defaultValue = "1") int page) {
//		ModelAndView mv = new ModelAndView();
//		PageInfo pageInfo = new PageInfo();
//		try {
//			List<Comm_board> articleList = boardService.getBoardList(page, pageInfo);
//			mv.addObject("pageInfo", pageInfo); // 중요함 아무거나 적으면 안됨 똑같아야함
//			mv.addObject("articleList", articleList);
//			mv.setViewName("/community/notice/listformN");
//		} catch (Exception e) {
//			e.printStackTrace();
//			mv.addObject("err", e.getMessage());
//			mv.setViewName("/community/notice/errN");
//		}
//		return mv;
//	}
//	
//	
//
//	@GetMapping(value = "/boarddetailN")
//	public ModelAndView boardDetailN(@RequestParam(value = "board_num") int boardNum,
//			@RequestParam(value = "page", required = false, defaultValue = "1") int page) {
//		ModelAndView mv = new ModelAndView();
//		try {
//			Comm_board board = boardService.getBoard(boardNum);
//			mv.addObject("article", board);
//			mv.addObject("page", page);
//			mv.setViewName("/community/notice/viewformN");
//		} catch (Exception e) {
//			e.printStackTrace();
//			mv.addObject("err", e.getMessage());
//			mv.setViewName("/community/notice/errN");
//		}
//		return mv;
//	}
//
//	@GetMapping(value = "/replyformN")
//	public ModelAndView replyformN(@RequestParam(value = "board_num") int boardNum,
//			@RequestParam(value = "page") int page) {
//		ModelAndView mv = new ModelAndView();
//		mv.addObject("page", page);
//		mv.addObject("boardNum", boardNum);
//		mv.setViewName("/community/notice/replyformN");
//		return mv;
//	}
//
//	@PostMapping(value = "boardreplyN")
//	public ModelAndView boardreplyN(@ModelAttribute Comm_board board, @RequestParam(value = "page") int page) {
//		ModelAndView mv = new ModelAndView();
//		try {
//			boardService.regReply(board);
//			mv.addObject("page", page);
//			mv.setViewName("redirect:/comm/boardlistN");
//		} catch (Exception e) {
//			e.printStackTrace();
//			mv.addObject("err", e.getMessage());
//			mv.setViewName("/community/notice/errN");
//		}
//		return mv;
//	}
//
//	@GetMapping(value = "modifyformN")
//	public ModelAndView modifyformN(@RequestParam(value = "board_num") int boardNum) {
//		ModelAndView mv = new ModelAndView();
//		try {
//			Comm_board board = boardService.getBoard(boardNum);
//			mv.addObject("article", board);
//			mv.setViewName("/community/notice/modifyformN");
//		} catch (Exception e) {
//			e.printStackTrace();
//			mv.addObject("err", e.getMessage());
//			mv.setViewName("/community/notice/errN");
//
//		}
//		return mv;
//	}
//
//	@PostMapping(value = "boardmodifyN")
//	public ModelAndView boardmodifyN(@ModelAttribute Comm_board board) {
//		ModelAndView mv = new ModelAndView();
//		try {
//			boardService.modifyBoard(board);
//			mv.addObject("board_num", board.getBoard_num());
//			mv.setViewName("redirect:/comm/boarddetailN");
//		} catch (Exception e) {
//			e.printStackTrace();
//			mv.addObject("err", e.getMessage());
//			mv.setViewName("/community/notice/errN");
//		}
//		return mv;
//	}
//
//	@GetMapping(value = "deleteformN")
//	public ModelAndView deleteformN(@RequestParam(value = "board_num") int boardNum,
//			@RequestParam(value = "page", required = false, defaultValue = "1") int page) {
//		ModelAndView mv = new ModelAndView();
//		mv.addObject("board_num", boardNum);
//		mv.addObject("page", page);
//		mv.setViewName("/community/notice/deleteformN");
//		return mv;
//	}
//
//	@PostMapping(value = "boarddeleteN")
//	public ModelAndView boarddeleteN(@RequestParam(value = "board_num") int boardNum,
//			@RequestParam(value = "board_pass") String boardPass,
//			@RequestParam(value = "page", required = false, defaultValue = "1") int page) {
//		ModelAndView mv = new ModelAndView();
//		try {
//			boardService.removeBoard(boardNum, boardPass);
//			mv.addObject("page", page);
//			mv.setViewName("redirect:/comm/boardlistN");
//		} catch (Exception e) {
//			e.printStackTrace();
//			mv.addObject("err", e.getMessage());
//			mv.setViewName("/community/notice/errN");
//		}
//		return mv;
//	}

}