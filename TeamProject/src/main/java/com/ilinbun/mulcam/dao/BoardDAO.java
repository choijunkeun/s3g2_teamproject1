package com.ilinbun.mulcam.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ilinbun.mulcam.dto.Com_board;

@Mapper
@Repository
public interface BoardDAO {
	Integer selectMaxBoardNum() throws Exception;
	void insertBoard(Com_board board) throws Exception;
	int selectBoardCount() throws Exception;
	List<Com_board> selectBoardList(int startrow) throws Exception;
	Com_board selectBoard(int boardNum) throws Exception;
	void updateReadCount(int boardNum) throws Exception;
	void updateBoardReSeq(Com_board board) throws Exception;
	
	String selectPassword(int boardNum) throws Exception;
	void updateBoard(Com_board board) throws Exception;
	void deleteBoard(int boardNum) throws Exception;
}