package com.ilinbun.mulcam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
<<<<<<< HEAD

=======
>>>>>>> branch 'dev' of https://github.com/choijunkeun/s3g2_teamproject1.git

@Controller
<<<<<<< HEAD
// @RequestMapping("/comm")
=======
@RequestMapping("/comm")
>>>>>>> branch 'dev' of https://github.com/choijunkeun/s3g2_teamproject1.git
public class CommunityController {
<<<<<<< HEAD
//	@GetMapping("") // 뒤에 url 주소 적는 곳
//	public String community() {
//		return "/community/main";
//	}
//	
//	@GetMapping("/test")
//	public String Main() {
//		return "/community/test";
//	}


	
}
=======
	@GetMapping("")
	public String Main() {
		return "community/main";
	}
}
>>>>>>> branch 'dev' of https://github.com/choijunkeun/s3g2_teamproject1.git
