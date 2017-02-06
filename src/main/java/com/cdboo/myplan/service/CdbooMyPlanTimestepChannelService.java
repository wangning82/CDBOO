package com.cdboo.myplan.service;

import java.util.List;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.channel.service.CdbooChannelService;
import com.cdboo.myplan.dao.CdbooMyPlanTimestepChannelDao;
import com.cdboo.myplan.entity.CdbooMyPlan;
import com.cdboo.myplan.entity.CdbooMyPlanTimestep;
import com.cdboo.myplan.entity.CdbooMyPlanTimestepChannel;
import com.cdboo.userchannel.entity.CdbooUserChannel;
import com.cdboo.userchannel.service.CdbooUserChannelService;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.service.CrudService;

@Service
@Transactional(readOnly = true)
public class CdbooMyPlanTimestepChannelService
		extends CrudService<CdbooMyPlanTimestepChannelDao, CdbooMyPlanTimestepChannel> {

	@Autowired
	private CdbooChannelService cdbooChannelService;

	@Autowired
	private CdbooUserChannelService cdbooUserChannelService;

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
			CdbooMyPlanTimestep cdbooMyPlanTimestep = new CdbooMyPlanTimestep(cdbooMyPlan.getUserTimeStepId());
			CdbooMyPlanTimestepChannel delObj = new CdbooMyPlanTimestepChannel();
			delObj.setMyPlanTimestep(cdbooMyPlanTimestep);
			super.delete(delObj);

			for (int i = 0; i < cdbooUserChannels.size(); i++) {
				String userChannelId = cdbooUserChannels.get(i);
				String operationType = operationTypes.get(i);

				CdbooUserChannel cdbooUserChannel = cdbooUserChannelService.get(userChannelId);

				String channelId = cdbooUserChannel.getChannel().getId();
				CdbooChannel cdbooChannel = cdbooChannelService.get(channelId);

				CdbooMyPlanTimestepChannel myPlanTimestepChannel = new CdbooMyPlanTimestepChannel();
				myPlanTimestepChannel.setMyPlanTimestep(cdbooMyPlanTimestep);
				myPlanTimestepChannel.setUserChannel(cdbooUserChannel);
				myPlanTimestepChannel.setChannelType(cdbooChannel.getChannelType());
				myPlanTimestepChannel.setOperationType(operationType);
				super.save(myPlanTimestepChannel);
			}
		}
	}
}
