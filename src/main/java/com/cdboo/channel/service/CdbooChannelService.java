/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.channel.service;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cdboo.channel.dao.CdbooChannelDao;
import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.channelmusic.dao.CdbooChannelMusicDao;
import com.cdboo.channelmusic.entity.CdbooChannelMusic;
import com.cdboo.childchannel.dao.CdbooGroupChildDao;
import com.cdboo.childchannel.entity.CdbooGroupChild;
import com.cdboo.common.Constants;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;

/**
 * 频道管理Service
 * @author 于滨
 * @version 2016-12-17
 */
@Service
@Transactional(readOnly = true)
public class CdbooChannelService extends CrudService<CdbooChannelDao, CdbooChannel> {

	@Autowired
	public CdbooGroupChildDao cdbooGroupChildDao;
	
	@Autowired
	private CdbooChannelMusicDao channelMusicDao;
	
	public CdbooChannel get(String id) {
		return super.get(id);
	}
	
	public List<CdbooChannel> findList(CdbooChannel cdbooChannel) {
		return super.findList(cdbooChannel);
	}
	
	public List<CdbooChannel> findGroupChannelList(){
		CdbooChannel cdbooChannel = new CdbooChannel();
		cdbooChannel.setChannelType(com.cdboo.common.Constants.CHANNEL_TYPE_GROUP);
		return super.findList(cdbooChannel);
	}
	
	public List<CdbooChannel> findChildChannelList(){
		CdbooChannel cdbooChannel = new CdbooChannel();
		cdbooChannel.setChannelType(com.cdboo.common.Constants.CHANNEL_TYPE_CHILD);
		return super.findList(cdbooChannel);
	}
	
	public Page<CdbooChannel> findPage(Page<CdbooChannel> page, CdbooChannel cdbooChannel) {
		page = super.findPage(page, cdbooChannel);
		List<CdbooChannel> list = page.getList();
		if (CollectionUtils.isNotEmpty(list)) {
			for (CdbooChannel cdbooChannel2 : list) {

				if (StringUtils.equals(Constants.CHANNEL_TYPE_CHILD, cdbooChannel2.getChannelType())) {
					CdbooChannelMusic cdbooChannelMusic = new CdbooChannelMusic();
					cdbooChannelMusic.setChannel(cdbooChannel2);
					List<CdbooChannelMusic> cdbooChannelMusics = channelMusicDao.findList(cdbooChannelMusic);
					int channelMusicSize = 0;
					if (CollectionUtils.isNotEmpty(cdbooChannelMusics)) {
						channelMusicSize = cdbooChannelMusics.size();
					}
					cdbooChannel2.setMusicSize(channelMusicSize);
				}

				if (StringUtils.equals(Constants.CHANNEL_TYPE_GROUP, cdbooChannel2.getChannelType())) {
					CdbooGroupChild cdbooGroupChild = new CdbooGroupChild();
					cdbooGroupChild.setGroupChannelId(cdbooChannel2);
					List<CdbooGroupChild> cdbooGroupChilds = cdbooGroupChildDao.findList(cdbooGroupChild);
					int childChannelSize = 0;
					if (CollectionUtils.isNotEmpty(cdbooGroupChilds)) {
						childChannelSize = cdbooGroupChilds.size();
					}
					cdbooChannel2.setChildChannelSize(childChannelSize);
				}
			}
		}
		return page;
	}
	
	public synchronized int getMaxChannelNo(String channelType){
		CdbooChannel queryChannel = new CdbooChannel();
		queryChannel.setChannelType(channelType);
		List<CdbooChannel> maxNo = dao.getMaxChannelNo(queryChannel);
		if(CollectionUtils.isNotEmpty(maxNo)){
			CdbooChannel cdbooChannel = maxNo.get(0);
			if(cdbooChannel!=null){
				Integer channelNo = cdbooChannel.getChannelNo();
				if(channelNo!=null){
					return channelNo+1;
				}
			}
		}
		return 1;
	}
	
	@Transactional(readOnly = false)
	public void save(CdbooChannel cdbooChannel) {
		String channelType = cdbooChannel.getChannelType();
		String id = cdbooChannel.getId();
		if(StringUtils.isBlank(id)){
			cdbooChannel.setChannelNo(getMaxChannelNo(channelType));
		}
		super.save(cdbooChannel);
	}
	
	@Transactional(readOnly = false)
	public void delete(CdbooChannel cdbooChannel) {
		super.delete(cdbooChannel);
	}
}