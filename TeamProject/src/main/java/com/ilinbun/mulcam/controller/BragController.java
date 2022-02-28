package com.ilinbun.mulcam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/brag")
public class BragController {
	@GetMapping("")
	public String Main() {
		return "brag/main";
	}
}
