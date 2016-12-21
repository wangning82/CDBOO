/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.userchannel.service;

import java.nio.file.attribute.UserPrincipalLookupService;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.channel.service.CdbooChannelService;
import com.cdboo.userchannel.dao.CdbooUserChannelDao;
import com.cdboo.userchannel.entity.CdbooUserChannel;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.sys.dao.UserDao;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 用户频道表Service
 * @author yubin
 * @version 2016-12-21
 */
@Service
@Transactional(readOnly = true)
public class CdbooUserChannelService extends CrudService<CdbooUserChannelDao, CdbooUserChannel> {

	@Autowired
	private CdbooChannelService cdbooChannelService;
	
	@Autowired
	private UserDao userDao;
	
	public CdbooUserChannel get(String id) {
		return super.get(id);
	}
	
	public List<CdbooUserChannel> findList(CdbooUserChannel cdbooUserChannel) {
		return super.findList(cdbooUserChannel);
	}
	
	public Page<CdbooUserChannel> findPage(Page<CdbooUserChannel> page, CdbooUserChannel cdbooUserChannel) {
		return super.findPage(page, cdbooUserChannel);
	}
	
	@Transactional(readOnly = false)
	public void save(CdbooUserChannel cdbooUserChannel) {
		super.save(cdbooUserChannel);
	}
	
	@Transactional(readOnly = false)
	public void delete(CdbooUserChannel cdbooUserChannel) {
		super.delete(cdbooUserChannel);
	}
	
	/**
	 * 根据用户id获得频道用户中间表列表
	 * @param userId
	 * @return
	 */
	public List<CdbooUserChannel> getChannelListByUser(String userId) {
		User user = new User();
		user.setId(userId);
		CdbooUserChannel cdbooUserChannel = new CdbooUserChannel();
		cdbooUserChannel.setUser(user);
		List<CdbooUserChannel> cdbooUserChannels = super.findList(cdbooUserChannel);
		if(CollectionUtils.isNotEmpty(cdbooUserChannels)){
			for (CdbooUserChannel queryChannel : cdbooUserChannels) {
				String channelId = queryChannel.getChannel().getId();
				CdbooChannel cdbooChannel = cdbooChannelService.get(channelId);
				queryChannel.setChannel(cdbooChannel);
			}
		}
		return cdbooUserChannels;
	}

	public Page<CdbooUserChannel> findPageForGroupBy(Page<CdbooUserChannel> page, CdbooUserChannel cdbooUserChannel) {
		cdbooUserChannel.setPage(page);
		List<CdbooUserChannel> list = dao.findGroupByList(cdbooUserChannel);
		for (CdbooUserChannel cdbooUserChannel2 : list) {
			String channelId = cdbooUserChannel2.getChannel().getId();
			String userId = cdbooUserChannel2.getUser().getId();
			
			CdbooChannel cdbooChannel = cdbooChannelService.get(channelId);
			User user = userDao.get(userId);
			cdbooUserChannel2.setChannel(cdbooChannel);
			cdbooUserChannel2.setUser(user);
		}
		page.setList(list);
		return page;
	}
	
}