/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.usermusic.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cdboo.usermusic.entity.CdbooOwnerMusic;
import com.cdboo.usermusic.dao.CdbooOwnerMusicDao;

/**
 * 用户曲库信息Service
 * @author yubin
 * @version 2016-12-21
 */
@Service
@Transactional(readOnly = true)
public class CdbooOwnerMusicService extends CrudService<CdbooOwnerMusicDao, CdbooOwnerMusic> {

	public CdbooOwnerMusic get(String id) {
		return super.get(id);
	}
	
	public List<CdbooOwnerMusic> findList(CdbooOwnerMusic cdbooOwnerMusic) {
		return super.findList(cdbooOwnerMusic);
	}
	
	public Page<CdbooOwnerMusic> findPage(Page<CdbooOwnerMusic> page, CdbooOwnerMusic cdbooOwnerMusic) {
		return super.findPage(page, cdbooOwnerMusic);
	}
	
	@Transactional(readOnly = false)
	public void save(CdbooOwnerMusic cdbooOwnerMusic) {
		super.save(cdbooOwnerMusic);
	}
	
	@Transactional(readOnly = false)
	public void delete(CdbooOwnerMusic cdbooOwnerMusic) {
		super.delete(cdbooOwnerMusic);
	}
	
}