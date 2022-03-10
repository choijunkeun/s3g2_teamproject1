package com.ilinbun.mulcam.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
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
	@GetMapping("/query")
	public ResponseEntity<String> queryAndSort(
			@RequestParam(required=false, defaultValue="5") int honbabLv,
			@RequestParam String keyword,
			@RequestParam(required=false, defaultValue="126.964540") double x,
			@RequestParam(required=false, defaultValue="37.529521") double y,
			@RequestParam int searchOption) {
		ResponseEntity<String> result = null;
		//StringBuffer response = new StringBuffer();
		
		try {
			// 일단 혼밥레벨과 평점이 추가된 jsonobject들의 jsonarray를 가져옵니다
			JSONArray temp = getPlacesFromKakaoAPI(keyword, x,y, searchOption);
			// 그리고 honbabLv가 위에 파라미터로 받은 honbabLv보다 작거나 같은 플레이스들만 모읍니다 
			JSONArray jarr = new JSONArray();
			
			for(int i=0; i<temp.length(); i++) {
				JSONObject target = temp.getJSONObject(i);
				if(target.getString("category_group_code").equals("FD6") && target.getString("category_group_name").equals("음식점") && target.getInt("honbabLv") <= honbabLv)
					jarr.put(target);
			}
			
			// 이제부터 정렬을 시작합니다
			List<JSONObject> jsonForSort = new ArrayList<JSONObject>();
			for(int i=0; i<jarr.length(); i++) {
				jsonForSort.add(jarr.getJSONObject(i));
			}
			
			Collections.sort(jsonForSort, new Comparator<JSONObject>() {
				@Override
				public int compare(JSONObject a, JSONObject b) throws JSONException {
					double va = a.getDouble("rating");
					double vb = b.getDouble("rating");
					return Double.compare(vb, va);// 내림차순 정렬을 할겁니다
				}
			});
			
			JSONArray sortedJarr = new JSONArray();
			for(int i=0; i<jarr.length(); i++) {
				sortedJarr.put(jsonForSort.get(i));
			}
			System.out.println(sortedJarr);
			
			// 이제 전달해주기만 하면 되는데 서버 안정성을 위해 15개만 전달할겁니다
			JSONArray finaljarr = new JSONArray();
			int limit = 15;
			if(sortedJarr.length() < 15) limit = sortedJarr.length();
			for(int i=0; i<limit; i++) {
				finaljarr.put(sortedJarr.getJSONObject(i));
			}
			
			// 정렬이 끝난 sortedJarr를 jsonobject에 담아 전송합니다.
			//System.out.println(response.toString());
			JSONObject resultobj = new JSONObject();
			resultobj.put("documents", finaljarr);
	        result = new ResponseEntity<String>(resultobj.toString(), HttpStatus.OK);
	        
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = new ResponseEntity<String>("", HttpStatus.BAD_REQUEST);
		}
		return result;
	}
	
	public JSONArray getPlacesFromKakaoAPI(String keyword, double x, double y, int searchOption) throws NumberFormatException, JSONException, Exception {
		HttpURLConnection conn = null;
		JSONArray library = new JSONArray();
		
		for(int i=1; i<=45; i++){
			JSONObject res = new JSONObject(getPlacesRAWResultFromKakao(keyword, i, x, y));
			JSONArray jarr = (JSONArray) res.get("documents");
			for(int j =0; j<jarr.length(); j++) {
				JSONObject temp = jarr.getJSONObject(j);
				Double honbabLevel = placeReviewService.getHonbabLv(Integer.parseInt(temp.getString("id")));
				Double rating=0.0;
				switch(searchOption) {
				case 1:
					rating = placeReviewService.getTotalRating(Integer.parseInt(temp.getString("id")));
					break;
				case 2:
					rating = placeReviewService.getPriceRating(Integer.parseInt(temp.getString("id")));
					break;
				case 3:
					rating = placeReviewService.getTasteRating(Integer.parseInt(temp.getString("id")));
					break;
				case 4:
					rating = placeReviewService.getServiceRating(Integer.parseInt(temp.getString("id")));
					break;
				case 5:
					rating = placeReviewService.getInteriorRating(Integer.parseInt(temp.getString("id")));
					break;
				}
				temp.put("rating", rating);
				temp.put("honbabLv", honbabLevel);
				library.put(jarr.getJSONObject(j));
			}
			if((res.getJSONObject("meta")).getBoolean("is_end")) break;
		}
		return library;
		
	}
	
	public String getPlacesRAWResultFromKakao(String keyword, int page, double x, double y) {
		HttpURLConnection conn = null;
		StringBuffer response = new StringBuffer();
		try {
			URL url = new URL("https://dapi.kakao.com/v2/local/search/keyword.json" + "?category\\_group\\_code=FD6&x=" + x + "&y=" + y + "&page=" + page + "&query=" + URLEncoder.encode(keyword, "UTF-8"));
			
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
	        //System.out.println(response.toString());
	        
	        
		} catch(Exception e) {}
		return response.toString();
	}
}
