package com.ilinbun.mulcam.controller;

import java.util.ArrayList;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
@RequestMapping("/comm")
public class CommunityController {
	@GetMapping("")
	public String Main(Model m) {
		
		return "community/main";
	}

//	@GetMapping("/test")
//	public String Main() {
//		return "/community/test";
//	}
}
