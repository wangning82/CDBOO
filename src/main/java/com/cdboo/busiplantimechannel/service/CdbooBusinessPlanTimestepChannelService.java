/**
 * 
 */
package com.cdboo.busiplantimechannel.service;

import java.util.List;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.cdboo.businessplan.entity.CdbooBusinessPlan;
import com.cdboo.businessplantimestep.dao.CdbooBusinessPlanTimestepDao;
import com.cdboo.businessplantimestep.entity.CdbooBusinessPlanTimestep;
import com.cdboo.busiplantimechannel.dao.CdbooBusinessPlanTimestepChannelDao;
import com.cdboo.busiplantimechannel.entity.CdbooBusinessPlanTimestepChannel;
import com.cdboo.channel.dao.CdbooChannelDao;
import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.timestep.entity.Timestep;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.service.CrudService;

/**
 * @author yubin
 *
 */
@Service
@Transactional(readOnly = true)
public class CdbooBusinessPlanTimestepChannelService
		extends CrudService<CdbooBusinessPlanTimestepChannelDao, CdbooBusinessPlanTimestepChannel> {

	@Autowired
	private CdbooBusinessPlanTimestepDao businessPlanTimestepDao;
	
	@Autowired
	private CdbooChannelDao cdbooChannelDao;
	
	public List<CdbooChannel> findMyList(CdbooBusinessPlanTimestepChannel entity) {
		List<CdbooBusinessPlanTimestepChannel> list = super.findList(entity);
		List<CdbooChannel> cdbooChannels = Lists.newArrayList();
		if (CollectionUtils.isNotEmpty(list)) {
			for (CdbooBusinessPlanTimestepChannel channel : list) {
				CdbooChannel channel2 = channel.getChannel();
				channel2.setOperationType(channel.getOperationType());
				cdbooChannels.add(channel2);
			}
		}
		return cdbooChannels;
	}
	
	@Transactional(readOnly = false)
	public void removeBusinessPlanTimestepChannel(CdbooBusinessPlanTimestep cdbooMyPlanTimestep) {
		/***********************
		 * 清空用户计划时段频道关联表数据，重新插入 Start
		 ***********************/
		CdbooBusinessPlanTimestepChannel delObj = new CdbooBusinessPlanTimestepChannel();
		delObj.setBusinessPlanTimestep(cdbooMyPlanTimestep);
		super.delete(delObj);
		/***********************
		 * 清空用户计划时段频道关联表数据，重新插入 End
		 ***********************/
	}

	@Transactional(readOnly = false)
	public void removeBusinessPlanTimestepChannel(CdbooBusinessPlan businessPlan) {

		/***********************
		 * 清空用户计划时段频道关联表数据，重新插入 Start
		 ***********************/
		CdbooBusinessPlanTimestep businessPlanTimestep = new CdbooBusinessPlanTimestep();
		businessPlanTimestep.setBusinessPlan(businessPlan);
		businessPlanTimestep.setTimestep(new Timestep(businessPlan.getTimeStepId()));
		List<CdbooBusinessPlanTimestep> list = businessPlanTimestepDao.findList(businessPlanTimestep);

		if (CollectionUtils.isNotEmpty(list)) {
			CdbooBusinessPlanTimestep businessPlanTimestep2 = list.get(0);
			removeBusinessPlanTimestepChannel(businessPlanTimestep2);
		}
		/***********************
		 * 清空用户计划时段频道关联表数据，重新插入 End
		 ***********************/
	}
	
	@Transactional(readOnly=false)
	public void saveTimestepChannel(CdbooBusinessPlan businessPlan) {
		List<String> cdbooChannels = businessPlan.getChannelIds();
		List<String> operationTypes = businessPlan.getOperationTypes();

		if (CollectionUtils.isNotEmpty(cdbooChannels)) {

			/***********************
			 * 清空用户计划时段频道关联表数据，重新插入 Start
			 ***********************/
			CdbooBusinessPlanTimestep businessPlanTimestep = new CdbooBusinessPlanTimestep();
			businessPlanTimestep.setBusinessPlan(businessPlan);
			businessPlanTimestep.setTimestep(new Timestep(businessPlan.getTimeStepId()));
			List<CdbooBusinessPlanTimestep> list = businessPlanTimestepDao.findList(businessPlanTimestep);

			if (CollectionUtils.isNotEmpty(list)) {

				/***********************
				 * 清空用户计划时段频道关联表数据，重新插入 Start
				 ***********************/
				CdbooBusinessPlanTimestep cdbooBusinessPlanTimestep = list.get(0);
				removeBusinessPlanTimestepChannel(cdbooBusinessPlanTimestep);
				/***********************
				 * 清空用户计划时段频道关联表数据，重新插入 End
				 ***********************/

				for (int i = 0; i < cdbooChannels.size(); i++) {
					// 频道id
					String channelId = cdbooChannels.get(i);
					// 业态
					String operationType = operationTypes.get(i);

					/***********************
					 * 检索用户频道对象 Start
					 ***********************/
					CdbooChannel cdbooChannel = cdbooChannelDao.get(channelId);
					/***********************
					 * 检索用户频道对象 End
					 ***********************/

					/*********************** 计划时段频道关联记录不存在则创建记录保存 ***********************/
					CdbooBusinessPlanTimestepChannel businessPlanTimestepChannel = new CdbooBusinessPlanTimestepChannel();
					businessPlanTimestepChannel.setBusinessPlanTimestep(cdbooBusinessPlanTimestep);
					businessPlanTimestepChannel.setChannel(cdbooChannel);
					businessPlanTimestepChannel.setChannelType(cdbooChannel.getChannelType());
					businessPlanTimestepChannel.setOperationType(operationType);
					super.save(businessPlanTimestepChannel);
				}
			}
		} else {
			removeBusinessPlanTimestepChannel(businessPlan);
		}
	}
}
