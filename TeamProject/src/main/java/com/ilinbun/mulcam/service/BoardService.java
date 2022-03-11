package com.ilinbun.mulcam.service;

import java.util.List;

import com.ilinbun.mulcam.dto.Com_board;
import com.ilinbun.mulcam.dto.PageInfo;

public interface BoardService {
	void regBoard(Com_board board) throws Exception;
	List<Com_board> getBoardList(int page, PageInfo pageInfo) throws Exception;
	Com_board getBoard(int boardNum) throws Exception;
	void regReply(Com_board board) throws Exception;
	void modifyBoard(Com_board board) throws Exception;
	void removeBoard(int boardNum, String boardPass) throws Exception;
	
	// 마이페이지에 사용자의 커뮤니티 게시글 출력(준근) 
		List<Com_board> MyCommunityBoard(int idx) throws Exception;
	
}
