package com.ilinbun.mulcam.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ilinbun.mulcam.dao.BragDAO;
import com.ilinbun.mulcam.dao.UserDAO;
import com.ilinbun.mulcam.dto.BragBoard;
import com.ilinbun.mulcam.dto.BragReply;
import com.ilinbun.mulcam.dto.PageInfo;
import com.ilinbun.mulcam.dto.User;

@Service
public class BragServiceImpl implements BragService {
	
	
	@Autowired
	BragDAO bragDAO;
	
	@Autowired
	UserDAO userDAO;

	//[글쓰기Service]
	//글쓰기 시 글 쓸때, 마지막 articleNo+1해주는 DAO
	@Override
	public int regBragBoard(BragBoard bragboard) throws Exception {
		Integer articleNo = bragDAO.selectMaxArticleNo();
		if(articleNo==null) articleNo = 1;
		else articleNo+=1;
		bragboard.setArticleNo(articleNo);
		//bragboard.setDate(Date); 지울까 말까
	
		bragDAO.insertBragBoard(bragboard);	
		return articleNo;
	}

		
	//[글 보기Service]
	//글보기(viewDetail)에서 id를 받아와 내 글인지 남의 글인지 판별
	@Override
	public BragBoard bragBoardQueryByID(String id) throws Exception {
		BragBoard viewDetail = bragDAO.bragBoardQueryByID(id);
		return viewDetail;
	}
	//글보기 시 조회수 올리는 기능
	@Override
	public BragBoard getBragBoard(int articleNo) throws Exception {
		bragDAO.updateReadCount(articleNo);
		return bragDAO.selectBragBoard(articleNo);
	}
	
	//글보기, 글목록시 유저의 정보 가져오는거 
	@Override
	public User selectUserDetail(int idx) throws  Exception {
		return userDAO.selectUserDetail(idx);
	}


	//[글 목록Service]
	//게시글 리스트에 작성된 게시글을 넣는 쿼리
	@Override
	public void setInputList(BragBoard bragboard) throws Exception {
		// bragboard에 작성된 제목과 내용을 가지고 dB에 넣기 
		bragDAO.insertBragBoard(bragboard);	
	}
	//게시글 목록 : 16개가 화면에 띄워지게 하는 DAO
	@Override
	public List<BragBoard> getBragboardList(int page, int howManyBrag) throws Exception {
		int startrow=(int) ((page-1)*howManyBrag)+1;
		Map<String, Integer> map = new HashMap<>();
		
		map.put("startrow", startrow);
		map.put("howManyBrag", howManyBrag);
		List<BragBoard> list = bragDAO.selectBragBoardList(map);
		System.out.println("24개가 맞는지?" + list.size());
		for(int i=0;i<list.size();i++) {
			String realContent = list.get(i).getContent(); // "<p>게시글 내용이 들어있고, <img src=주소 /></p>"
			Document doc=Jsoup.parse(realContent);
//			Elements img= doc.select("img");
			Element img= doc.selectFirst("img");
			String src = "";
			if(img !=null) src =img.attr("src");
			else src = "https://dummyimage.com/200x200/777/ffffff.jpg&text=NoImg";
			
			list.get(i).setContent(src);
		}
		return list;
	}
	//게시글 목록 아래의 이전/목록/다음 리스트가 10개가 되도록 구성하는 쿼리(PageInfo DTO와 연결, DAO필요X)
	@Override
	public PageInfo getPageInfo(PageInfo pageInfo) throws Exception {
		int listCount=bragDAO.selectBragBoardCount();
		System.out.println("리스트카운트 :"+listCount);
		int maxPage=(int)Math.ceil((double)listCount/24);
		//그 개수를 16으로 나누고 올림처리하여 페이지 수 계산
		//table에 있는 모든 row 개수
		double pagenation = pageInfo.getPage(); //? 새로 추가 
		//아래에 페이지 이동 버튼도 10개로 구성하고자 하기 위함이다.
		int startPage=(((int) ((double)pagenation/10+0.9))-1)*10+1;
		//현재 페이지에 보여줄 시작 페이지 수(1, 11, 21, ...)
		
		int endPage=startPage+10-1;
		//현재 페이지에 보여줄 마지막 페이지 수(10, 20, 30, ...)
		if(maxPage<endPage) {
			endPage=maxPage;
		}
		pageInfo.setListCount(listCount);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setEndPage(endPage);
		pageInfo.setStartPage(startPage);
		return pageInfo;
	}
	//댓글에 대한 페이지 보기
	@Override
	public PageInfo getCommentPageInfo(PageInfo pageInfo, int articleNo) throws Exception {
		int listCount=bragDAO.countComment(articleNo);
		System.out.println("리스트카운트 :"+listCount);
		int maxPage=(int)Math.ceil((double)listCount/16);
		//그 개수를 16으로 나누고 올림처리하여 페이지 수 계산
		//table에 있는 모든 row 개수
		double pagenation = pageInfo.getPage(); //? 새로 추가
		//아래에 페이지 이동 버튼도 10개로 구성하고자 하기 위함이다.
		int startPage=(((int) ((double)pagenation/10+0.9))-1)*10+1;
		//현재 페이지에 보여줄 시작 페이지 수(1, 11, 21, ...)
		
		int endPage=startPage+10-1;
		//현재 페이지에 보여줄 마지막 페이지 수(10, 20, 30, ...)
		if(maxPage<endPage) {
			endPage=maxPage;
		}
		pageInfo.setListCount(listCount);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setEndPage(endPage);
		pageInfo.setStartPage(startPage);
		return pageInfo;
	}
	//BEST 게시판 글 목록이 조회수 순으로 정렬 쿼리(수정요. 나중에는 좋아요 순으로)
	@Override
	public List<BragBoard> bragBest() throws Exception {
		List<BragBoard> best = bragDAO.bragBest();
		for(int i=0;i<best.size();i++) {
			String realContent = best.get(i).getContent(); // "<p>게시글 내용이 들어있고, <img src=주소 /></p>"
			Document doc=Jsoup.parse(realContent);
			Element img= doc.selectFirst("img");
			String src = "";
			if(img !=null) src =img.attr("src");
			else src = "https://dummyimage.com/200x200/777/ffffff.jpg&text=NoImg";
			
			best.get(i).setContent(src);
		}
		return best;
	}
	
