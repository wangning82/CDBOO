package com.cdboo.businessplantimestep.service;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cdboo.businessplan.entity.CdbooBusinessPlan;
import com.cdboo.businessplantimestep.dao.CdbooBusinessPlanTimestepDao;
import com.cdboo.businessplantimestep.entity.CdbooBusinessPlanTimestep;
import com.cdboo.timestep.dao.TimestepDao;
import com.cdboo.timestep.entity.Timestep;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.service.CrudService;

@Service
@Transactional(readOnly=true)
public class CdbooBusinessPlanTimestepService extends CrudService<CdbooBusinessPlanTimestepDao, CdbooBusinessPlanTimestep>{
	
	@Autowired
	private TimestepDao timestepDao;
	
	public List<Timestep> findTimeStepsByConditions(CdbooBusinessPlanTimestep planTimestep) {
		List<Timestep> timesteps = Lists.newArrayList();
		List<CdbooBusinessPlanTimestep> list = super.findList(planTimestep);
		if (CollectionUtils.isNotEmpty(list)) {
			for (CdbooBusinessPlanTimestep cdbooBusinessPlanTimestep : list) {
				Timestep timestep = cdbooBusinessPlanTimestep.getTimestep();
				timestep = timestepDao.get(timestep);
				timesteps.add(timestep);
			}
		}
		return timesteps;
	}
	
	@Transactional(readOnly=false)
	public void saveTimeStep(CdbooBusinessPlan cdbooBusinessPlan){
		CdbooBusinessPlanTimestep delObj = new CdbooBusinessPlanTimestep();
		delObj.setBusinessPlan(cdbooBusinessPlan);
		dao.remove(delObj);
		
		List<String> timeStepIds = cdbooBusinessPlan.getTimeStepIds();
		if(CollectionUtils.isNotEmpty(timeStepIds)){
			for (String timeStepId : timeStepIds) {
				Timestep timestep = timestepDao.get(timeStepId);
				CdbooBusinessPlanTimestep saveObj = new CdbooBusinessPlanTimestep();
				saveObj.setBusinessPlan(cdbooBusinessPlan);
				saveObj.setTimestep(timestep);
				super.save(saveObj);
			}
		}
	}
}
