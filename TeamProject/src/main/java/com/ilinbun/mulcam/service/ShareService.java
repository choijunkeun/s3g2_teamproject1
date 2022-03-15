package com.ilinbun.mulcam.service;

import java.util.List;
import java.util.Map;

import com.ilinbun.mulcam.dto.PageInfo;
import com.ilinbun.mulcam.dto.ShareReply;
import com.ilinbun.mulcam.dto.Shareboard;
import com.ilinbun.mulcam.dto.User;

public interface ShareService {
	
	void regShareBoard(Shareboard shareboard) throws Exception;
	Shareboard getArticleNo(int articleNo) throws Exception;
	void modifyShareBoard(Shareboard shareboard) throws Exception;
	void setInputList(Shareboard shareboard) throws Exception;
	List<Shareboard> getShareboardList(int page) throws Exception;
	List<User> getShareboardListUserList(int page) throws Exception;
	List<Map<String, Object>> getShareboardListMap(int page) throws Exception;
	PageInfo getPageInfo(PageInfo pageInfo) throws Exception;
	Shareboard getShareboard(int articleNo) throws Exception;
	
	User selectUserDetail(int idx) throws Exception;
	
	//마이페이지에 뿌려줄 사용자의 반찬공유 게시글(준근)
	List<Shareboard> MyShareBoard(int idx) throws Exception;
	void removeShareBoard(int articleNo) throws Exception;
	

	
	// 좋아요
	int queryArticleLikes(int articleNo) throws Exception;
	int addArticleLikes(int articleNo, int idx) throws Exception;
	int removeArticleLikes(int articleNo, int idx) throws Exception;
	int queryIfILikeThis(int articleNo, int idx) throws Exception;
	
	//  댓글 리스트 관련 페이지
	PageInfo getCommentPageInfo(PageInfo pageInfo) throws Exception;
	
	//댓글쓰기
	void boardReply(int articleNo, int idx, String comment, Integer blind) throws Exception;
	//대댓글쓰기
	void reReply(int commentNo, int articleNo, int idx, String comment, Integer blind) throws Exception;
	
	//댓글보기
	List<ShareReply> boardReplyList(int articleNo, int startrow) throws Exception;

	//댓글삭제
	void deleteReply(int commentNo) throws Exception;

	//댓글 수정
	void editReply(int commentNo, String comment) throws Exception;

	//익명댓글 처리
	void setBlind(int blind, int commentNo) throws Exception;

	Integer countComment() throws Exception;

	void updateCommentSeq(ShareReply shr) throws Exception;
	
	void changeHeader(int articleNo, int headerTag) throws Exception;
}
