package com.ilinbun.mulcam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/search")
public class SearchController {
	@GetMapping({"/", ""})
	public String searchMain() {
		return "search/main";
	}
	
//	@PostMapping({"/"})
//	public String searchWithOptionFromMain() {
//		return "search/main";
//	}
}
