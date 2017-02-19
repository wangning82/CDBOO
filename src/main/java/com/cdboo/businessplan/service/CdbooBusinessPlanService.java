package com.cdboo.businessplan.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cdboo.businessplan.dao.CdbooBusinessPlanDao;
import com.cdboo.businessplan.entity.CdbooBusinessPlan;
import com.cdboo.businessplantimestep.dao.CdbooBusinessPlanTimestepDao;
import com.cdboo.businessplantimestep.entity.CdbooBusinessPlanTimestep;
import com.cdboo.busiplantimechannel.dao.CdbooBusinessPlanTimestepChannelDao;
import com.cdboo.busiplantimechannel.entity.CdbooBusinessPlanTimestepChannel;
import com.thinkgem.jeesite.common.service.CrudService;

@Service
@Transactional(readOnly = true)
public class CdbooBusinessPlanService extends CrudService<CdbooBusinessPlanDao, CdbooBusinessPlan>{
	
	@Autowired
	private CdbooBusinessPlanTimestepDao cdbooBusinessPlanTimestepDao;
	
	@Autowired
	private CdbooBusinessPlanTimestepChannelDao cdbooBusinessPlanTimestepChannelDao;
	
	@Transactional(readOnly=false)
	public void deleteBusinessPlan(CdbooBusinessPlan businessPlan) {

		/********************** 根据行业模板创建计划对象 Start **********************/
		dao.remove(businessPlan);
		/********************** 根据行业模板创建计划对象 End **********************/

		/**********************
		 * 根据行业模板id查询行业下所有的时段对象 Start
		 **********************/
		CdbooBusinessPlanTimestep cdbooBusinessPlanTimestep = new CdbooBusinessPlanTimestep();
		cdbooBusinessPlanTimestep.setBusinessPlan(businessPlan);
		List<CdbooBusinessPlanTimestep> timeStepList = cdbooBusinessPlanTimestepDao.findList(cdbooBusinessPlanTimestep);
		/********************** 根据行业模板id查询行业下所有的时段对象 End **********************/

		for (CdbooBusinessPlanTimestep cdbooBusinessPlanTimestep2 : timeStepList) {

			cdbooBusinessPlanTimestepDao.remove(cdbooBusinessPlanTimestep2);

			/**********************
			 * 根据行业模板下的每一个时段信息检索对应的频道信息 Start
			 **********************/
			CdbooBusinessPlanTimestepChannel businessPlanTimestepChannel = new CdbooBusinessPlanTimestepChannel();
			businessPlanTimestepChannel.setBusinessPlanTimestep(cdbooBusinessPlanTimestep2);
			List<CdbooBusinessPlanTimestepChannel> channelList = cdbooBusinessPlanTimestepChannelDao
					.findList(businessPlanTimestepChannel);
			/**********************
			 * 根据行业模板下的每一个时段信息检索对应的频道信息 End
			 **********************/

			for (CdbooBusinessPlanTimestepChannel cdbooBusinessPlanTimestepChannel : channelList) {

				cdbooBusinessPlanTimestepChannelDao.delete(cdbooBusinessPlanTimestepChannel);
			}
		}
	}
}
