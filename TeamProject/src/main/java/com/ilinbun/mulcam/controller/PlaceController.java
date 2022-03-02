package com.ilinbun.mulcam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/place")
public class PlaceController {
	@PostMapping("/{id}")
	public ModelAndView placeInfo(String place_name, @PathVariable String id) {
		ModelAndView mv = new ModelAndView("place/place");
		mv.addObject("id", id);
		mv.addObject("place_name", place_name);
		
		return mv;
	}
}
