package com.ilinbun.mulcam.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ilinbun.mulcam.dao.CommunityDAO;
import com.ilinbun.mulcam.dao.UserDAO;
import com.ilinbun.mulcam.dto.CommBoard;
import com.ilinbun.mulcam.dto.PageInfo;
import com.ilinbun.mulcam.dto.User;

@Service
public class CommServiceImpl implements CommService {

	@Autowired
	CommunityDAO CommunityDAO;
	
	@Autowired
	UserDAO userDAO;

	// [글쓰기Service]
	// 글쓰기 시 글 쓸때, 마지막 articleNo+1해주는 DAO
	@Override
	public void regCommBoard(CommBoard commboard) throws Exception {
		Integer articleNo = CommunityDAO.selectMaxArticleNo();
		if (articleNo == null)
			articleNo = 1;
		else
			articleNo += 1;
		commboard.setArticleNo(articleNo);
		// CommBoard.setDate(Date); 지울까 말까

		CommunityDAO.insertCommBoard(commboard);
	}
	
	
	
	@Override
	public User selectUserDetail(int idx) throws Exception {
		return userDAO.selectUserDetail(idx);
	}

	// [글 보기Service]
	// 글보기(viewDetail)에서 id를 받아와 내 글인지 남의 글인지 판별
	@Override
	public CommBoard CommBoardQueryByID(String id) throws Exception {
		CommBoard viewform = CommunityDAO.CommBoardQueryByID(id);
		return viewform;
	}

	// 글 수정 기능
	@Override
	public CommBoard getArticleNo(int articleNo) throws Exception {
		
		return CommunityDAO.selectCommBoard(articleNo);
	}

	// [글 목록Service]
	// 게시글 리스트에 작성된 게시글을 넣는 쿼리
	@Override
	public void setInputList(CommBoard Commboard) throws Exception {
		// CommBoard에 작성된 제목과 내용을 가지고 dB에 넣기
		CommunityDAO.insertCommBoard(Commboard);
	}

	// 게시글 목록 : 15개가 화면에 띄워지게 하는 DAO
	@Override
	public List<CommBoard> getCommBoardList(int page) throws Exception {
		int startrow = (int) ((page - 1) * 15 + 1);
		return CommunityDAO.selectCommBoardList(startrow);
	}

	// 게시글 목록 아래의 이전/목록/다음 리스트가 10개가 되도록 구성하는 쿼리(PageInfo DTO와 연결, DAO필요X)
	@Override
	public PageInfo getPageInfo(PageInfo pageInfo) throws Exception {
		int listCount = CommunityDAO.selectCommBoardCount();
		System.out.println("리스트카운트 :" + listCount);
		int maxPage = (int) Math.ceil((double) listCount / 15);
		// 그 개수를 15으로 나누고 올림처리하여 페이지 수 계산
		// table에 있는 모든 row 개수
		double pagenation = pageInfo.getPage(); // ? 새로 추가
		// 아래에 페이지 이동 버튼도 10개로 구성하고자 하기 위함이다.
		int startPage = (((int) ((double) pagenation / 10 + 0.9)) - 1) * 10 + 1;
		// 현재 페이지에 보여줄 시작 페이지 수(1, 11, 21, ...)

		int endPage = startPage + 10 - 1;
		// 현재 페이지에 보여줄 마지막 페이지 수(10, 20, 30, ...)
		if (maxPage < endPage) {
			endPage = maxPage;
		}
		pageInfo.setListCount(listCount);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setEndPage(endPage);
		pageInfo.setStartPage(startPage);
		return pageInfo;
	}
	
	// 마이페이지에 뿌려줄 사용자의 혼밥자랑 게시글(준근) 
	@Override
	public List<CommBoard> MyCommunityBoard(int idx) throws Exception {
		return CommunityDAO.selectCommunityBoardByIdx(idx);
	}

	// 여기서 부터는 구현 전
	// 글수정
	@Override
	public void modifyCommBoard(CommBoard Commboard) throws Exception {
		CommunityDAO.updateCommBoard(Commboard);

	}

	// 글조회수 올리는 기능
	@Override
	public CommBoard getCommBoard(int articleNo) throws Exception {
		CommunityDAO.updateReadCount(articleNo);
		return CommunityDAO.selectCommBoard(articleNo);
	}

	// 글삭제
	@Override
	public void removeCommBoard(int articleNo) throws Exception {
		CommunityDAO.deleteCommBoard(articleNo);
	}

	// 좋아요
		@Override
		public int queryArticleLikes(int articleNo) throws Exception {
			// TODO Auto-generated method stub
			return CommunityDAO.queryArticleLikes(articleNo);
		}
		@Override
		public int addArticleLikes(int articleNo, int idx) throws Exception {
			Map<String, Integer> map = new HashMap<>();
			
			map.put("articleNo", articleNo);
			map.put("idx", idx);
			return CommunityDAO.addArticleLikes(map);
		}
		
		@Override
		public int removeArticleLikes(int articleNo, int idx) throws Exception {
			Map<String, Integer> map = new HashMap<>();
			
			map.put("articleNo", articleNo);
			map.put("idx", idx);
			return CommunityDAO.removeArticleLikes(map);
		}
		@Override
		public int queryIfILikeThis(int articleNo, int idx) throws Exception {
			Map<String, Integer> map = new HashMap<>();
			
			map.put("articleNo", articleNo);
			map.put("idx", idx);
			return CommunityDAO.queryIfILikeThis(map);
		}
	
	




//아마 댓글   
//   @Override
//   public void regBragReply(CommBoard CommBoard) throws Exception {
//      //1. borad_num으로 원글 조회(ref,lev,seq 참조하기 위함)
//      //즉, 해당 비즈니스로직은 기존에 등록된 글에 대한 답변을 다는 기능이다.
//      CommBoard src_board=bragDAO.selectCommBoard(CommBoard.getArticleNo());
//      
//      //2. 글번호를 새로 생성하여 답변글에 할당
//      //파라미터로 넘어온 board객체의 번호는 원글의 번호가 초기화되어있으므로
//      //1의 작업 후 board객체의 번호를 새로 할당한다.
//      Integer articleNo=bragDAO.selectMaxArticleNo();
//      CommBoard.setArticleNo(articleNo+1);
//      
//      //3. 원글의 ref번호를 바탕으로 현재 답글의 ref번호 할당 ==> 우선 
//      CommBoard.setBoard_re_ref(src_board.getBoard_re_ref());
//      
//      //4. 원글의 lev번호에 +1을하여 현재 답글의 lev번호 할당
//      CommBoard.setBoard_re_lev(src_board.getBoard_re_lev()+1);
//      
//      //5. 원글의 seq번호보다 큰 seq글(같은 ref번호내에서)들의 seq번호를 +1
//      bragDAO.updateBoardReSeq(src_board);
//      
//      //6. 원글의 seq번호에 +1을 하여 현재 답글의 seq번호 할당
//      CommBoard.setBoard_re_seq(src_board.getBoard_re_seq()+1);
//      
//      CommBoard.setReadCount(1);
//      
//      //최종적으로 답변글에 대한 정보를 DB에 insert
//      bragDAO.insertCommBoard(CommBoard);
//   }

}