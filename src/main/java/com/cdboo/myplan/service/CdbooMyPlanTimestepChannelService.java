package com.cdboo.myplan.service;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.channel.service.CdbooChannelService;
import com.cdboo.myplan.dao.CdbooMyPlanTimestepChannelDao;
import com.cdboo.myplan.dao.CdbooMyPlanTimestepDao;
import com.cdboo.myplan.entity.CdbooMyPlan;
import com.cdboo.myplan.entity.CdbooMyPlanTimestep;
import com.cdboo.myplan.entity.CdbooMyPlanTimestepChannel;
import com.cdboo.userchannel.dao.CdbooUserChannelDao;
import com.cdboo.userchannel.entity.CdbooUserChannel;
import com.cdboo.usertimestep.entity.CdbooUserTimestep;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.service.CrudService;

@Service
@Transactional(readOnly = true)
public class CdbooMyPlanTimestepChannelService
		extends CrudService<CdbooMyPlanTimestepChannelDao, CdbooMyPlanTimestepChannel> {

	@Autowired
	private CdbooChannelService cdbooChannelService;

	@Autowired
	private CdbooUserChannelDao cdbooUserChannelDao;

	@Autowired
	private CdbooMyPlanTimestepDao cdbooMyPlanTimestepDao;
	
	public List<CdbooUserChannel> findUserChannelList(CdbooMyPlanTimestepChannel myPlanTimestepChannel) {
		List<CdbooMyPlanTimestepChannel> list = super.findList(myPlanTimestepChannel);
		List<CdbooUserChannel> userChannelList = Lists.newArrayList();
		if (CollectionUtils.isNotEmpty(list)) {
			for (CdbooMyPlanTimestepChannel cdbooMyPlanTimestepChannel : list) {
				userChannelList.add(cdbooMyPlanTimestepChannel.getUserChannel());
			}
		}
		return userChannelList;
	}

	@Transactional(readOnly = false)
	public void saveTimestepChannel(CdbooMyPlan cdbooMyPlan) {
		List<String> cdbooUserChannels = cdbooMyPlan.getUserChannelIds();
		List<String> operationTypes = cdbooMyPlan.getOperationTypes();

		if (CollectionUtils.isNotEmpty(cdbooUserChannels)) {
			
			/*********************** 清空用户计划时段频道关联表数据，重新插入 Start ***********************/
			CdbooMyPlanTimestep cdbooMyPlanTimestep = new CdbooMyPlanTimestep(cdbooMyPlan.getUserTimeStepId());
			CdbooMyPlanTimestepChannel delObj = new CdbooMyPlanTimestepChannel();
			delObj.setMyPlanTimestep(cdbooMyPlanTimestep);
			super.delete(delObj);
			/*********************** 清空用户计划时段频道关联表数据，重新插入 Start ***********************/
			
			/*********************** 检索 Start用户计划时段关联表id Start ***********************/
			CdbooMyPlanTimestep cdbooMyPlanTimestep2 = new CdbooMyPlanTimestep();
			cdbooMyPlanTimestep2.setPlan(cdbooMyPlan);
			cdbooMyPlanTimestep2.setUserTimestep(new CdbooUserTimestep(cdbooMyPlan.getUserTimeStepId()));
			List<CdbooMyPlanTimestep> cdbooMyPlanTimesteps = cdbooMyPlanTimestepDao.findList(cdbooMyPlanTimestep2);
			CdbooMyPlanTimestep saveMyPlanTimestepObj = cdbooMyPlanTimesteps.get(0);
			/*********************** 检索 Start用户计划时段关联表id End ***********************/
			
			for (int i = 0; i < cdbooUserChannels.size(); i++) {
				//用户频道关联表id
				String userChannelId = cdbooUserChannels.get(i);
				//业态
				String operationType = operationTypes.get(i);

				/*********************** 检索用户频道对象 Start ***********************/
				CdbooUserChannel cdbooUserChannel = cdbooUserChannelDao.get(userChannelId);
				/*********************** 检索用户频道对象 End ***********************/
				
				/*********************** 检索频道对象 Start ***********************/
				String channelId = cdbooUserChannel.getChannel().getId();
				CdbooChannel cdbooChannel = cdbooChannelService.get(channelId);
				/*********************** 检索频道对象 End ***********************/
				
				/*********************** 检查计划时段频道关联记录是否存在 Start ***********************/
				CdbooMyPlanTimestepChannel checkObj = new CdbooMyPlanTimestepChannel();
				checkObj.setUserChannel(cdbooUserChannel);
				checkObj.setMyPlanTimestep(saveMyPlanTimestepObj);
				List<CdbooMyPlanTimestepChannel> checkList = super.findList(checkObj);
				/*********************** 检查计划时段频道关联记录是否存在 End ***********************/
				
				if (CollectionUtils.isNotEmpty(checkList)) {
					/*********************** 计划时段频道关联记录存在则更新业态 ***********************/
					CdbooMyPlanTimestepChannel cdbooMyPlanTimestepChannel = checkList.get(0);
					cdbooMyPlanTimestepChannel.setOperationType(operationType);
					super.save(cdbooMyPlanTimestepChannel);
				} else {
					/*********************** 计划时段频道关联记录不存在则创建记录保存 ***********************/
					CdbooMyPlanTimestepChannel myPlanTimestepChannel = new CdbooMyPlanTimestepChannel();
					myPlanTimestepChannel.setMyPlanTimestep(saveMyPlanTimestepObj);
					myPlanTimestepChannel.setUserChannel(cdbooUserChannel);
					myPlanTimestepChannel.setChannelType(cdbooChannel.getChannelType());
					myPlanTimestepChannel.setOperationType(operationType);
					super.save(myPlanTimestepChannel);
				}
			}
		}
	}
}
