/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.userchannel.service;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.channel.service.CdbooChannelService;
import com.cdboo.channelmusic.entity.CdbooChannelMusic;
import com.cdboo.channelmusic.service.CdbooChannelMusicService;
import com.cdboo.music.entity.CdbooMusic;
import com.cdboo.music.service.CdbooMusicService;
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
	private CdbooChannelService cdbooChannelService;

	@Autowired
	private UserDao userDao;

	@Autowired
	private CdbooMusicService cdbooMusicService;
	
	@Autowired
	private CdbooChannelMusicService channelMusicService;

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
	public void saveUserChannel(CdbooUserChannel cdbooUserChannel) {
		// 用户
		User user = cdbooUserChannel.getUser();

		dao.removeByUser(cdbooUserChannel);

		List<String> channelIds = cdbooUserChannel.getChannelIds();

		for (String channelId : channelIds) {

			CdbooChannel cdbooChannel = cdbooChannelService.get(channelId);

			CdbooChannelMusic cdbooChannelMusic = new CdbooChannelMusic();
			cdbooChannelMusic.setChannel(cdbooChannel);
			List<CdbooChannelMusic> musicList = channelMusicService.findList(cdbooChannelMusic);

			List<CdbooUserChannel> saveList = Lists.newArrayList();
			if (CollectionUtils.isNotEmpty(musicList)) {
				for (CdbooChannelMusic channelMusic : musicList) {
					CdbooUserChannel saveObj = new CdbooUserChannel();
					saveObj.setChannel(cdbooChannel);
					saveObj.setUser(user);
					saveObj.setMusic(channelMusic.getMusic());
					saveList.add(saveObj);
				}
			}

			if (CollectionUtils.isNotEmpty(saveList)) {
				for (CdbooUserChannel saveObj : saveList) {
					super.save(saveObj);
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
	 * 根据用户查询他绑定的频道，这里按照频道groupby查询的，因为频道有可能会重复
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
			CdbooChannel cdbooChannel2 = new CdbooChannel();
			cdbooChannel2.setChannelType(channelType);
			cdbooUserChannel.setChannel(cdbooChannel2);
		}
		cdbooUserChannel.setUser(user);

		/******************* 查询用户对应的频道信息返回 Start ********************/
		List<CdbooUserChannel> cdbooUserChannels = dao.findChannelByUser(cdbooUserChannel);
		if (CollectionUtils.isNotEmpty(cdbooUserChannels)) {
			for (CdbooUserChannel queryChannel : cdbooUserChannels) {
				CdbooChannel channel = queryChannel.getChannel();
				String id = channel.getId();
				CdbooChannel cdbooChannel = cdbooChannelService.get(id);
				cdbooChannels.add(cdbooChannel);
			}
		}
		/******************* 查询用户对应的频道信息返回 End ********************/
		return cdbooChannels;
	}
	
	/**
	 * 根据用户和频道查询用户在频道上绑定的音乐信息
	 * 
	 * @param user
	 *            用户
	 * @param channel
	 *            频道
	 * @author yubin
	 * @return 音乐集合
	 */
	public List<CdbooMusic> getMusicListByUserAndChannel(User user, CdbooChannel channel) {

		List<CdbooMusic> cdbooMusicList = Lists.newArrayList();

		// 组装查询对象
		CdbooUserChannel cdbooUserChannel = new CdbooUserChannel();
		cdbooUserChannel.setUser(user);
		cdbooUserChannel.setChannel(channel);

		/******************* 查询用户对应频道下绑定的音乐信息返回 Start ********************/
		List<CdbooUserChannel> cdbooUserChannels = dao.findList(cdbooUserChannel);
		if (CollectionUtils.isNotEmpty(cdbooUserChannels)) {
			for (CdbooUserChannel queryChannel : cdbooUserChannels) {
				CdbooMusic music = queryChannel.getMusic();
				if(music == null || StringUtils.isBlank(music.getId())){
					continue;
				}
				String id = queryChannel.getMusic().getId();
				CdbooMusic cdbooMusic = cdbooMusicService.get(id);
				cdbooMusicList.add(cdbooMusic);
			}
		}
		/******************* 查询用户对应频道下绑定的音乐信息返回 End ********************/
		return cdbooMusicList;
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