/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.userchannel.service;

import java.util.List;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.cdboo.channel.dao.CdbooChannelDao;
import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.common.Constants;
import com.cdboo.userchannel.dao.CdbooUserChannelDao;
import com.cdboo.userchannel.entity.CdbooUserChannel;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.dao.UserDao;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 用户频道表Service
 * 
 * @author yubin
 * @version 2016-12-21
 */
@Service
@Transactional(readOnly = true)
public class CdbooUserChannelService extends CrudService<CdbooUserChannelDao, CdbooUserChannel> {

	@Autowired
	private CdbooChannelDao cdbooChannelDao;

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

	/**
	 * 保存用户子频道
	 * @param cdbooUserChannel
	 */
	@Transactional(readOnly = false)
	public void saveUserChannel(CdbooUserChannel cdbooUserChannel) {
		// 用户
		User user = cdbooUserChannel.getUser();
		List<String> channelIds = cdbooUserChannel.getChannelIds();

		CdbooUserChannel checkObj = new CdbooUserChannel();
		checkObj.setUser(user);

		for (String channelId : channelIds) {
			CdbooChannel cdbooChannel = new CdbooChannel(channelId);
			checkObj.setChannel(cdbooChannel);
			List<CdbooUserChannel> userChannels = super.findList(checkObj);
			if (CollectionUtils.isEmpty(userChannels)) {
				CdbooUserChannel saveObj = new CdbooUserChannel();
				saveObj.setChannel(cdbooChannel);
				saveObj.setUser(user);
				saveObj.setChannelType(Constants.CHANNEL_TYPE_CHILD);
				super.save(saveObj);
			}
		}
	}
	
	/**
	 * 保存用户组合频道
	 * @param cdbooUserChannel
	 */
	@Transactional(readOnly = false)
	public void saveUserGroupChannel(CdbooUserChannel cdbooUserChannel) {
		List<String> channelIds = cdbooUserChannel.getChannelIds();
		if (CollectionUtils.isNotEmpty(channelIds)) {
			for (String channelId : channelIds) {
				CdbooUserChannel queryObj = new CdbooUserChannel();
				queryObj.setUser(cdbooUserChannel.getUser());
				queryObj.setChannel(new CdbooChannel(channelId));
				List<CdbooUserChannel> findList = super.findList(queryObj);
				if (CollectionUtils.isEmpty(findList)) {
					queryObj.setChannelType(Constants.CHANNEL_TYPE_GROUP);
					super.save(queryObj);
				}
			}
		}
	}

	@Transactional(readOnly = false)
	public void delete(CdbooUserChannel cdbooUserChannel) {
		List<CdbooUserChannel> cdbooUserChannels = dao.findList(cdbooUserChannel);
		for (CdbooUserChannel delUserChannel : cdbooUserChannels) {
			dao.remove(delUserChannel);
		}
	}
	
	@Transactional(readOnly = false)
	public void remove(CdbooUserChannel cdbooUserChannel) {
		dao.remove(cdbooUserChannel);
	}

	/**
	 * 根据用户查询他绑定的频道
	 * 
	 * @param user
	 *            用户
	 * @author yubin
	 * @return 频道集合
	 */
	public List<CdbooChannel> getChannelListByUser(User user,String channelType) {
		List<CdbooChannel> cdbooChannels = Lists.newArrayList();

		// 组装查询对象
		CdbooUserChannel cdbooUserChannel = new CdbooUserChannel();
		if(StringUtils.isNotBlank(channelType)){
			cdbooUserChannel.setChannelType(channelType);
		}
		cdbooUserChannel.setUser(user);

		/******************* 查询用户对应的频道信息返回 Start ********************/
		List<CdbooUserChannel> cdbooUserChannels = dao.findList(cdbooUserChannel);
		if (CollectionUtils.isNotEmpty(cdbooUserChannels)) {
			for (CdbooUserChannel queryChannel : cdbooUserChannels) {
				CdbooChannel channel = queryChannel.getChannel();
				cdbooChannels.add(channel);
			}
		}
		/******************* 查询用户对应的频道信息返回 End ********************/
		return cdbooChannels;
	}

	public Page<CdbooUserChannel> findPageForGroupBy(Page<CdbooUserChannel> page, CdbooUserChannel cdbooUserChannel) {
		cdbooUserChannel.setPage(page);
		List<CdbooUserChannel> list = dao.findList(cdbooUserChannel);
		for (CdbooUserChannel cdbooUserChannel2 : list) {
			User user = userDao.get(cdbooUserChannel2.getUser().getId());
			cdbooUserChannel2.setUser(user);

			String channelId = cdbooUserChannel2.getChannel().getId();
			CdbooChannel cdbooChannel = cdbooChannelDao.get(channelId);
			cdbooUserChannel2.setChannel(cdbooChannel);
		}
		page.setList(list);
		return page;
	}

}