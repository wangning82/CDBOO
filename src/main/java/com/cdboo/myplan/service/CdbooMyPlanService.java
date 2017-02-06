/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.myplan.service;

import java.util.List;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.cdboo.myplan.dao.CdbooMyPlanDao;
import com.cdboo.myplan.entity.CdbooMyPlan;
import com.cdboo.myplan.entity.CdbooMyPlanTimestep;
import com.cdboo.usertimestep.service.CdbooUserTimestepService;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import jersey.repackaged.com.google.common.collect.Lists;

/**
 * 新计划表Service
 * @author yubin
 * @version 2017-02-03
 */
@Service
@Transactional(readOnly = true)
public class CdbooMyPlanService extends CrudService<CdbooMyPlanDao, CdbooMyPlan> {

	@Autowired
	private CdbooMyPlanTimestepService cdbooMyPlanTimestepService;
	
	@Autowired
	private CdbooUserTimestepService cdbooUserTimestepService;
	
	public CdbooMyPlan get(String id) {
		CdbooMyPlan cdbooMyPlan = super.get(id);
		cdbooMyPlan.setCdbooMyPlanTimestepList(cdbooMyPlanTimestepService.findList(new CdbooMyPlanTimestep(cdbooMyPlan)));
		return cdbooMyPlan;
	}
	
	public List<CdbooMyPlan> findList(CdbooMyPlan cdbooMyPlan) {
		return super.findList(cdbooMyPlan);
	}
	
	public Page<CdbooMyPlan> findPage(Page<CdbooMyPlan> page, CdbooMyPlan cdbooMyPlan) {
		return super.findPage(page, cdbooMyPlan);
	}
	
	@Transactional(readOnly = false)
	public void save(CdbooMyPlan cdbooMyPlan) {
		super.save(cdbooMyPlan);
	}
	
	@Transactional(readOnly = false)
	public void saveUserTimestep(CdbooMyPlan cdbooMyPlan) {
		List<String> userTimestepIds = cdbooMyPlan.getUserTimestepIds();

		if (CollectionUtils.isNotEmpty(userTimestepIds)) {

			List<CdbooMyPlanTimestep> saveList = Lists.newArrayList();

			CdbooMyPlanTimestep removeObj = new CdbooMyPlanTimestep();
			removeObj.setPlan(cdbooMyPlan);
			cdbooMyPlanTimestepService.remove(removeObj);

			for (String userTimestepId : userTimestepIds) {
				CdbooMyPlanTimestep cdbooMyPlanTimestep = new CdbooMyPlanTimestep();
				cdbooMyPlanTimestep.setPlan(cdbooMyPlan);
				cdbooMyPlanTimestep.setUserTimestep(cdbooUserTimestepService.get(userTimestepId));
				saveList.add(cdbooMyPlanTimestep);
			}

			for (CdbooMyPlanTimestep cdbooMyPlanTimestep : saveList) {
				cdbooMyPlanTimestepService.save(cdbooMyPlanTimestep);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(CdbooMyPlan cdbooMyPlan) {
		super.delete(cdbooMyPlan);
		cdbooMyPlanTimestepService.delete(new CdbooMyPlanTimestep(cdbooMyPlan));
	}
	
}