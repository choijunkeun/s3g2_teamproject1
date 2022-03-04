package com.ilinbun.mulcam.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ilinbun.mulcam.dao.BragDAO;
import com.ilinbun.mulcam.dto.Bragboard;

@Service
public class BragServiceImpl implements BragService {
	
	
	@Autowired
	BragDAO bragDAO;
	
	@Override
	public Bragboard bragBest1() throws Exception {
		// bragDAO에서 DB를 통해 gragBest1가져오기
		Bragboard best = bragDAO.bragBest1();
		return best;
	}

	@Override
	public Bragboard bragBoardQueryByID(String id) throws Exception {
		//articleNo 가져와서 그 글을 보여주는 쿼리
		Bragboard reviewform = bragDAO.bragBoardQueryByID(id);
		return reviewform;
	}

	@Override
	public void regBragBoard(Bragboard bragboard) throws Exception {
		//처음 글쓰기 등록하는 서비스 (완성!)
				Integer articleNo = bragDAO.selectMaxArticleNo ();
				if(articleNo==null) articleNo = 1;
				else articleNo+=1;
				bragboard.setArticleNo(articleNo);
				//bragboard.setDate(Date); 지울까 말까
			
				bragDAO.insertBragBoard(bragboard);
			}
	
	@Override
	public List<Bragboard> getBragboardList(int articleNo) throws Exception {
		int listCount=bragDAO.selectBragBoardCount();
		//table에 있는 모든 row 개수
		
		int maxPage=(int)Math.ceil((double)listCount/10);
		//그 개수를 10으로 나누고 올림처리하여 페이지 수 계산
		
		double page = 0; //? 새로 추가 
		//아래 2개의 알고리즘은 현재 하나의 페이지에 글 목록을 10개 보여주고
		//아래에 페이지 이동 버튼도 10개로 구성하고자 하기 위함이다.
		int startPage=(((int) ((double)page/10+0.9))-1)*10+1;
		//현재 페이지에 보여줄 시작 페이지 수(1, 11, 21, ...)
		
		int endPage=startPage+10-1;
		//현재 페이지에 보여줄 마지막 페이지 수(10, 20, 30, ...)
		
		
		int startrow=(int) ((page-1)*10+1);
		
		return bragDAO.selectBragBoardList(startrow);
	} 

	@Override
	public Bragboard getArticleNo(int articleNo) throws Exception {
		bragDAO.updateReadCount(articleNo);
		//사용자가 게시판 목록에서 글 상세보기를 눌렀기 때문에 조회수를 1 늘려주는 쿼리문을 수행한 후에
		//해당 글의 DB정보를 select 해온다.
		return bragDAO.selectBragBoard(articleNo);
	}

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

	@Override
	public void modifyBragBoard(Bragboard bragboard) throws Exception {
	
	}
// 글삭제 나중에
//	@Override
//	public void removeBragBoard(int articleNo) throws Exception {
//		//1. 사용자가 입력한 비밀번호 유효성 검사
//		String password=bragDAO.selectPassword(articleNo);
//		Bragboard bragboard=bragDAO.selectBragBoard(articleNo);
//		
//		//2. 유효성 검사 통과 시 내용 삭제(delete 쿼리)
//		if(password.equals(boardPass)) {
//			String rmMessage="삭제된 글입니다.";
//			board.setBoard_view(0);
//			board.setBoard_subject(rmMessage);
//			boardDAO.updateDeletedBoard(board);
//		}
//		
//		//3. 유효성 검사 실패 시 예외 발생(권한없음)
//		else {
//			throw new Exception("삭제 권한 없음");
//		}
//	}


	
	
	
	
}
