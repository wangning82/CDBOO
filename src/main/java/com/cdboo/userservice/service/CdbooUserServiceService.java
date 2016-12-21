/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.userservice.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cdboo.userservice.entity.CdbooUserService;
import com.cdboo.userservice.dao.CdbooUserServiceDao;

/**
 * 用户服务信息Service
 * @author yubin
 * @version 2016-12-21
 */
@Service
@Transactional(readOnly = true)
public class CdbooUserServiceService extends CrudService<CdbooUserServiceDao, CdbooUserService> {

	public CdbooUserService get(String id) {
		return super.get(id);
	}
	
	public List<CdbooUserService> findList(CdbooUserService cdbooUserService) {
		return super.findList(cdbooUserService);
	}
	
	public Page<CdbooUserService> findPage(Page<CdbooUserService> page, CdbooUserService cdbooUserService) {
		return super.findPage(page, cdbooUserService);
	}
	
	@Transactional(readOnly = false)
	public void save(CdbooUserService cdbooUserService) {
		super.save(cdbooUserService);
	}
	
	@Transactional(readOnly = false)
	public void delete(CdbooUserService cdbooUserService) {
		super.delete(cdbooUserService);
	}
	
}