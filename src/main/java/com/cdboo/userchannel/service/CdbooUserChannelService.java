/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.userchannel.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cdboo.userchannel.entity.CdbooUserChannel;
import com.cdboo.userchannel.dao.CdbooUserChannelDao;

/**
 * 用户频道表Service
 * @author yubin
 * @version 2016-12-21
 */
@Service
@Transactional(readOnly = true)
public class CdbooUserChannelService extends CrudService<CdbooUserChannelDao, CdbooUserChannel> {

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
	
}