package com.ilinbun.mulcam.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.Charset;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ilinbun.mulcam.service.PlaceReviewService;

@Controller
@RequestMapping("/search")
public class SearchController {
	@Autowired
	private PlaceReviewService placeReviewService;
	
	@GetMapping({"/", ""})
	public String searchMain() {
		return "search/main";
	}
	@GetMapping({"/test"})
	public String searchtest() {
		return "search/test";
	}
	
	@PostMapping({"", "/"})
	public String searchWithOptionFromMain(@RequestParam(value="keyword", required=false) String keyword,
			@RequestParam(value="level-group", required=false) String honbablv,
			Model model) {
		model.addAttribute("keyword", keyword);
		model.addAttribute("honbablv", honbablv);
		return "search/main";
	}
	
	
	@ResponseBody
	@PostMapping("/query")
	public ResponseEntity<String> queryAndSort(
			@RequestParam int honbabLv,
			@RequestParam String keyword,
			@RequestParam(required=false, defaultValue="37.529521") double x,
			@RequestParam(required=false, defaultValue="126.964540") double y,
			@RequestParam int searchOption) {
		ResponseEntity<String> result = null;
		StringBuffer response = new StringBuffer();
		
		try {
			
			//response = new StringBuffer(getPlacesFromKakaoAPI("치킨"));
	        
	        result = new ResponseEntity<String>(response.toString(), HttpStatus.OK);
	        
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = new ResponseEntity<String>("", HttpStatus.BAD_REQUEST);
		}
		
		return result;
	}
	
	public JSONArray getPlacesFromKakaoAPI(String keyword, double x, double y) {
		HttpURLConnection conn = null;
		JSONArray library = new JSONArray();
		
		for(int i=1; i<=45; i++){
			JSONObject res = new JSONObject(getPlacesRAWResultFromKakao(keyword, i, x, y));
			JSONArray jarr = (JSONArray) res.get("documents");
			for(int j =0; j<jarr.length(); j++) {
				library.put(jarr.get(j));
			}
			if((boolean)((JSONObject)res.get("meta")).get("is_end")) break;
		}
		return library;
		
	}
	
	public String getPlacesRAWResultFromKakao(String keyword, int page, double x, double y) {
		HttpURLConnection conn = null;
		StringBuffer response = new StringBuffer();
		try {
			URL url = new URL("https://dapi.kakao.com/v2/local/search/keyword.json" + "?category\\_group\\_code=FD6&page=" + page + "&query=" + URLEncoder.encode(keyword, "UTF-8"));
			
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
	        System.out.println(response.toString());
	        
	        
		} catch(Exception e) {}
		return response.toString();
	}
}
