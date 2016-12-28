/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.taluser.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cdboo.taluser.entity.TalUser;
import com.cdboo.taluser.dao.TalUserDao;

/**
 * 首页功能Service
 * @author wn
 * @version 2016-12-28
 */
@Service
@Transactional(readOnly = true)
public class TalUserService extends CrudService<TalUserDao, TalUser> {

	public TalUser get(String id) {
		return super.get(id);
	}
	
	public List<TalUser> findList(TalUser talUser) {
		return super.findList(talUser);
	}
	
	public Page<TalUser> findPage(Page<TalUser> page, TalUser talUser) {
		return super.findPage(page, talUser);
	}
	
	@Transactional(readOnly = false)
	public void save(TalUser talUser) {
		super.save(talUser);
	}
	
	@Transactional(readOnly = false)
	public void delete(TalUser talUser) {
		super.delete(talUser);
	}
	
}