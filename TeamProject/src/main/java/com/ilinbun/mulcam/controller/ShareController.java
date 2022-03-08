package com.ilinbun.mulcam.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.UUID;

import javax.servlet.ServletContext;
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
import org.springframework.web.servlet.ModelAndView;

import com.ilinbun.mulcam.dto.BragBoard;
import com.ilinbun.mulcam.dto.Shareboard;
import com.ilinbun.mulcam.service.ShareService;

@Controller
@RequestMapping("/share")
public class ShareController {
	
	@Autowired
	ShareService shareService;
	
	@Autowired
	ServletContext servletContext;
	
	@Autowired(required=false)
	Shareboard shareboard;
	
	@GetMapping("")
	public String Main(Model model) {
		try {
			shareboard = shareService.shareboard();
			model.addAttribute("shareboard",shareboard);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "share/main";
	}
	
	// CKEditor 적용파트
	
	@GetMapping("/")
	public String home() {
		return "ckeditor";
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

			System.out.println(json);
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

	@PostMapping("/sharewrite")
	public String sharewriteform(@RequestParam String title, 
			@RequestParam String content,
			@RequestParam String subway, 
			@RequestParam int idx, 
			Model model) {
		
		System.out.println(title); // DB저장
		System.out.println(content.trim()); // DB저장, 반드시 trim()
		
		try {
			Shareboard shareboard = new Shareboard(title, subway, content, idx);
			shareService.regShareBoard(shareboard);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("title", title);
		model.addAttribute("content", content.trim());
		return "share/main"; //resultForm다시
	}
	
	// 글쓰기 -> CKEditor 결합
	
	@GetMapping("/board/writeform")
	public String writeform(Model model) {
		HttpSession session = null; //로그인
		String test = "km@ilin.bun";
		model.addAttribute("email", test);
		return "share/board/writeform";
	}
	
	//글보기
	
	@PostMapping("/board/{id}")
	public ModelAndView placeInfo(@PathVariable String id) throws Exception {
		ModelAndView mv = new ModelAndView("share/board/viewform");
//		shareboard = shareService.shareBoardQueryByID(id);
		mv.addObject("shareboard", shareboard);

		return mv;
	}
	
	// 글수정
	
	@GetMapping(value = "/board/modifyform")
	public ModelAndView sharemodifyform(@RequestParam(value = "articleNo") int articleNo) {
		ModelAndView mav = new ModelAndView();
		try {
			Shareboard Shareboard = shareService.getArticleNo(articleNo);
			mav.addObject("article", Shareboard);
			mav.setViewName("share/modifyForm");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("err", e.getMessage());
			mav.setViewName("/share/err");
		}
		return mav;
	}

	@PostMapping(value = "/board/sharemodify")
	public ModelAndView sharemodify(@ModelAttribute BragBoard bragboard) {
		ModelAndView mav = new ModelAndView();
		try {
			shareService.modifyShareBoard(shareboard);
			mav.addObject("articleNo", shareboard.getArticleNo());
			mav.setViewName("redirect:/share/viewDetail");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("err", e.getMessage());
			mav.setViewName("share/err");
		}
		return mav;
	}
	
}
