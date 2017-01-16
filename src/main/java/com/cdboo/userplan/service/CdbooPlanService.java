/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.userplan.service;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.channel.service.CdbooChannelService;
import com.cdboo.common.Constants;
import com.cdboo.timestep.entity.Timestep;
import com.cdboo.userchannel.entity.CdbooUserChannel;
import com.cdboo.userchannel.service.CdbooUserChannelService;
import com.cdboo.usergroup.entity.CdbooUserGroup;
import com.cdboo.usergroup.service.CdbooUserGroupService;
import com.cdboo.userplan.dao.CdbooPlanDao;
import com.cdboo.userplan.entity.CdbooPlan;
import com.cdboo.userplan.model.PlanModel;
import com.cdboo.usertimestep.entity.CdbooUserTimestep;
import com.cdboo.usertimestep.service.CdbooUserTimestepService;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 用户计划表Service
 * 
 * @author yubin
 * @version 2016-12-21
 */
@Service
@Transactional(readOnly = true)
public class CdbooPlanService extends CrudService<CdbooPlanDao, CdbooPlan> {

	@Autowired
	private CdbooChannelService channelService;

	@Autowired
	private CdbooUserChannelService userChannelService;

	@Autowired
	private CdbooUserGroupService cdbooUserGroupService;

	@Autowired
	private CdbooUserTimestepService cdbooUserTimestepService;

	public CdbooPlan get(String id) {
		return super.get(id);
	}

	public List<CdbooPlan> findList(CdbooPlan cdbooPlan) {
		return super.findList(cdbooPlan);
	}

	public Page<CdbooPlan> findPage(Page<CdbooPlan> page, CdbooPlan cdbooPlan) {
		return super.findPage(page, cdbooPlan);
	}

	public Page<CdbooPlan> findMyPage(Page<CdbooPlan> page, CdbooPlan cdbooPlan) {
		page = findPage(page, cdbooPlan);
		List<CdbooPlan> list = page.getList();
		if (CollectionUtils.isNotEmpty(list)) {
			for (CdbooPlan tempObj : list) {
				String userChannelId = tempObj.getUserChannelId();
				String userTimestepId = tempObj.getUserTimestepId();

				if (StringUtils.isNotBlank(userChannelId)) {
					String channelType = tempObj.getChannelType();
					if (StringUtils.equals(Constants.CHANNEL_TYPE_CHILD, channelType)) {
						CdbooUserChannel cdbooUserChannel = userChannelService.get(userChannelId);
						if (cdbooUserChannel != null) {
							CdbooChannel channel = cdbooUserChannel.getChannel();
							CdbooChannel viewChannel = channelService.get(channel);
							tempObj.setChannel(viewChannel);
						}
					}
					if (StringUtils.equals(Constants.CHANNEL_TYPE_GROUP, channelType)) {
						CdbooUserGroup cdbooUserGroup = cdbooUserGroupService.get(userChannelId);
						if (cdbooUserGroup != null) {
							CdbooChannel channel = cdbooUserGroup.getCdbooChannel();
							if (channel != null) {
								CdbooChannel viewChannel = channelService.get(channel);
								tempObj.setChannel(viewChannel);
							}
						}
					}
				}

				if (StringUtils.isNotBlank(userTimestepId)) {
					CdbooUserTimestep userTimestep = cdbooUserTimestepService.get(userTimestepId);
					if (userTimestep != null) {
						Timestep timestep = new Timestep(userTimestep.getName(), userTimestep.getStartTime(),
								userTimestep.getEndTime());
						tempObj.setTimestep(timestep);
					}
				}
			}
		}
		return page;
	}

	@Transactional(readOnly = false)
	public void save(PlanModel planModel) {

		String userId = planModel.getUserId();

		/******************** 检索用户频道查询对象，为了复用，写循环外面了 Start ********************/
		User user = new User(userId);
		CdbooChannel cdbooChannel = new CdbooChannel();
		CdbooUserChannel cdbooUserChannel = new CdbooUserChannel();
		cdbooUserChannel.setUser(user);
		cdbooUserChannel.setChannel(cdbooChannel);
		/******************** 检索用户频道查询对象，为了复用，写循环外面了 Start ********************/

		CdbooUserGroup userGroup = new CdbooUserGroup();
		CdbooChannel groupChannel = new CdbooChannel();
		userGroup.setUser(user);
		userGroup.setCdbooChannel(groupChannel);
		
		for (CdbooPlan cdbooPlan : planModel.getPlanList()) {
			String userChannelId = cdbooPlan.getUserChannelId();
			String[] userChannelArray = StringUtils.split(userChannelId,",");
			String channelId = userChannelArray[0];
			String channelType = userChannelArray[1];

			String userChannelIdStr = "";
			/******************** 检索用户频道中间表 Start ********************/
			
			if (StringUtils.equals(Constants.CHANNEL_TYPE_CHILD, channelType)) {
				cdbooChannel.setId(channelId);
				List<CdbooUserChannel> list = userChannelService.findList(cdbooUserChannel);
				if (CollectionUtils.isEmpty(list)) {
					continue;
				}
				CdbooUserChannel cdbooUserChannel2 = list.get(0);
				userChannelIdStr = cdbooUserChannel2.getId();
			}
			if (StringUtils.equals(Constants.CHANNEL_TYPE_GROUP, channelType)) {
				groupChannel.setId(channelId);
				List<CdbooUserGroup> list = cdbooUserGroupService.findList(userGroup);
				if (CollectionUtils.isEmpty(list)) {
					continue;
				}
				CdbooUserGroup cdbooUserGroup = list.get(0);
				userChannelIdStr = cdbooUserGroup.getId();
			}
			
			/******************** 检索用户频道中间表 End ********************/

			cdbooPlan.setUserChannelId(userChannelIdStr);
			cdbooPlan.setUser(user);
			cdbooPlan.setChannelType(channelType);
			super.save(cdbooPlan);
		}
	}

	@Transactional(readOnly = false)
	public void delete(CdbooPlan cdbooPlan) {
		super.delete(cdbooPlan);
	}

	public CdbooChannel getChannelByUserChannelIdAndChannelType(String userChannelId, String channelType) {
		if (StringUtils.equals(Constants.CHANNEL_TYPE_CHILD, channelType)) {
			CdbooUserChannel cdbooUserChannel = userChannelService.get(userChannelId);
			CdbooChannel channel = cdbooUserChannel.getChannel();
			CdbooChannel cdbooChannel = channelService.get(channel);
			return cdbooChannel;
		}
		if (StringUtils.equals(Constants.CHANNEL_TYPE_GROUP, channelType)) {
			CdbooUserGroup cdbooUserGroup = cdbooUserGroupService.get(userChannelId);
			CdbooChannel channel = cdbooUserGroup.getCdbooChannel();
			CdbooChannel cdbooChannel = channelService.get(channel);
			return cdbooChannel;
		}
		return new CdbooChannel();
	}
}