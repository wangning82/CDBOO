/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.channel.service;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cdboo.channel.dao.CdbooChannelDao;
import com.cdboo.channel.entity.CdbooChannel;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;

/**
 * 频道管理Service
 * @author 于滨
 * @version 2016-12-17
 */
@Service
@Transactional(readOnly = true)
public class CdbooChannelService extends CrudService<CdbooChannelDao, CdbooChannel> {

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
		return super.findPage(page, cdbooChannel);
	}
	
	public synchronized int getMaxChannelNo(){
		List<CdbooChannel> maxNo = dao.getMaxChannelNo();
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
		cdbooChannel.setChannelNo(getMaxChannelNo());
		super.save(cdbooChannel);
	}
	
	@Transactional(readOnly = false)
	public void delete(CdbooChannel cdbooChannel) {
		super.delete(cdbooChannel);
	}
	
	public Page<CdbooChannel> findPageByUserId(Page<CdbooChannel> page, CdbooChannel cdbooChannel) {
		cdbooChannel.setPage(page);
		List<CdbooChannel> list = dao.findPageByUserId(cdbooChannel);
		page.setList(list);
		return page;
	}
	
}