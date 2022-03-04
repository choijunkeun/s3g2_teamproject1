package com.ilinbun.mulcam.controller;

import java.io.File;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ilinbun.mulcam.dto.Bragboard;
import com.ilinbun.mulcam.service.BragService;

@Controller
@RequestMapping("/brag")
public class BragController {
	@Autowired
	BragService bragService;
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired(required=false)
	Bragboard bragboard;
	
	//이달의 혼밥 사진 나타내는 컨트롤러
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
	
	//BEST 게시판
	@GetMapping("/best")
	public String Best() {
		return "brag/best";
	}
	
	//혼밥자랑 게시판
	@GetMapping("/brag")
	public String brag() {
		return "brag/brag";
	}
	
	//글쓰기
	@GetMapping("/writeform")
	public String bragwriteform() {
		return "brag/writeForm";
	}
	@PostMapping("bragwrite")
	public ModelAndView bragWrite(@ModelAttribute Bragboard bragboard) {
		ModelAndView mav=new ModelAndView();
		//예외처리 시 응답으로 보여줄 jsp 화면이 다르기 때문에 생성자에 viewName을 담지 않았다.
		try {
			if(!bragboard.getFile().isEmpty()) { //file input태그는 required 형태가 아니므로
				//넘어온 데이터가 있을 경우에만 파일 처리를 한다.
				String path=servletContext.getRealPath("/bragupload/");
				File destFile=new File(path+bragboard.getFile().getOriginalFilename());
				bragboard.setImgfilename(bragboard.getFile().getOriginalFilename());
				//Board 객체의 멤버변수값 초기화하는 작업
				bragboard.getFile().transferTo(destFile);
				//서버 저장 경로(destFile)에 매개변수로 가져온 파일 객체(board.getFile())를 복사하여 저장(transferTo)
			}
			bragService.regBragBoard(bragboard);
			mav.setViewName("redirect:/brag/brag");
			//foward방식으로 넘겨주는것이 아니라 redirect로 다시 일반게시판 컨트롤러로 요청한다.
		} catch(Exception e) {
			e.printStackTrace();
			mav.addObject("err", "새글 등록 실패");
			mav.setViewName("brag/err");
		}
		return mav;
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
//	
//	//글보기
//	@GetMapping(value="viewdetail")
//	public ModelAndView boardDeatail(@RequestParam(value="board_num")int boardNum,
//			@RequestParam(value="page", required=false, defaultValue="1")int page) {
//		ModelAndView mav=new ModelAndView();
//		try {
//			Board board=boardService.getBoard(boardNum);
//			mav.addObject("article", board);
//			mav.addObject("page", page);
//			mav.setViewName("brag/viewDetail");
//		} catch(Exception e) {
//			e.printStackTrace();
//			mav.addObject("err", e.getMessage());
//			mav.setViewName("brag/err");
//		}
//		return mav;
//	}
	
	//글보기?? 훈이꺼 reviewForm controller
	@PostMapping("/{id}")
	public ModelAndView placeInfo(@PathVariable String id) throws Exception {
		ModelAndView mv = new ModelAndView("brag/brag/view");
		bragboard = bragService.bragBoardQueryByID(id);
		mv.addObject("bragboard", bragboard);
		
		return mv;
	}
	
	//글수정 (내 글일경우가능)
		@GetMapping(value="/modifyform")
		public ModelAndView bragmodifyform(@RequestParam(value="articleNo")int articleNo) {
			ModelAndView mav=new ModelAndView();
			try {
				Bragboard Bragboard = bragService.getArticleNo(articleNo);
				mav.addObject("article", Bragboard);
				mav.setViewName("brag/modifyForm");
			} catch(Exception e) {
				e.printStackTrace();
				mav.addObject("err", e.getMessage());
				mav.setViewName("/brag/err");
			}
			return mav;
		}
		
		@PostMapping(value="/bragmodify")
		public ModelAndView bragmodify(@ModelAttribute Bragboard bragboard) {
			ModelAndView mav=new ModelAndView();
			try {
				bragService.modifyBragBoard(bragboard);
				mav.addObject("articleNo", bragboard.getArticleNo());
				mav.setViewName("redirect:/brag/viewDetail");
			} catch(Exception e) {
				e.printStackTrace();
				mav.addObject("err", e.getMessage());
				mav.setViewName("brag/err");
			}
			return mav;
		}
		
		//글삭제 (내 글일경우가능)	
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
//				OutputStream out=response.getOutputStream();
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
































