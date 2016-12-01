/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.business.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.TreeService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.cdboo.business.entity.Business;
import com.cdboo.business.dao.BusinessDao;

/**
 * 行业Service
 * @author 朱广成
 * @version 2016-12-01
 */
@Service
@Transactional(readOnly = true)
public class BusinessService extends TreeService<BusinessDao, Business> {

	public Business get(String id) {
		return super.get(id);
	}
	
	public List<Business> findList(Business business) {
		if (StringUtils.isNotBlank(business.getParentIds())){
			business.setParentIds(","+business.getParentIds()+",");
		}
		return super.findList(business);
	}
	
	@Transactional(readOnly = false)
	public void save(Business business) {
		super.save(business);
	}
	
	@Transactional(readOnly = false)
	public void delete(Business business) {
		super.delete(business);
	}
	
}