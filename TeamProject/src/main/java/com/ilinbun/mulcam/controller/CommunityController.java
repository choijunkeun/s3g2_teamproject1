package com.ilinbun.mulcam.controller;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ilinbun.mulcam.dto.Com_board;
import com.ilinbun.mulcam.dto.PageInfo;
import com.ilinbun.mulcam.service.BoardService;

//@Controller
//@RequestMapping("/comm")
//public class CommunityController {
//	@GetMapping("")
//	public String Main(Model m) {
//		
//		return "community/main";
//	}
//}

//	@GetMapping("/test")
//	public String Main() {
//		return "/community/test";
//	}
//}
@Controller
@RequestMapping("/comm")
public class CommunityController {
	@Autowired
	private BoardService boardService;

	@Autowired
	private ServletContext servletContext;

	@GetMapping("")
	public String Main(Model m) {
		return "community/main";
	}


	
	
	// @@@@@@@@    커뮤니티    @@@@@@@@@
	
	@GetMapping("/writeform") // 뒤에 url 주소 적는 곳
	public String writeform() {
		return "community/board/writeform";
	}

	@PostMapping("boardwrite")
	public ModelAndView boardWrite(@ModelAttribute Com_board board) {
		ModelAndView mv = new ModelAndView();
		try {
			if (!board.getFile().isEmpty()) { // 파일 첨부시 파일 업로드
				String path = servletContext.getRealPath("/boardupload/");
				File destFile = new File(path + board.getFile().getOriginalFilename());
				board.setBoard_filename(board.getFile().getOriginalFilename());
				// 파일명을 변수에 담은것. 인서트하려고.DB에 넣기위에
				board.getFile().transferTo(destFile);
			} // 파일 객체 만들어서 저장 업로드.
			boardService.regBoard(board);
			mv.setViewName("redirect:/comm/boardlist");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("err", "새글 등록 실패");
			mv.setViewName("/community/board/err");
		}
		return mv;
	}

	
	@RequestMapping(value = "/boardlist", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView boardList(@RequestParam(value = "page", required = false, defaultValue = "1") int page) {
		ModelAndView mv = new ModelAndView();
		PageInfo pageInfo = new PageInfo();
		try {
			List<Com_board> articleList = boardService.getBoardList(page, pageInfo);
			mv.addObject("pageInfo", pageInfo); // 중요함 아무거나 적으면 안됨 똑같아야함
			mv.addObject("articleList", articleList);
			mv.setViewName("/community/board/listform");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("err", e.getMessage());
			mv.setViewName("/community/board/err");
		}
		return mv;
	}
	
	

	@GetMapping(value = "/boarddetail")
	public ModelAndView boardDetail(@RequestParam(value = "board_num") int boardNum,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page) {
		ModelAndView mv = new ModelAndView();
		try {
			Com_board board = boardService.getBoard(boardNum);
			mv.addObject("article", board);
			mv.addObject("page", page);
			mv.setViewName("/community/board/viewform");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("err", e.getMessage());
			mv.setViewName("/community/board/err");
		}
		return mv;
	}

	@GetMapping(value = "/replyform")
	public ModelAndView replyform(@RequestParam(value = "board_num") int boardNum,
			@RequestParam(value = "page") int page) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("page", page);
		mv.addObject("boardNum", boardNum);
		mv.setViewName("/community/board/replyform");
		return mv;
	}

	@PostMapping(value = "boardreply")
	public ModelAndView boardreply(@ModelAttribute Com_board board, @RequestParam(value = "page") int page) {
		ModelAndView mv = new ModelAndView();
		try {
			boardService.regReply(board);
			mv.addObject("page", page);
			mv.setViewName("redirect:/comm/boardlist");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("err", e.getMessage());
			mv.setViewName("/community/board/err");
		}
		return mv;
	}

	@GetMapping(value = "modifyform")
	public ModelAndView modifyform(@RequestParam(value = "board_num") int boardNum) {
		ModelAndView mv = new ModelAndView();
		try {
			Com_board board = boardService.getBoard(boardNum);
			mv.addObject("article", board);
			mv.setViewName("/community/board/modifyform");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("err", e.getMessage());
			mv.setViewName("/community/board/err");

		}
		return mv;
	}

	@PostMapping(value = "boardmodify")
	public ModelAndView boardmodify(@ModelAttribute Com_board board) {
		ModelAndView mv = new ModelAndView();
		try {
			boardService.modifyBoard(board);
			mv.addObject("board_num", board.getBoard_num());
			mv.setViewName("redirect:/comm/boarddetail");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("err", e.getMessage());
			mv.setViewName("/community/board/err");
		}
		return mv;
	}

	@GetMapping(value = "deleteform")
	public ModelAndView deleteform(@RequestParam(value = "board_num") int boardNum,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("board_num", boardNum);
		mv.addObject("page", page);
		mv.setViewName("/community/board/deleteform");
		return mv;
	}

