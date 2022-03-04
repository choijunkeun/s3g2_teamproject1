package com.ilinbun.mulcam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ilinbun.mulcam.dto.Bragboard;
import com.ilinbun.mulcam.service.BragService;

@Controller
@RequestMapping("/brag")
public class BragController {
	@Autowired
	BragService bragService;
	
	@Autowired(required=false)
	Bragboard bragboard;
	
	@GetMapping("")
	public String Main(Model model) {
		try {
			bragboard = bragService.bragBest1();
			model.addAttribute("BragBest1", bragboard);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "brag/main";
	}
	@GetMapping("/best")
	public String Best() {
		return "brag/best";
	}
	@GetMapping("/brag")
	public String brag() {
		return "brag/brag";
	}
	@GetMapping("/writeform")
	public String writeform() {
		return "brag/writeform";
	}
	
	
}
