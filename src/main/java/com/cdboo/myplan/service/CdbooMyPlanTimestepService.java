/**
 * 
 */
package com.cdboo.myplan.service;

import java.util.List;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.cdboo.myplan.dao.CdbooMyPlanTimestepDao;
import com.cdboo.myplan.entity.CdbooMyPlan;
import com.cdboo.myplan.entity.CdbooMyPlanTimestep;
import com.cdboo.usertimestep.entity.CdbooUserTimestep;
import com.cdboo.usertimestep.service.CdbooUserTimestepService;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.service.CrudService;

/**
 * @author yubin
 *
 */
@Service
@Transactional(readOnly = true)
public class CdbooMyPlanTimestepService extends CrudService<CdbooMyPlanTimestepDao, CdbooMyPlanTimestep>{
	
	@Autowired
	public CdbooUserTimestepService cdbooUserTimestepService;
	
	public List<CdbooUserTimestep> findUserTimeStepList(CdbooMyPlan cdbooMyPlan) {
		CdbooMyPlanTimestep cdbooMyPlanTimestep = new CdbooMyPlanTimestep();
		cdbooMyPlanTimestep.setPlan(cdbooMyPlan);
		List<CdbooMyPlanTimestep> list = super.findList(cdbooMyPlanTimestep);

		List<CdbooUserTimestep> userTimestepList = Lists.newArrayList();
		if (CollectionUtils.isNotEmpty(list)) {
			for (CdbooMyPlanTimestep cdbooMyPlanTimestep2 : list) {
				CdbooUserTimestep userTimestep = cdbooMyPlanTimestep2.getUserTimestep();
				String id = userTimestep.getId();
				CdbooUserTimestep cdbooUserTimestep = cdbooUserTimestepService.get(id);
				userTimestepList.add(cdbooUserTimestep);
			}
		}
		return userTimestepList;
	}
	
	public void remove(CdbooMyPlanTimestep cdbooMyPlanTimestep){
		dao.remove(cdbooMyPlanTimestep);
	}
	
}