	//여기서 부터는 구현 전 
	//글수정
	@Override
	public void modifyBragBoard(BragBoard bragboard) throws Exception {
		bragDAO.updateBragBoard(bragboard);
	}
	//글수정(modifyForm) 시 하나의 글 정보를 select하는 쿼리문	
	@Override
	public BragBoard getArticleNo(int articleNo) throws Exception {
		return bragDAO.selectBragBoard(articleNo);
	}
	//글삭제
	@Override
	public int deleteWrite(int articleNo) throws Exception {
		return bragDAO.deleteWrite(articleNo);
	}
	

	// 마이페이지에 뿌려줄 사용자의 혼밥자랑 게시글(준근) 
	@Override
	public List<BragBoard> MyBragBoard(int idx) throws Exception {
		return bragDAO.selectBragBoardByIdx(idx);
	}

//아마 댓글	
//	@Override
//	public void regBragReply(Bragboard bragboard) throws Exception {
//		//1. borad_num으로 원글 조회(ref,lev,seq 참조하기 위함)
//		//즉, 해당 비즈니스로직은 기존에 등록된 글에 대한 답변을 다는 기능이다.
//		Bragboard src_board=bragDAO.selectBragBoard(bragboard.getArticleNo());
//		
//		//2. 글번호를 새로 생성하여 답변글에 할당
//		//파라미터로 넘어온 board객체의 번호는 원글의 번호가 초기화되어있으므로
//		//1의 작업 후 board객체의 번호를 새로 할당한다.
//		Integer articleNo=bragDAO.selectMaxArticleNo();
//		bragboard.setArticleNo(articleNo+1);
//		
//		//3. 원글의 ref번호를 바탕으로 현재 답글의 ref번호 할당 ==> 우선 
//		bragboard.setBoard_re_ref(src_board.getBoard_re_ref());
//		
//		//4. 원글의 lev번호에 +1을하여 현재 답글의 lev번호 할당
//		bragboard.setBoard_re_lev(src_board.getBoard_re_lev()+1);
//		
//		//5. 원글의 seq번호보다 큰 seq글(같은 ref번호내에서)들의 seq번호를 +1
//		bragDAO.updateBoardReSeq(src_board);
//		
//		//6. 원글의 seq번호에 +1을 하여 현재 답글의 seq번호 할당
//		bragboard.setBoard_re_seq(src_board.getBoard_re_seq()+1);
//		
//		bragboard.setReadCount(1);
//		
//		//최종적으로 답변글에 대한 정보를 DB에 insert
//		bragDAO.insertBragBoard(bragboard);
//	}

	
	

