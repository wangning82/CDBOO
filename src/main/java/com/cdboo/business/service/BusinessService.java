/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.business.service;

import java.util.List;

import com.cdboo.business.entity.BusinessTimestep;
import com.cdboo.timestep.dao.TimestepDao;
import com.cdboo.timestep.entity.Timestep;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.utils.IdGen;
import org.springframework.beans.factory.annotation.Autowired;
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

	@Autowired
	private BusinessDao businessDao;

	@Autowired
	private TimestepDao timestepDao;

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

	@Transactional(readOnly = false)
	public void insertBusinessTimestep(BusinessTimestep businessTimestep) {

		List<BusinessTimestep> businessTimestepList = Lists.newArrayList();

		for (Timestep timestep : businessTimestep.getTimestepList()) {
			BusinessTimestep _businessTimestep = new BusinessTimestep();
			_businessTimestep.setTimestep(timestep);
			_businessTimestep.setBusiness(businessTimestep.getBusiness());
			_businessTimestep.setName(businessTimestep.getName());
			_businessTimestep.setSort(businessTimestep.getSort());
			_businessTimestep.setRemarks(businessTimestep.getRemarks());

			_businessTimestep.preInsert();
			businessDao.insertBusinessTimestep(_businessTimestep);
		}
	}
}