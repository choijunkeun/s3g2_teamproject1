package com.ilinbun.mulcam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SearchController {
	@GetMapping("/search")
	public ModelAndView searchpage() {
		ModelAndView mv = new ModelAndView("index");
		mv.addObject("cpage", "search/search");
		return mv;
		
	}
}
