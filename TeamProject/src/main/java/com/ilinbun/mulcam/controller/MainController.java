package com.ilinbun.mulcam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {
	@GetMapping("/")
	public ModelAndView main() {
		ModelAndView mv = new ModelAndView("index");
		mv.addObject("cpage", "main");
		return mv;
	}
	
	@GetMapping("/brag")
	public String BragMain() {
		return "brag/bragmain";
	}
}
