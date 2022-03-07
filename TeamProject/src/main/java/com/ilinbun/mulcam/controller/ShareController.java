package com.ilinbun.mulcam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ilinbun.mulcam.dto.Shareboard;
import com.ilinbun.mulcam.service.ShareService;

@Controller
@RequestMapping("/share")
public class ShareController {
	
	@Autowired
	ShareService shareService;
	
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
	
	@GetMapping("/writeform")
	public String writeform() {
		return "share/writeform";
	}
}
