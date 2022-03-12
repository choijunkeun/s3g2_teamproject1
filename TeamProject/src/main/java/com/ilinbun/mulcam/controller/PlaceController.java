package com.ilinbun.mulcam.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
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
import com.ilinbun.mulcam.dto.User;
import com.ilinbun.mulcam.service.PlaceReviewService;

@RestController
@RequestMapping("/place")
public class PlaceController {
	@Autowired
	private PlaceReviewService placeReviewService;
	
	@Autowired
	private ServletContext servletContext;
	
	@GetMapping("/{id}")
	public ModelAndView placeInfo(@PathVariable String id,
			@RequestParam("place_name") String place_name,
			@RequestParam(required=false, defaultValue="1") int page,
			HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		
		HttpSession session = request.getSession();
		Integer idx = null;
		if(session.getAttribute("user") != null ) idx = ((User)session.getAttribute("user")).getIdx();
		
		HttpURLConnection conn = null;
		StringBuffer response = new StringBuffer();
		try {
			URL url = new URL("https://dapi.kakao.com/v2/local/search/keyword.json" + "?" + "query=" + URLEncoder.encode(place_name, "UTF-8"));
			
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("X-Requested-With", "curl");
	        conn.setRequestProperty("Authorization", "KakaoAK ec3f88c0be25b53b799db6b9849751aa");
	        conn.setDoOutput(true);
	        
	        int responseCode = conn.getResponseCode();
	        if (responseCode == 400) {
	            System.out.println("400:: 해당 장소를 가져올 수 없음");
	        } else if (responseCode == 401) {
	            System.out.println("401:: 인증 오류");
	        } else if (responseCode == 500) {
	            System.out.println("500:: 카카오 서버 에러");
	        } else { // 성공 후 응답 JSON 데이터받기
				Charset charset = Charset.forName("UTF-8");
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), charset));
				String inputLine;
				while ((inputLine = br.readLine()) != null) {
					response.append(inputLine); 
				} 
				br.close();
	        }
	        
	        JSONObject object = new JSONObject(response.toString());
	        JSONArray obj = (JSONArray) object.get("documents");
	        JSONObject target = (JSONObject)obj.get(0);
	        
	        if(target.get("id").equals(id)) {
	        	Place place = new Place(
		        		Integer.parseInt((String)target.get("id")),
		        		(String)target.get("place_name"),
		        		(String)target.get("category_name"),
		        		(String)target.get("category_group_code"),
		        		(String)target.get("category_group_name"),
		        		(String)target.get("phone"),
		        		(String)target.get("address_name"),
		        		(String)target.get("road_address_name"),
		        		Double.parseDouble((String)target.get("x")),
		        		Double.parseDouble((String)target.get("y")),
		        		(String)target.get("place_url")
	        		);
		        mv.addObject("id", id);
		        mv.addObject("place", place);
		        
		        
		        PageInfo pageInfo = new PageInfo();
		        List<PlaceReviewExtended> reviewList = placeReviewService.getReviewList(page, pageInfo, place.getId());
		        
		        HashMap<Integer, Integer> reviewLikesList = new HashMap<>();
				HashMap<Integer, Integer> didILikedList = new HashMap<>();
				for(int i=0; i<reviewList.size(); i++) {
					reviewLikesList.put(reviewList.get(i).getReviewNo(),
						placeReviewService.queryReviewLikes(reviewList.get(i).getReviewNo()));
					if(idx != null) {
						didILikedList.put(reviewList.get(i).getReviewNo(), 
								placeReviewService.queryIfILikeThis(reviewList.get(i).getReviewNo(), idx));
					}
				}
				
				for(Integer key : didILikedList.keySet()) {
					System.out.println(key + ":" + didILikedList.get(key));
				}
				
				if(idx != null) { 
					mv.addObject("didILikedList", didILikedList);
				}
		        
				mv.addObject("pageInfo", pageInfo);
				mv.addObject("reviewAmount", placeReviewService.getReviewAmount(place.getId()));
				mv.addObject("prList", reviewList);
				mv.addObject("place", place);
				mv.addObject("totalRate", String.format("%.1f", placeReviewService.getTotalRating(place.getId())));
				mv.addObject("serviceRate", String.format("%.1f", placeReviewService.getServiceRating(place.getId())));
				mv.addObject("priceRate", String.format("%.1f", placeReviewService.getPriceRating(place.getId())));
				mv.addObject("interiorRate", String.format("%.1f", placeReviewService.getInteriorRating(place.getId())));
				mv.addObject("tasteRate", String.format("%.1f", placeReviewService.getTasteRating(place.getId())));
				mv.addObject("honbabLv", Math.round(placeReviewService.getHonbabLv(place.getId())));
		        
		        mv.setViewName("place/place");
	        } else throw new Exception("장소값 다름");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			mv.setViewName("main/err");
		}
		
		return mv;
	}
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
			,HttpServletRequest request
			) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("id", id);
		
		HttpSession session = request.getSession();
		Integer idx = null;
		if(session.getAttribute("user") != null ) idx = ((User)session.getAttribute("user")).getIdx();
		
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
			System.out.println(idx);
			List<PlaceReviewExtended> reviewList = placeReviewService.getReviewList(page, pageInfo, place.getId());
			HashMap<Integer, Integer> reviewLikesList = new HashMap<>();
			HashMap<Integer, Integer> didILikedList = new HashMap<>();
			for(int i=0; i<reviewList.size(); i++) {
				reviewLikesList.put(reviewList.get(i).getReviewNo(),
					placeReviewService.queryReviewLikes(reviewList.get(i).getReviewNo()));
				if(idx != null) {
					didILikedList.put(reviewList.get(i).getReviewNo(), 
							placeReviewService.queryIfILikeThis(reviewList.get(i).getReviewNo(), idx));
				}
			}
			
			for(Integer key : didILikedList.keySet()) {
				System.out.println(key + ":" + didILikedList.get(key));
			}
			
			if(idx != null) { 
				mv.addObject("didILikedList", didILikedList);
			}
			mv.addObject("reviewLikesList",reviewLikesList);
			mv.addObject("pageInfo", pageInfo);
			mv.addObject("reviewAmount", placeReviewService.getReviewAmount(place.getId()));
			mv.addObject("prList", reviewList);
			mv.addObject("place", place);
			mv.addObject("totalRate", String.format("%.1f", placeReviewService.getTotalRating(place.getId())));
			mv.addObject("serviceRate", String.format("%.1f", placeReviewService.getServiceRating(place.getId())));
			mv.addObject("priceRate", String.format("%.1f", placeReviewService.getPriceRating(place.getId())));
			mv.addObject("interiorRate", String.format("%.1f", placeReviewService.getInteriorRating(place.getId())));
			mv.addObject("tasteRate", String.format("%.1f", placeReviewService.getTasteRating(place.getId())));
			mv.addObject("honbabLv", Math.round(placeReviewService.getHonbabLv(place.getId())));
			
			mv.setViewName("place/place");
		}catch (Exception e) {
			e.printStackTrace();
			mv.addObject("err", e.getMessage());
			mv.setViewName("/main/err");
		}
		
		return mv;
	}
	
	
	@PostMapping("/review/{id}")
	public ModelAndView reviewForm(@PathVariable String id, @ModelAttribute Place place) {
		ModelAndView mv = new ModelAndView("/place/reviewForm");
		mv.addObject("id", id);
		mv.addObject("place", place);
		
		return mv;
	}
	
	@PostMapping("/edit/{id}")
	public ModelAndView reviewEdit(@PathVariable String id, 
			@RequestParam int reviewNo, @ModelAttribute Place place) throws Exception {
		ModelAndView mv = new ModelAndView("/place/editReview");
		//PlaceReview review = placeReviewService.getReview(Integer.parseInt(reviewNo), Integer.parseInt(id));
		PlaceReview review = placeReviewService.getReview(reviewNo);
		mv.addObject("id", id);
		mv.addObject("place", place);
		mv.addObject("review", review);
		
		return mv;
	}
	

	@ResponseBody
	@PostMapping("/writeReview")
	public ResponseEntity<String> writeReview(@RequestPart("key") Map<String, String> param,
			@RequestPart(value="file", required=false) MultipartFile file) {
		ResponseEntity<String> result = null;
		
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
				pr.setRevImgFilepath(nowTime + "_" + file.getOriginalFilename());
				System.out.println(destFile.getAbsolutePath());
				file.transferTo(destFile);
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
	
	@ResponseBody
	@GetMapping("/getRating")
	public ResponseEntity<String> getRating(@RequestParam int id, @RequestParam int searchOption) {
		ResponseEntity<String> result = null;
		double v = 0.0;
		try {
			switch(searchOption) {
			case 1:
				v = placeReviewService.getTotalRating(id);
				break;
			case 2:
				v = placeReviewService.getPriceRating(id);
				break;
			case 3:
				v = placeReviewService.getTasteRating(id);
				break;
			case 4: 
				v = placeReviewService.getServiceRating(id);
				break;
			case 5:
				v = placeReviewService.getInteriorRating(id);
				break;
			}
			
			result = new ResponseEntity<String>(String.format("%.2f", v), HttpStatus.OK);
			//boardService.regBoard(board);
			//mv.setViewName("redirect:/board/boardlist");
		} catch(Exception e) {
			//e.printStackTrace();
			result = new ResponseEntity<String>("0.0", HttpStatus.OK);
			//mv.addObject("err", "새 글 등록 실패");
			//mv.addObject("/board/err");
		}
		
		return result;	
	}
	
	
	@ResponseBody
	@PostMapping("/editReview")
	public ResponseEntity<String> editReview(@RequestPart("key") Map<String, String> param,
			@RequestPart(value="file", required=false) MultipartFile file) {
		ResponseEntity<String> result = null;
		
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
			System.out.println(param.get("honbabLv"));
			
			pr.setReviewNo(Integer.parseInt(param.get("reviewNo")));
			boolean fileChange=Boolean.parseBoolean(param.get("fileChange"));
			if(fileChange && file != null) { // 파일 첨부시 파일 업로드
				System.out.println("파일 업로드 시도");
				String path=servletContext.getRealPath("/revimgupload/");
				System.out.println(path);
				
				// 이미지 파일의 이름을 바꿔봅시다
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); 
				Date now = new Date(); 
				String nowTime = sdf.format(now);
				
				File destFile = new File(path + nowTime + "_" + file.getOriginalFilename());
				pr.setRevImgFilepath(nowTime + "_" + file.getOriginalFilename());
				file.transferTo(destFile);
				placeReviewService.updateReviewFilePath(pr);
			} else if(fileChange && file == null) {
				pr.setRevImgFilepath(null);
				placeReviewService.updateReviewFilePath(pr);
			}
			
			System.out.println(placeReviewService.updateReview(pr));
			result = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			result = new ResponseEntity<String>("failed", HttpStatus.BAD_REQUEST);
		}
		
		return result;	
	}
	
	@ResponseBody
	@PostMapping("/deleteReview")
	public ResponseEntity<String> editReview(@RequestParam int reviewNo, @RequestParam String idx) {
		ResponseEntity<String> result = null;
		
		try {
			PlaceReview target = placeReviewService.getReview(reviewNo);
			if(target == null) throw new Exception("삭제 대상을 찾을 수 없습니다");
//			int place = target.getId();
			placeReviewService.deleteReview(reviewNo);
			String html = "<script>alert('삭제 완료'); window.location = \"/search\"</script>";
//			System.out.println(html);
			result = new ResponseEntity<String>(html , HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			result = new ResponseEntity<String>("failed", HttpStatus.BAD_REQUEST);
		}
		
		return result;	
	}
	
//	@ResponseBody
//	@GetMapping("/likes/{reviewNo}/query")
//	public ResponseEntity<Integer> queryLikes(@PathVariable int reviewNo, @RequestParam int id) {
//		ResponseEntity<Integer> result = null;
//		
//		try {
//			Integer val = placeReviewService.queryReviewLikes(reviewNo);
//			int didILiked = placeReviewService.queryIfILikeThis(reviewNo, id);
//			result = new ResponseEntity<Integer>(val , HttpStatus.OK);
//		} catch(Exception e) {
//			e.printStackTrace();
//			result = new ResponseEntity<Integer>(0, HttpStatus.BAD_REQUEST);
//		}
//		
//		return result;	
//	}
	
	@ResponseBody
	@PostMapping("/likes")
	public ResponseEntity<String> toggleLikes(@RequestParam("reviewNo") String reviewNo, 
			@RequestParam("idx") String idx) {
		ResponseEntity<String> result = null;
		
		int rNo = Integer.parseInt(reviewNo);
		int useridx = Integer.parseInt(idx);
		
		int processed = 0;
		try {
			if(placeReviewService.queryIfILikeThis(rNo, useridx)>0) {
				placeReviewService.removeReviewLikes(rNo, useridx);
				processed = -1;
			} else {
				placeReviewService.addReviewLikes(rNo, useridx);
				processed = 1;
			}
			Integer val = placeReviewService.queryReviewLikes(rNo);
			JSONObject robj = new JSONObject();
			robj.put("currentLikes", val);
			robj.put("processed", processed);
			
			result = new ResponseEntity<String>(robj.toString() , HttpStatus.OK);
//			result = new ResponseEntity<String>("" , HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			result = new ResponseEntity<String>("", HttpStatus.BAD_REQUEST);
		}
		
		return result;	
	}
	
	
	@GetMapping("/img/{filename}")
	public void fileview(@PathVariable String filename, HttpServletRequest request, HttpServletResponse response) {
		String path = servletContext.getRealPath("/revimgupload/");
		File file = new File(path + filename);
		String sfilename = null;
		FileInputStream fis = null;

		try {
			if (request.getHeader("User-Agent").indexOf("MSIE") > -1) {
				sfilename = URLEncoder.encode(file.getName(), "utf-8");
			} else {
				sfilename = new String(file.getName().getBytes("utf-8"), "ISO-8859-1");
			}
			response.setCharacterEncoding("utf-8");
			response.setContentType("application/octet-stream;charset=utf-8");
			// response.setHeader("Content-Disposition", "attachment;
			// filename=\""+sfilename+"\";");
			response.setHeader("Content-Disposition", "attachment; filename=" + sfilename);
			OutputStream out = response.getOutputStream();
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (Exception e) {
				}
			}
		}
	}
}

