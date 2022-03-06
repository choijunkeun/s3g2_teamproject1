package com.ilinbun.mulcam.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ilinbun.mulcam.dao.BoardDAO;
import com.ilinbun.mulcam.dto.Com_board;
import com.ilinbun.mulcam.dto.PageInfo;



@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardDAO boardDAO;
	
	@Override
	public void regBoard(Com_board board) throws Exception {
		Integer boardNum = boardDAO.selectMaxBoardNum(); //보드 넘중 가장 큰값
		if(boardNum ==null) boardNum = 1;   // 데이터 첫글은 null 이고 1이져
		else boardNum +=1; //보드 넘버는 1씩 더함. 게시판 번호
		board.setBoard_num(boardNum);
		board.setBoard_re_ref(boardNum);  //자기번호
		board.setBoard_re_lev(0);  //맨 앞글은 들여쓰기 하지않는다
		board.setBoard_re_seq(0);
		board.setBoard_readcount(0);
		boardDAO.insertBoard(board);  //각 보드의 칼럼을 인서트
	}

	@Override
		public List<Com_board> getBoardList(int page, PageInfo pageInfo) throws Exception {
	      int listCount = boardDAO.selectBoardCount();
	      //총 페이지 수 올림처리
	      int maxPage = (int)Math.ceil((double)listCount/10);
	      //현재 페이지에 보여줄 시작 페이지 수 (1,11,21...)
	      int startPage=(((int)((double)page/10+0.9))-1)*10+1;  //ex)35페이지 보려면 31,32,33,34,  10으로 나눠서 보기위한 식??
	      //현재 페이지에 보여줄 마지막 페이지 수(10,20,30...)
	      int endPage=startPage+10-1;
	      
	      if(endPage>maxPage) endPage=maxPage;	      
	      pageInfo.setStartPage(startPage);
	      pageInfo.setEndPage(endPage);
	      pageInfo.setMaxPage(maxPage);
	      pageInfo.setPage(page);
	      pageInfo.setListCount(listCount);
	      int startrow = (page-1)*10+1;
	      return boardDAO.selectBoardList(startrow);
	   }

	@Override
	public Com_board getBoard(int boardNum) throws Exception {
		boardDAO.updateReadCount(boardNum);
		return boardDAO.selectBoard(boardNum);
	}

	@Override
	public void regReply(Com_board board) throws Exception {
		// 1. board_num 으로 원글 조회
		Com_board src_board = boardDAO.selectBoard(board.getBoard_num());
		// 2. 글번호를 새로 생성해서 할당
		Integer boardNum = boardDAO.selectMaxBoardNum();
		board.setBoard_num(boardNum+1);
		// 3. 원글의 ref 번호로 답글. ref번호 할당
		board.setBoard_re_ref(src_board.getBoard_re_ref());
		// 4. 원글의 lev에 1을 더하여 lev 할당
		board.setBoard_re_lev(src_board.getBoard_re_lev()+1);
		// 5. 원글의 seq보다 큰 seq인 글들은 +1
		boardDAO.updateBoardReSeq(src_board);
		// 6. 원글의 seq에 1을 더하여 seq 할당
		board.setBoard_re_seq(src_board.getBoard_re_seq()+1);
		boardDAO.insertBoard(board);
	}

	@Override
	public void modifyBoard(Com_board board) throws Exception {
		// 1. 입력된 비밀번호가 원본의 비밀번호와 같은지 체크
		String password = boardDAO.selectPassword(board.getBoard_num());
		// 2. 비밀번호가 같으면, 글 내용 수정
		if(password.equals(board.getBoard_pass())) {
			boardDAO.updateBoard(board);
		} else { // 3. 비밀번호가 다르면 권한 없음 예외
			throw new Exception("수정 권한 없음");
		}
	}

	@Override
	public void removeBoard(int boardNum, String boardPass) throws Exception {
		// 1. 입력된 비밀번호가 원본의 비밀번호와 같은지 체크
		String password = boardDAO.selectPassword(boardNum);
		// 2. 비밀번호가 같으면, 글 내용 삭제
		if(boardPass.equals(password)) {
			boardDAO.deleteBoard(boardNum);
		} else {// 3. 비밀번호가 다르면 권한 없음 예외
			throw new Exception("수정 권한 없음");
		}
	}
}
