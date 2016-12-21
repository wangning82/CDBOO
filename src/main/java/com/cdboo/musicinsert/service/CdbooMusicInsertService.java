/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.musicinsert.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cdboo.musicinsert.entity.CdbooMusicInsert;
import com.cdboo.musicinsert.dao.CdbooMusicInsertDao;

/**
 * 插播计划表Service
 * @author yubin
 * @version 2016-12-21
 */
@Service
@Transactional(readOnly = true)
public class CdbooMusicInsertService extends CrudService<CdbooMusicInsertDao, CdbooMusicInsert> {

	public CdbooMusicInsert get(String id) {
		return super.get(id);
	}
	
	public List<CdbooMusicInsert> findList(CdbooMusicInsert cdbooMusicInsert) {
		return super.findList(cdbooMusicInsert);
	}
	
	public Page<CdbooMusicInsert> findPage(Page<CdbooMusicInsert> page, CdbooMusicInsert cdbooMusicInsert) {
		return super.findPage(page, cdbooMusicInsert);
	}
	
	@Transactional(readOnly = false)
	public void save(CdbooMusicInsert cdbooMusicInsert) {
		super.save(cdbooMusicInsert);
	}
	
	@Transactional(readOnly = false)
	public void delete(CdbooMusicInsert cdbooMusicInsert) {
		super.delete(cdbooMusicInsert);
	}
	
}