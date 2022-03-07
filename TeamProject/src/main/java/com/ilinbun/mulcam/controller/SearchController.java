package com.ilinbun.mulcam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/search")
public class SearchController {
	@GetMapping({"/", ""})
	public String searchMain() {
		return "search/main";
	}
	@GetMapping({"/test"})
	public String searchtest() {
		return "search/test";
	}
	
	@PostMapping({"", "/"})
	public String searchWithOptionFromMain(@RequestParam(value="keyword", required=false) String keyword,
			@RequestParam(value="level-group", required=false) String honbablv,
			Model model) {
		model.addAttribute("keyword", keyword);
		model.addAttribute("honbablv", honbablv);
		//if(honbablv != null) System.out.println(honbablv);
		//else System.out.println("honbablv not set");
		
		
		return "search/main";
	}
}