	@PostMapping(value = "boarddelete")
	public ModelAndView boarddelete(@RequestParam(value = "board_num") int boardNum,
			@RequestParam(value = "board_pass") String boardPass,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page) {
		ModelAndView mv = new ModelAndView();
		try {
			boardService.removeBoard(boardNum, boardPass);
			mv.addObject("page", page);
			mv.setViewName("redirect:/comm/boardlist");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("err", e.getMessage());
			mv.setViewName("/community/board/err");
		}
		return mv;
	}
	
	
	
	//@@@@@@@@@@@@@@@   공지사항   @@@@@@@@@@@@@@@@@
	

	
	@GetMapping("/writeformN") // 뒤에 url 주소 적는 곳
	public String writeformN() {
		return "community/notice/writeformN";
	}

	@PostMapping("boardwriteN")
	public ModelAndView boardWriteN(@ModelAttribute Com_board board) {
		ModelAndView mv = new ModelAndView();
		try {
			if (!board.getFile().isEmpty()) { // 파일 첨부시 파일 업로드
				String path = servletContext.getRealPath("/boardupload/");
				File destFile = new File(path + board.getFile().getOriginalFilename());
				board.setBoard_filename(board.getFile().getOriginalFilename());
				// 파일명을 변수에 담은것. 인서트하려고.DB에 넣기위에
				board.getFile().transferTo(destFile);
			} // 파일 객체 만들어서 저장 업로드.
			boardService.regBoard(board);
			mv.setViewName("redirect:/comm/boardlistN");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("err", "새글 등록 실패");
			mv.setViewName("/community/notice/errN");
		}
		return mv;
	}

	
	@RequestMapping(value = "/boardlistN", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView boardListN(@RequestParam(value = "page", required = false, defaultValue = "1") int page) {
		ModelAndView mv = new ModelAndView();
		PageInfo pageInfo = new PageInfo();
		try {
			List<Com_board> articleList = boardService.getBoardList(page, pageInfo);
			mv.addObject("pageInfo", pageInfo); // 중요함 아무거나 적으면 안됨 똑같아야함
			mv.addObject("articleList", articleList);
			mv.setViewName("/community/notice/listformN");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("err", e.getMessage());
			mv.setViewName("/community/notice/errN");
		}
		return mv;
	}
	
	

	@GetMapping(value = "/boarddetailN")
	public ModelAndView boardDetailN(@RequestParam(value = "board_num") int boardNum,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page) {
		ModelAndView mv = new ModelAndView();
		try {
			Com_board board = boardService.getBoard(boardNum);
			mv.addObject("article", board);
			mv.addObject("page", page);
			mv.setViewName("/community/notice/viewformN");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("err", e.getMessage());
			mv.setViewName("/community/notice/errN");
		}
		return mv;
	}

	@GetMapping(value = "/replyformN")
	public ModelAndView replyformN(@RequestParam(value = "board_num") int boardNum,
			@RequestParam(value = "page") int page) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("page", page);
		mv.addObject("boardNum", boardNum);
		mv.setViewName("/community/notice/replyformN");
		return mv;
	}

	@PostMapping(value = "boardreplyN")
	public ModelAndView boardreplyN(@ModelAttribute Com_board board, @RequestParam(value = "page") int page) {
		ModelAndView mv = new ModelAndView();
		try {
			boardService.regReply(board);
			mv.addObject("page", page);
			mv.setViewName("redirect:/comm/boardlistN");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("err", e.getMessage());
			mv.setViewName("/community/notice/errN");
		}
		return mv;
	}

	@GetMapping(value = "modifyformN")
	public ModelAndView modifyformN(@RequestParam(value = "board_num") int boardNum) {
		ModelAndView mv = new ModelAndView();
		try {
			Com_board board = boardService.getBoard(boardNum);
			mv.addObject("article", board);
			mv.setViewName("/community/notice/modifyformN");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("err", e.getMessage());
			mv.setViewName("/community/notice/errN");

		}
		return mv;
	}

	@PostMapping(value = "boardmodifyN")
	public ModelAndView boardmodifyN(@ModelAttribute Com_board board) {
		ModelAndView mv = new ModelAndView();
		try {
			boardService.modifyBoard(board);
			mv.addObject("board_num", board.getBoard_num());
			mv.setViewName("redirect:/comm/boarddetailN");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("err", e.getMessage());
			mv.setViewName("/community/notice/errN");
		}
		return mv;
	}

	@GetMapping(value = "deleteformN")
	public ModelAndView deleteformN(@RequestParam(value = "board_num") int boardNum,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("board_num", boardNum);
		mv.addObject("page", page);
		mv.setViewName("/community/notice/deleteformN");
		return mv;
	}

	@PostMapping(value = "boarddeleteN")
	public ModelAndView boarddeleteN(@RequestParam(value = "board_num") int boardNum,
			@RequestParam(value = "board_pass") String boardPass,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page) {
		ModelAndView mv = new ModelAndView();
		try {
			boardService.removeBoard(boardNum, boardPass);
			mv.addObject("page", page);
			mv.setViewName("redirect:/comm/boardlistN");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("err", e.getMessage());
			mv.setViewName("/community/notice/errN");
		}
		return mv;
	}

	
}