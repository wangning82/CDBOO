/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.music.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cdboo.music.entity.CdbooMusic;
import com.cdboo.music.dao.CdbooMusicDao;

/**
 * 曲库管理Service
 * @author yubin
 * @version 2016-12-13
 */
@Service
@Transactional(readOnly = true)
public class CdbooMusicService extends CrudService<CdbooMusicDao, CdbooMusic> {

	public CdbooMusic get(String id) {
		return super.get(id);
	}
	
	public List<CdbooMusic> findList(CdbooMusic cdbooMusic) {
		return super.findList(cdbooMusic);
	}
	
	public Page<CdbooMusic> findPage(Page<CdbooMusic> page, CdbooMusic cdbooMusic) {
		return super.findPage(page, cdbooMusic);
	}
	
	@Transactional(readOnly = false)
	public void save(CdbooMusic cdbooMusic) {
		super.save(cdbooMusic);
	}
	
	@Transactional(readOnly = false)
	public void delete(CdbooMusic cdbooMusic) {
		super.delete(cdbooMusic);
	}
	
}