/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.channel.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.channel.dao.CdbooChannelDao;

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
	
	public Page<CdbooChannel> findPage(Page<CdbooChannel> page, CdbooChannel cdbooChannel) {
		return super.findPage(page, cdbooChannel);
	}
	
	@Transactional(readOnly = false)
	public void save(CdbooChannel cdbooChannel) {
		super.save(cdbooChannel);
	}
	
	@Transactional(readOnly = false)
	public void delete(CdbooChannel cdbooChannel) {
		super.delete(cdbooChannel);
	}
	
}