package com.cdboo.businessplantimestep.service;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cdboo.businessplantimestep.dao.CdbooBusinessPlanTimestepDao;
import com.cdboo.businessplantimestep.entity.CdbooBusinessPlanTimestep;
import com.cdboo.timestep.entity.Timestep;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.service.CrudService;

@Service
@Transactional(readOnly=true)
public class CdbooBusinessPlanTimestepService extends CrudService<CdbooBusinessPlanTimestepDao, CdbooBusinessPlanTimestep>{
	public List<Timestep> findTimeStepsByConditions(CdbooBusinessPlanTimestep planTimestep) {
		List<Timestep> timesteps = Lists.newArrayList();
		List<CdbooBusinessPlanTimestep> list = super.findList(planTimestep);
		if (CollectionUtils.isNotEmpty(list)) {
			for (CdbooBusinessPlanTimestep cdbooBusinessPlanTimestep : list) {
				timesteps.add(cdbooBusinessPlanTimestep.getTimestep());
			}
		}

		return timesteps;
	}
}
