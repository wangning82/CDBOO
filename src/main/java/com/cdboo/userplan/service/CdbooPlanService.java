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
import com.cdboo.userchannel.entity.CdbooUserChannel;
import com.cdboo.userchannel.service.CdbooUserChannelService;
import com.cdboo.userplan.dao.CdbooPlanDao;
import com.cdboo.userplan.entity.CdbooPlan;
import com.cdboo.userplan.model.PlanModel;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 用户计划表Service
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
		if(CollectionUtils.isNotEmpty(list)){
			for (CdbooPlan tempObj : list) {
				CdbooChannel tempChannel = tempObj.getChannel();
				String channelId = tempChannel.getId();
				CdbooChannel cdbooChannel = channelService.get(channelId);
				tempObj.setChannel(cdbooChannel);
			}
		}
		return page;
	}
	
	@Transactional(readOnly = false)
	public void save(PlanModel planModel) {

		String userId = planModel.getUserId();

		User user = new User(userId);
		CdbooChannel cdbooChannel = new CdbooChannel();

		CdbooUserChannel cdbooUserChannel = new CdbooUserChannel();
		cdbooUserChannel.setUser(user);
		cdbooUserChannel.setChannel(cdbooChannel);

		for (CdbooPlan cdbooPlan : planModel.getPlanList()) {

			String channelId = cdbooPlan.getUserChannelId();
			cdbooChannel.setId(channelId);
			List<CdbooUserChannel> list = userChannelService.findList(cdbooUserChannel);
			if (CollectionUtils.isEmpty(list)) {
				continue;
			}
			CdbooUserChannel cdbooUserChannel2 = list.get(0);
			cdbooPlan.setUserChannelId(cdbooUserChannel2.getId());
			cdbooPlan.setUser(user);
			super.save(cdbooPlan);
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(CdbooPlan cdbooPlan) {
		super.delete(cdbooPlan);
	}
	
}