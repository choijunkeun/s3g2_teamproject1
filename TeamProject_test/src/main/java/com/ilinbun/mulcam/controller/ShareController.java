package com.ilinbun.mulcam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/share")
public class ShareController {
	@GetMapping("")
	public String Main() {
		return "share/main";
	}
}
