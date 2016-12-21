/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.userplan.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cdboo.userplan.entity.CdbooPlan;
import com.cdboo.userplan.dao.CdbooPlanDao;

/**
 * 用户计划表Service
 * @author yubin
 * @version 2016-12-21
 */
@Service
@Transactional(readOnly = true)
public class CdbooPlanService extends CrudService<CdbooPlanDao, CdbooPlan> {

	public CdbooPlan get(String id) {
		return super.get(id);
	}
	
	public List<CdbooPlan> findList(CdbooPlan cdbooPlan) {
		return super.findList(cdbooPlan);
	}
	
	public Page<CdbooPlan> findPage(Page<CdbooPlan> page, CdbooPlan cdbooPlan) {
		return super.findPage(page, cdbooPlan);
	}
	
	@Transactional(readOnly = false)
	public void save(CdbooPlan cdbooPlan) {
		super.save(cdbooPlan);
	}
	
	@Transactional(readOnly = false)
	public void delete(CdbooPlan cdbooPlan) {
		super.delete(cdbooPlan);
	}
	
}