/**
 * 
 */
package com.cdboo.childchannel.service;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.childchannel.dao.CdbooGroupChildDao;
import com.cdboo.childchannel.entity.CdbooGroupChild;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.service.CrudService;

/**
 * @author yubin
 *
 */
@Service
@Transactional(readOnly=true)
public class CdbooGroupChildService extends CrudService<CdbooGroupChildDao, CdbooGroupChild> {
	public List<CdbooChannel> findCdbooChannelFromGroupChannel(CdbooGroupChild cdbooGroupChild) {
		List<CdbooGroupChild> list = super.findList(cdbooGroupChild);
		List<CdbooChannel> channelList = Lists.newArrayList();
		if (CollectionUtils.isNotEmpty(list)) {
			for (CdbooGroupChild cdbooGroupChild2 : list) {
				channelList.add(cdbooGroupChild2.getChildChannelId());
			}
		}
		return channelList;
	}
}
