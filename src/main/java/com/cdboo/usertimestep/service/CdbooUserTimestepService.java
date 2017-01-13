/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.usertimestep.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.cdboo.usertimestep.entity.CdbooUserTimestep;
import com.cdboo.usertimestep.dao.CdbooUserTimestepDao;

/**
 * 用户时段信息Service
 * @author yubin
 * @version 2016-12-21
 */
@Service
@Transactional(readOnly = true)
public class CdbooUserTimestepService extends CrudService<CdbooUserTimestepDao, CdbooUserTimestep> {

	public CdbooUserTimestep get(String id) {
		return super.get(id);
	}
	
	public List<CdbooUserTimestep> findList(CdbooUserTimestep cdbooUserTimestep) {
		return super.findList(cdbooUserTimestep);
	}
	
	public Page<CdbooUserTimestep> findPage(Page<CdbooUserTimestep> page, CdbooUserTimestep cdbooUserTimestep) {
		return super.findPage(page, cdbooUserTimestep);
	}
	
	@Transactional(readOnly = false)
	public void save(CdbooUserTimestep cdbooUserTimestep) {
		super.save(cdbooUserTimestep);
	}
	
	@Transactional(readOnly = false)
	public void delete(CdbooUserTimestep cdbooUserTimestep) {
		super.delete(cdbooUserTimestep);
	}
	
	/**
	 * 根据用户获取时段信息
	 * @param userId
	 * @return
	 */
	public List<CdbooUserTimestep> findTimeStepByUser(User user){
		CdbooUserTimestep cdbooUserTimestep = new CdbooUserTimestep();
		cdbooUserTimestep.setUser(user);
		return super.findList(cdbooUserTimestep);
	}
}