	// 좋아요
	@Override
	public int queryArticleLikes(int articleNo) throws Exception {
		// TODO Auto-generated method stub
		return bragDAO.queryArticleLikes(articleNo);
	}
	@Override
	public int addArticleLikes(int articleNo, int idx) throws Exception {
		Map<String, Integer> map = new HashMap<>();
		
		map.put("articleNo", articleNo);
		map.put("idx", idx);
		return bragDAO.addArticleLikes(map);
	}
	
	@Override
	public int removeArticleLikes(int articleNo, int idx) throws Exception {
		Map<String, Integer> map = new HashMap<>();
		
		map.put("articleNo", articleNo);
		map.put("idx", idx);
		return bragDAO.removeArticleLikes(map);
	}
	@Override
	public int queryIfILikeThis(int articleNo, int idx) throws Exception {
		Map<String, Integer> map = new HashMap<>();
		
		map.put("articleNo", articleNo);
		map.put("idx", idx);
		return bragDAO.queryIfILikeThis(map);
	}

	
	//댓글 쓰기
	@Override
	public void boardReply(int articleNo, int idx, String comment, Integer blind) throws Exception {
		Integer commentNo = bragDAO.selectMaxCommentNo();
		if(commentNo == null) commentNo = 1;
		
		Map<String, Object> map = new HashMap<>();
		map.put("articleNo", articleNo);
		map.put("idx", idx);
		map.put("comment", comment);
		map.put("blind", (blind != null? true : false));
		map.put("refer", commentNo);
		map.put("lev", 0);
		map.put("seq", 0);
		bragDAO.insertReply(map);
		
	}
	
	//대댓글 쓰기
	@Override
	public void reReply(int commentNo, int articleNo, int idx, String comment, Integer blind) throws Exception {
		System.out.println("src reply getting");
		BragReply src_reply = (BragReply)bragDAO.selectReply(commentNo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("articleNo", articleNo);
		map.put("idx", idx);
		map.put("comment", comment);
		map.put("blind", (blind != null? true : false));
		map.put("refer", src_reply.getRefer());
		map.put("lev", src_reply.getLev()+1);
		bragDAO.updateCommentSeq(src_reply);
		map.put("seq", src_reply.getSeq()+1);
		bragDAO.insertReply(map);
		
	}

	//댓글 보기
	@Override
	public List<BragReply> boardReplyList(int articleNo, int page) throws Exception {
		int startrow=(int) ((page-1)*10+1);
		Map<String, Integer> map = new HashMap<>();
		map.put("articleNo", articleNo);
		map.put("startrow", startrow);
		return bragDAO.selectReplyList(map);
	}

	//댓글 삭제
	@Override
	public void deleteReply(int commentNo) throws Exception {
		bragDAO.deleteReply(commentNo);
		
	}

	//댓글 수정
	@Override
	public void editReply(int commentNo, String comment) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("commentNo", commentNo);
		map.put("comment", comment);
		
		bragDAO.editReply(map);
	}
	
	//익명댓글 처리
	@Override
	public void setBlind(int blind, int commentNo) throws Exception{
		Map<String, Object> map = new HashMap<>();
		map.put("blind", blind);
		map.put("commentNo", commentNo);
		
		bragDAO.setBlind(map);
	}
	
	@Override
	public Integer countComment(int articleNo) throws Exception{
		return bragDAO.countComment(articleNo);
	}
	
	@Override
	public void updateCommentSeq(BragReply br) throws Exception{
		bragDAO.updateCommentSeq(br);
	}
	
}
