package com.ilinbun.mulcam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ilinbun.mulcam.dto.Place;

@Controller
@RequestMapping("/place")
public class PlaceController {	
	@PostMapping("/{id}")
	public ModelAndView placeInfo(@PathVariable String id, 
			@RequestParam("place_name") String place_name,
			@RequestParam("category_name") String category_name,
			@RequestParam("category_group_code") String category_group_code,
			@RequestParam("category_group_name") String category_group_name,
			@RequestParam("phone") String phone,
			@RequestParam("address_name") String address_name,
			@RequestParam("road_address_name") String road_address_name,
			@RequestParam("x") String x,
			@RequestParam("y") String y,
			@RequestParam("place_url") String place_url
			) {
		ModelAndView mv = new ModelAndView("place/place");
		mv.addObject("id", id);
		
		Place place = new Place(Integer.parseInt(id), 
				place_name,
				category_name,
				category_group_code,
				category_group_name,
				phone,
				address_name,
				road_address_name,
				Double.parseDouble(x),
				Double.parseDouble(y),
				place_url);
		
		mv.addObject("place", place);
		
		return mv;
	}
	
	@PostMapping("/review/{id}")
	public ModelAndView writeReview(@PathVariable String id, @RequestParam("place_name") String place_name) {
		ModelAndView mv = new ModelAndView("place/reviewForm");
		mv.addObject("id", id);
		mv.addObject("place_name", place_name);
		
		return mv;
	}
}
