package com.ilinbun.mulcam.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ilinbun.mulcam.dto.PageInfo;
import com.ilinbun.mulcam.dto.Place;
import com.ilinbun.mulcam.dto.PlaceReview;
import com.ilinbun.mulcam.dto.PlaceReviewExtended;
import com.ilinbun.mulcam.service.PlaceReviewService;

@RestController
@RequestMapping("/place")
public class PlaceController {
	@Autowired
	private PlaceReviewService placeReviewService;
	
	@Autowired
	private ServletContext servletContext;
	
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
			@RequestParam("place_url") String place_url,
			@RequestParam(value="page", required=false, defaultValue="1") int page
			) {
		ModelAndView mv = new ModelAndView();
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
		
		PageInfo pageInfo = new PageInfo();
		try {
			List<PlaceReviewExtended> reviewList = placeReviewService.getReviewList(page, pageInfo, place.getId());
			mv.addObject("pageInfo", pageInfo);
			mv.addObject("reviewAmount", placeReviewService.getReviewAmount(place.getId()));
			mv.addObject("prList", reviewList);
			mv.addObject("place", place);
			mv.setViewName("place/place");
		}catch (Exception e) {
			e.printStackTrace();
			mv.addObject("err", e.getMessage());
			mv.setViewName("/main/err");
		}
		
		
		return mv;
	}
	
//	@PostMapping("/review/{id}")
//	public ModelAndView reviewForm(@PathVariable String id, @RequestParam("place_name") String place_name) {
//		ModelAndView mv = new ModelAndView("place/reviewForm");
//		mv.addObject("id", id);
//		mv.addObject("place_name", place_name);
//		
//		return mv;
//	}
	
	@PostMapping("/review/{id}")
	public ModelAndView reviewForm(@PathVariable String id, @ModelAttribute Place place) {
		ModelAndView mv = new ModelAndView("place/reviewForm");
		mv.addObject("id", id);
		mv.addObject("pr", place);
		
		System.out.println(place.getId());
		
		return mv;
	}
	
//	@ResponseBody
//	@PostMapping("/writeReview")
//	public ResponseEntity<String> writeReview(@ModelAttribute PlaceReview pr) {
//		System.out.println(pr);
//		ResponseEntity<String> result = null;
//		
//		System.out.println("THREE");
//		System.out.println(pr.getId());
//		System.out.println(pr.getHonbabLv());
//		System.out.println(pr.getReviewContent());
//		System.out.println(pr.getRejectedCount());
//		System.out.println(pr.getTasteRate());
//		System.out.println(pr.getUser_PK());
//				
//		try {
//			if(pr.getFile() != null) { // 파일 첨부시 파일 업로드
//				System.out.println("파일 업로드 시도");
//				String path=servletContext.getRealPath("/revimgupload/");
//				System.out.println(path);
//				
//				// 이미지 파일의 이름을 바꿔봅시다
//				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); 
//				Date now = new Date(); 
//				String nowTime = sdf.format(now);
//				
//				File destFile = new File(path + nowTime + "_" + pr.getFile().getOriginalFilename());
//				System.out.println("1");
//				pr.setRevImgFilepath(nowTime + "_" + pr.getFile().getOriginalFilename());
//				System.out.println(destFile.getAbsolutePath());
//				pr.getFile().transferTo(destFile);
//				System.out.println("SUCCESS");
//				System.out.println(pr.getRevImgFilepath());
//			}
//			placeReviewService.writeBoard(pr);
//			result = new ResponseEntity<String>("success", HttpStatus.OK);
//			//boardService.regBoard(board);
//			//mv.setViewName("redirect:/board/boardlist");
//		} catch(Exception e) {
//			e.printStackTrace();
//			result = new ResponseEntity<String>("failed", HttpStatus.BAD_REQUEST);
//			//mv.addObject("err", "새 글 등록 실패");
//			//mv.addObject("/board/err");
//		}
//			
//		return result;
//	}
	
	@ResponseBody
	@PostMapping("/writeReview")
	public ResponseEntity<String> writeReview(@RequestPart("key") Map<String, String> param,
			@RequestPart(value="file", required=false) MultipartFile file) {
		ResponseEntity<String> result = null;
		
		System.out.println(file.getOriginalFilename());
		System.out.println(param.get("reviewContent"));	

		
		try {
			PlaceReview pr = new PlaceReview( 
	                Integer.parseInt(param.get("id")), 
					Integer.parseInt(param.get("user_PK")), 
					param.get("reviewContent"), 
					Boolean.parseBoolean(param.get("rejectedCount")), 
					Integer.parseInt(param.get("honbabLv")), 
					param.get("honbabReason"), 
					Double.parseDouble(param.get("interiorRate")), 
					Double.parseDouble(param.get("serviceRate")),
					Double.parseDouble(param.get("priceRate")), 
					Double.parseDouble(param.get("tasteRate"))
				);
			if(file != null) { // 파일 첨부시 파일 업로드
				System.out.println("파일 업로드 시도");
				String path=servletContext.getRealPath("/revimgupload/");
				System.out.println(path);
				
				// 이미지 파일의 이름을 바꿔봅시다
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); 
				Date now = new Date(); 
				String nowTime = sdf.format(now);
				
				File destFile = new File(path + nowTime + "_" + file.getOriginalFilename());
				System.out.println("1");
				pr.setRevImgFilepath(nowTime + "_" + file.getOriginalFilename());
				System.out.println(destFile.getAbsolutePath());
				file.transferTo(destFile);
				System.out.println("SUCCESS");
				System.out.println(pr.getRevImgFilepath());
			}
			
			placeReviewService.writeBoard(pr);
			result = new ResponseEntity<String>("success", HttpStatus.OK);
			//boardService.regBoard(board);
			//mv.setViewName("redirect:/board/boardlist");
		} catch(Exception e) {
			e.printStackTrace();
			result = new ResponseEntity<String>("failed", HttpStatus.BAD_REQUEST);
			//mv.addObject("err", "새 글 등록 실패");
			//mv.addObject("/board/err");
		}
		
		return result;	
	}
}
