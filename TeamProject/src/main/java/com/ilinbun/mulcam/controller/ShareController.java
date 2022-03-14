package com.ilinbun.mulcam.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;

import javax.lang.model.element.Element;
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
import com.ilinbun.mulcam.dto.Shareboard;
import com.ilinbun.mulcam.dto.User;
import com.ilinbun.mulcam.service.ShareService;

@Controller
@RequestMapping("/share") // localhost://8090/share~
public class ShareController {
	
	@Autowired
	HttpSession session;
	
	@Autowired
	ShareService shareService;
	
	@Autowired
	ServletContext servletContext;
	
	@Autowired(required=false)
	Shareboard shareboard;
	
	// main.jsp 화면 출력 (현재 공지사항 게시판 + 반찬공유 게시판)
	@GetMapping("")
	public String Main(Model model) {
		try {
			List<Shareboard> shareList = shareService.getShareboardList(1);
			model.addAttribute("shareList", shareList);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "share/main";
	}
	
	// listform.jsp (반찬공유 게시판 일반)
	@GetMapping("/board/listform")
	public ModelAndView share_list(@RequestParam(value="page", required=false, defaultValue="1") int page) {
		// User userInfo = (User) session.getAttribute("user"); //User session이 email이 아닌 account(password제외)일때 다시 연결하자
		ModelAndView mav=new ModelAndView();
		PageInfo pageInfo=new PageInfo();
		pageInfo.setPage(page);
		try {
			List<Shareboard> shareList=shareService.getShareboardList(page);
			for(Shareboard share : shareList) {
				Document doc=Jsoup.parse(share.getContent());
				Elements img = doc.select("img");
				String src = img.attr("src");
				share.setContent(src);
			}
			pageInfo=shareService.getPageInfo(pageInfo);
			// mav.addObject("userInfo", userInfo); //same as above
			mav.addObject("pageInfo", pageInfo);
			mav.addObject("shareList", shareList);
			mav.setViewName("share/board/listform");
			
			System.out.println("pageInfo2 check : "+pageInfo);
			System.out.println("sharelist check : "+ shareList);
			
		} catch(Exception e) {
			e.printStackTrace();
			mav.addObject("err", e.getMessage());
			mav.setViewName("err");
		}
		return mav;
	}

	// 글쓰기 -> CKEditor 결합	
	
		@GetMapping("/board/writeform")
		public String writeform(Model model) {
			HttpSession session = null; //로그인
			String test = "km@ilin.bun";
			model.addAttribute("email", test);
			return "share/board/writeform";
		}
		@PostMapping("/board/sharewrite")
		public String sharewriteform(@RequestParam String title, 
				@RequestParam String content,
				@RequestParam String subway, 
				@RequestParam int idx, 
				@RequestParam int headerTag,
				Model model) {
			
			System.out.println("title : "+title); // DB저장
			System.out.println("content : "+content.trim()); // DB저장, 반드시 trim()
			System.out.println("subway : "+subway);
			System.out.println("idx : "+idx);
			System.out.println("headerTag: "+headerTag);
			
			try {
				Shareboard shareboard = new Shareboard(title, subway, content, idx, headerTag);
				Document doc=Jsoup.parse(shareboard.getContent());
				Elements docContentElements = doc.body().children();
				String result = "";
				for(org.jsoup.nodes.Element e: docContentElements) {
					if(e.tagName().equals("figure")) {
						e = e.selectFirst("img");
						String src = e.attr("src");
						String newSrc =src.substring(src.indexOf("share/fileview/")+("share/fileview/").length());
						e.attr("src", "/shareupload/"+newSrc);
					}
					result += e.toString();
				}
				
//				if (doc.hasAttr("img")) {
//				Elements img= doc.select("img");
//				if(img.isEmpty() == false) {
//					for(org.jsoup.nodes.Element e : img) {
//						String src = e.attr("src");
//						/* System.out.println("img tag found : " + src); */
//						String newSrc =src.substring(src.indexOf("share/fileview/")+("share/fileview/").length());
//						e.attr("src", "/shareupload/"+newSrc);
//						System.out.println(e.attr("src"));
//					};
//					shareboard.setContent(doc.select("body > p").toString());
////					String src = img.attr("src");
////					String newSrc =src.substring(src.indexOf("share/fileview/")+("share/fileview/").length());
////					doc.select("img").attr("src", "/shareupload/"+newSrc);
////					shareboard.setContent(doc.select("body > p").toString());
//				} /*else {*/
//					model.addAttribute("msg", "사진은 필수야");
					//return "share/board/writeform";
					/* } */
				shareboard.setContent(result);
				shareService.regShareBoard(shareboard);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			model.addAttribute("title", title);
			model.addAttribute("content", content.trim());
			return "redirect:/share/board/listform"; //resultForm다시
		}

	@ResponseBody
	@PostMapping("/upload")
	public void fileupload(@RequestParam(value = "upload") MultipartFile file, HttpServletRequest request,
			HttpServletResponse resp) {
		String path = servletContext.getRealPath("/shareupload/");
		String filename = UUID.randomUUID().toString() + "." + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf('.')+1);
		File destFile = new File(path + filename);
		PrintWriter writer = null;
		JSONObject json = new JSONObject();
		try {
			file.transferTo(destFile);
			writer = resp.getWriter();
			resp.setContentType("text/html;charset=utf-8");
			resp.setCharacterEncoding("utf-8");
			json.append("uploaded", 1);
			json.append("fileName", filename);
			json.append("url", "/share/fileview/" + filename);

			System.out.println("json"+json);
			writer.println(json);

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@GetMapping(value = "/fileview/{filename}")
	public void fileview(@PathVariable String filename, HttpServletRequest request, HttpServletResponse response) {
		String path = servletContext.getRealPath("/shareupload/");
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

	
	
	//글보기
	@GetMapping("/board/viewform/{articleNo}")
	public ModelAndView boardDetail(@PathVariable int articleNo,
			@RequestParam(required=false, defaultValue="1") int page) {
//		User userinfo = (User) session.getAttribute("user"); //same
//		User userinfo = new User(1, "mockup@mock.up", "목업", "", "#", 5, 1); //임시 
		ModelAndView mav=new ModelAndView();
		try {
			shareboard=shareService.getShareboard(articleNo); //내가쓴글, 남이쓴글 확인
			User userinfo = shareService.selectUserDetail(shareboard.getIdx());
			mav.addObject("userinfo", userinfo);
			mav.addObject("shboard", shareboard);
			mav.addObject("page", page);
			System.out.println("shareboard check : "+shareboard);
			
			Document doc=Jsoup.parse(shareboard.getContent()); //content중에 사진만 가져오기
			Elements img= doc.select("img"); //우선 무수한 요소 중 img만 추출
			String src = img.attr("src"); //String으로 변환
			
			mav.addObject("imgSrc", src); //mav에 넣기
			mav.setViewName("share/board/viewform"); //경로이름 설정
		} catch(Exception e) {
			e.printStackTrace();
			mav.addObject("err", e.getMessage());
			mav.setViewName("err");
		}
		return mav;
	}
	
	/*
	 * @PostMapping("/board/{id}") public ModelAndView placeInfo(@PathVariable
	 * String id) throws Exception { ModelAndView mv = new
	 * ModelAndView("share/board/viewform"); shareboard =
	 * shareService.shareBoardQueryByID(id); mv.addObject("shareboard", shareboard);
	 * 
	 * return mv; }
	 */
	
	// 글수정 (내 글일경우가능)
		@PostMapping(value = "/modifyform")
		public ModelAndView modifyform(@RequestParam(value = "articleNo") int articleNo, HttpServletRequest request) {
			ModelAndView mav = new ModelAndView();
			
			HttpSession session = request.getSession();
			User user = (User)session.getAttribute("user");
			Integer idx = null;
			if(user !=null) idx = user.getIdx();
			try {
				Shareboard shareboard = shareService.getShareboard(articleNo);
				if(shareboard.getIdx() != idx) throw new Exception("로그인한 사람과 글 작성자가 다릅니다");
				
				mav.addObject("shboard", shareboard);
				mav.setViewName("share/board/modifyform");
			} catch (Exception e) {
				e.printStackTrace();
				mav.addObject("err", e.getMessage());
				mav.setViewName("/main/err");
			}
			return mav;
		}

		@PostMapping(value = "/sharemodify")
		public ModelAndView sharemodify(@ModelAttribute Shareboard shareboard) {
			ModelAndView mav = new ModelAndView();
			try {
				shareService.modifyShareBoard(shareboard);
				mav.addObject("articleNo", shareboard.getArticleNo());
				mav.setViewName("redirect:/share/board/viewform/" + shareboard.getArticleNo());
			} catch (Exception e) {
				e.printStackTrace();
				mav.addObject("err", e.getMessage());
				mav.setViewName("main/err");
			}
			return mav;
		}
//	
//	@GetMapping(value = "/board/modifyform{articleNo}")
//	public ModelAndView sharemodifyform(@RequestParam(value = "articleNo") int articleNo) {
//		ModelAndView mav = new ModelAndView();
//		try {
//			Shareboard Shareboard = shareService.getArticleNo(articleNo);
//			mav.addObject("article", Shareboard);
//			mav.setViewName("share/board/modifyform");
//		} catch (Exception e) {
//			e.printStackTrace();
//			mav.addObject("err", e.getMessage());
//			mav.setViewName("/main/err");
//		}
//		return mav;
//	}
//
//	@PostMapping(value = "/board/modifyform/{articleNo}")
//	public ModelAndView modifyform(@ModelAttribute Shareboard shareboard) {
//		ModelAndView mav = new ModelAndView();
//		try {
//			shareService.modifyShareBoard(shareboard);
//			mav.addObject("articleNo", shareboard.getArticleNo());
//			mav.setViewName("redirect:/share/board/viewform/{articleNo}");
//		} catch (Exception e) {
//			e.printStackTrace();
//			mav.addObject("err", e.getMessage());
//			mav.setViewName("/main/err");
//		}
//		return mav;
//	}
	
	//글 삭제
	@PostMapping(value = "deleteform")
	public ModelAndView deleteform(@RequestParam(value = "articleNo") int articleNo,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page) {
		ModelAndView mv = new ModelAndView();
		try {
			shareService.removeShareBoard(articleNo);
			mv.addObject("page", page);
			mv.setViewName("redirect:/share/board/listform");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("err", e.getMessage());
			mv.setViewName("/main/err");
		}
		return mv;
	}
	
}
