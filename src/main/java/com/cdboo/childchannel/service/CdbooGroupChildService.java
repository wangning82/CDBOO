/**
 * 
 */
package com.cdboo.childchannel.service;

import java.util.List;
import java.util.Map;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.channel.service.CdbooChannelService;
import com.cdboo.childchannel.dao.CdbooGroupChildDao;
import com.cdboo.childchannel.entity.CdbooGroupChild;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * @author yubin
 *
 */
@Service
@Transactional(readOnly=true)
public class CdbooGroupChildService extends CrudService<CdbooGroupChildDao, CdbooGroupChild> {
	
	@Autowired
	private CdbooChannelService cdbooChannelService;
	
	/**
	 * 按照用户和频道进行分组查询组合频道中间表，并分页
	 * @param page
	 * @param cdbooGroupChild
	 * @return
	 */
	public Page<CdbooGroupChild> findGroupList(Page<CdbooGroupChild> page, CdbooGroupChild cdbooGroupChild) {
		cdbooGroupChild.setPage(page);
		List<CdbooGroupChild> list = dao.findGroupList(cdbooGroupChild);
		page.setList(list);
		if (CollectionUtils.isNotEmpty(list)) {
			for (CdbooGroupChild cdbooGroupChild2 : list) {
				CdbooChannel groupChannelId = cdbooGroupChild2.getGroupChannelId();
				User userId = cdbooGroupChild2.getUserId();

				String id = groupChannelId.getId();
				CdbooChannel cdbooChannel = cdbooChannelService.get(id);
				cdbooGroupChild2.setGroupChannelId(cdbooChannel);

				User user = UserUtils.get(userId.getId());
				cdbooGroupChild2.setUserId(user);
			}
		}
		return page;
	}
	
	/**
	 * 根据用户id获取组合频道列表
	 * @param cdbooGroupChild
	 * @return
	 */
	public List<CdbooChannel> findGroupChannelListByUserid(CdbooGroupChild cdbooGroupChild) {
		List<CdbooGroupChild> list = dao.findGroupListByUserid(cdbooGroupChild);
		return convertGroupChannelToChannel(list);
	}
	
	/**
	 * 根据查询条件获取组合频道列表
	 * @param cdbooGroupChild
	 * @return
	 */
	public List<CdbooChannel> findChildChannelListByConditions(CdbooGroupChild cdbooGroupChild) {
		List<CdbooGroupChild> list = super.findList(cdbooGroupChild);
		return convertGroupChannelToChannel(list);
	}
	
	public List<CdbooChannel> convertGroupChannelToChannel(List<CdbooGroupChild> list){
		List<CdbooChannel> channelList = Lists.newArrayList();
		if (CollectionUtils.isNotEmpty(list)) {
			for (CdbooGroupChild cdbooGroupChild2 : list) {
				CdbooChannel groupChannelId = cdbooGroupChild2.getGroupChannelId();
				String id = groupChannelId.getId();
				CdbooChannel cdbooChannel = cdbooChannelService.get(id);
				channelList.add(cdbooChannel);
			}
		}
		
		return channelList;
	}
	
	@Transactional(readOnly=false)
	public void save(CdbooGroupChild cdbooGroupChild) {
		CdbooChannel groupChannel = cdbooGroupChild.getGroupChannelId();
		cdbooChannelService.save(groupChannel);

		List<String> channelIds = cdbooGroupChild.getChannelIds();

		List<CdbooGroupChild> list = dao.findGroupListByUserid(cdbooGroupChild);
		Map<String, CdbooGroupChild> map = Maps.newHashMap();
		if (CollectionUtils.isNotEmpty(list)) {
			for (CdbooGroupChild querObj : list) {
				map.put(querObj.getChildChannelId().getId(), querObj);
			}
		}

		List<CdbooGroupChild> saveList = Lists.newArrayList();
		if (CollectionUtils.isNotEmpty(channelIds)) {
			User user = cdbooGroupChild.getUserId();
			for (String channelId : channelIds) {
				CdbooGroupChild child = null;
				if ((child = map.remove(channelId)) == null) {
					CdbooChannel cdbooChannel = cdbooChannelService.get(channelId);
					child = new CdbooGroupChild(user, groupChannel, cdbooChannel);
					saveList.add(child);
				}
			}
		}

		List<CdbooGroupChild> delList = Lists.newArrayList();
		if (MapUtils.isNotEmpty(map)) {
			delList.addAll(map.values());
		}

		if (CollectionUtils.isNotEmpty(saveList)) {
			for (CdbooGroupChild saveObj : saveList) {
				super.save(saveObj);
			}
		}

		if (CollectionUtils.isNotEmpty(delList)) {
			for (CdbooGroupChild delObj : delList) {
				dao.remove(delObj);
			}
		}
	}
}
