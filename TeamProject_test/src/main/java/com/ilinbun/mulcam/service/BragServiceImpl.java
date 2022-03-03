package com.ilinbun.mulcam.service;

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

}
