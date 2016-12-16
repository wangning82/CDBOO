/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.business.service;

import java.util.List;

import com.cdboo.business.entity.BusinessTimestep;
import com.cdboo.business.model.BusinessTimestepModel;
import com.cdboo.timestep.dao.TimestepDao;
import com.cdboo.timestep.entity.Timestep;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.persistence.Page;
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

	public Page<BusinessTimestep> findTimestepByBusinessTimestep(Page<BusinessTimestep> page, BusinessTimestep businessTimestep) {
		List<BusinessTimestep> list = businessDao.findTimestepByBusinessTimestep(businessTimestep);
		page.setList(list);
		return page;
	}

	@Transactional(readOnly = false)
	public void save(BusinessTimestepModel businessTimestepModel) {

		Business business = new Business();
		business.setId(businessTimestepModel.getBusinessId());

		for (BusinessTimestep businessTimestep : businessTimestepModel.getBusinessTimestepList()) {
			if (businessTimestep.getId() == null){
				continue;
			}

			businessTimestep.setBusiness(business);
			if (BusinessTimestep.DEL_FLAG_NORMAL.equals(businessTimestep.getDelFlag())){
				if (org.apache.commons.lang3.StringUtils.isBlank(businessTimestep.getId())) {
					businessTimestep.preInsert();
					businessDao.insertBusinessTimestep(businessTimestep);
				} else {
					businessTimestep.preUpdate();
					businessDao.updateBusinessTimestep(businessTimestep);
				}
			} else {
				businessDao.deleteBusinessTimestep(businessTimestep);
			}

		}

	}

	public BusinessTimestep getBusinessTimestep(String id) {
		return businessDao.getBusinessTimestep(id);
	}
}