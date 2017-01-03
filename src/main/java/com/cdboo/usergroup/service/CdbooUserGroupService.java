package com.cdboo.usergroup.service;

import java.util.List;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.channel.service.CdbooChannelService;
import com.cdboo.usergroup.dao.CdbooUserGroupDao;
import com.cdboo.usergroup.entity.CdbooUserGroup;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;

import jersey.repackaged.com.google.common.collect.Lists;

/**
 * Created by mmzz on 2017/1/3.
 */
@Service
@Transactional(readOnly = true)
public class CdbooUserGroupService extends CrudService<CdbooUserGroupDao, CdbooUserGroup> {
	
	@Autowired
	private CdbooChannelService channelService;
	
	public List<CdbooChannel> convertUserGroupToChannel(List<CdbooUserGroup> cdbooUserGroups) {
		List<CdbooChannel> cdbooChannels = Lists.newArrayList();
		if (CollectionUtils.isNotEmpty(cdbooUserGroups)) {
			for (CdbooUserGroup cdbooUserGroup : cdbooUserGroups) {
				CdbooChannel cdbooChannel = cdbooUserGroup.getCdbooChannel();
				if (cdbooChannel != null && StringUtils.isNotBlank(cdbooChannel.getId())) {
					CdbooChannel channel = channelService.get(cdbooChannel.getId());
					cdbooChannels.add(channel);
				}
			}
		}

		return cdbooChannels;
	}		
}
