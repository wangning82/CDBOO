/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.myplan.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.cdboo.myplan.entity.CdbooMyPlan;
import com.cdboo.myplan.dao.CdbooMyPlanDao;
import com.cdboo.myplan.entity.CdbooMyPlanTimestep;
import com.cdboo.myplan.dao.CdbooMyPlanTimestepDao;

/**
 * 新计划表Service
 * @author yubin
 * @version 2017-02-03
 */
@Service
@Transactional(readOnly = true)
public class CdbooMyPlanService extends CrudService<CdbooMyPlanDao, CdbooMyPlan> {

	@Autowired
	private CdbooMyPlanTimestepDao cdbooMyPlanTimestepDao;
	
	public CdbooMyPlan get(String id) {
		CdbooMyPlan cdbooMyPlan = super.get(id);
		cdbooMyPlan.setCdbooMyPlanTimestepList(cdbooMyPlanTimestepDao.findList(new CdbooMyPlanTimestep(cdbooMyPlan)));
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
		for (CdbooMyPlanTimestep cdbooMyPlanTimestep : cdbooMyPlan.getCdbooMyPlanTimestepList()){
			if (cdbooMyPlanTimestep.getId() == null){
				continue;
			}
			if (CdbooMyPlanTimestep.DEL_FLAG_NORMAL.equals(cdbooMyPlanTimestep.getDelFlag())){
				if (StringUtils.isBlank(cdbooMyPlanTimestep.getId())){
					cdbooMyPlanTimestep.setPlan(cdbooMyPlan);
					cdbooMyPlanTimestep.preInsert();
					cdbooMyPlanTimestepDao.insert(cdbooMyPlanTimestep);
				}else{
					cdbooMyPlanTimestep.preUpdate();
					cdbooMyPlanTimestepDao.update(cdbooMyPlanTimestep);
				}
			}else{
				cdbooMyPlanTimestepDao.delete(cdbooMyPlanTimestep);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(CdbooMyPlan cdbooMyPlan) {
		super.delete(cdbooMyPlan);
		cdbooMyPlanTimestepDao.delete(new CdbooMyPlanTimestep(cdbooMyPlan));
	}
	
}