package com.ilinbun.mulcam.service;

import com.ilinbun.mulcam.dto.Shareboard;

public interface ShareService {
	Shareboard shareboard() throws Exception;
	void regShareBoard(Shareboard shareboard) throws Exception;
	Shareboard shareBoardQueryByID(String id) throws Exception;
	Shareboard getArticleNo(int articleNo) throws Exception;
	void modifyShareBoard(Shareboard shareboard) throws Exception;
}
