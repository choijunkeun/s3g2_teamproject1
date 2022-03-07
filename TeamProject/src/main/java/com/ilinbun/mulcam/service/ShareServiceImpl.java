package com.ilinbun.mulcam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ilinbun.mulcam.dao.ShareDAO;
import com.ilinbun.mulcam.dto.Shareboard;

@Service
public class ShareServiceImpl implements ShareService {

	@Autowired
	ShareDAO shareDAO;
	
	@Override
	public Shareboard shareboard() throws Exception {
		Shareboard share = shareDAO.shareboard();
		return share;
	}
}
