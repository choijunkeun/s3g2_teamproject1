package com.ilinbun.mulcam.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ilinbun.mulcam.dto.BragReply;
import com.ilinbun.mulcam.dto.ShareReply;
import com.ilinbun.mulcam.dto.Shareboard;

@Mapper
@Repository
public interface ShareDAO {
	
	public Shareboard shareBoardQueryByID(String id) throws Exception;
	
	Integer selectMaxArticleNo() throws Exception;
	List<Shareboard> selectShareBoardList(int startrow) throws Exception;
	
	int selectShareBoardCount() throws Exception;
	Shareboard selectShareboard() throws Exception;
	
	void updateReadCount(int articleNo) throws Exception;
	void updateShareBoardReSeq(Shareboard shareboard) throws Exception;
	
	void insertShareBoard(Shareboard shareboard) throws Exception;
	void updateShareBoard(Shareboard shareboard) throws Exception;
	void deleteShareBoard(int articleNo) throws Exception;
	void updateDeletedShareBoard(Shareboard shareboard) throws Exception;

	
	// 마이페이지에 뿌려줄 사용자의 반찬공유 게시글 출력 DAO(준근)
	public List<Shareboard> selectShareBoardByIdx(int idx) throws Exception;	
	Shareboard selectShareboard(int articleNo) throws Exception;
	public int queryArticleLikes(int articleNo) throws Exception;
	public int addArticleLikes(Map<String, Integer> map) throws Exception;
	public int removeArticleLikes(Map<String, Integer> map) throws Exception;
	public int queryIfILikeThis(Map<String, Integer> map) throws Exception;
	public int countComment() throws Exception;
	public Integer selectMaxCommentNo() throws Exception;
	public void insertReply(Map<String, Object> map) throws Exception;
	public ShareReply selectReply(int commentNo) throws Exception;
	public void updateCommentSeq(ShareReply shr) throws Exception;
	public List<ShareReply> selectReplyList(Map<String, Integer> map) throws Exception;
	public void deleteReply(int commentNo) throws Exception;
	public void editReply(Map<String, Object> map) throws Exception;
	public void setBlind(Map<String, Object> map) throws Exception;

	public void changeHeaderTag(int headerTag) throws Exception;
}
