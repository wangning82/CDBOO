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

/**
 * @author yubin
 *
 */
@Service
@Transactional(readOnly = true)
public class CdbooGroupChildService extends CrudService<CdbooGroupChildDao, CdbooGroupChild> {

	@Autowired
	private CdbooChannelService cdbooChannelService;

	/**
	 * 按照用户和频道进行分组查询组合频道中间表，并分页
	 * 
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
				String id = groupChannelId.getId();
				CdbooChannel cdbooChannel = cdbooChannelService.get(id);
				cdbooGroupChild2.setGroupChannelId(cdbooChannel);
			}
		}
		return page;
	}

	/**
	 * 根据查询条件获取组合频道列表
	 * 
	 * @param cdbooGroupChild
	 * @return
	 */
	public List<CdbooChannel> findChildChannelListByConditions(CdbooGroupChild cdbooGroupChild) {
		List<CdbooGroupChild> list = super.findList(cdbooGroupChild);
		return convertGroupChannelToChannel(list);
	}

	public List<CdbooChannel> convertGroupChannelToChannel(List<CdbooGroupChild> list) {
		List<CdbooChannel> channelList = Lists.newArrayList();
		if (CollectionUtils.isNotEmpty(list)) {
			for (CdbooGroupChild cdbooGroupChild2 : list) {
				CdbooChannel childChannel = cdbooGroupChild2.getChildChannelId();
				String id = childChannel.getId();
				CdbooChannel cdbooChannel = cdbooChannelService.get(id);
				channelList.add(cdbooChannel);
			}
		}

		return channelList;
	}

	@Transactional(readOnly = false)
	public void delete(CdbooGroupChild cdbooGroupChild) {
		CdbooChannel groupChannel = cdbooGroupChild.getGroupChannelId();
		cdbooChannelService.delete(groupChannel);

		List<CdbooGroupChild> list = super.findList(cdbooGroupChild);
		if (CollectionUtils.isNotEmpty(list)) {
			for (CdbooGroupChild removeObj : list) {
				dao.remove(removeObj);
			}
		}
	}

	@Transactional(readOnly = false)
	public void save(CdbooGroupChild cdbooGroupChild) {
		CdbooChannel groupChannel = cdbooGroupChild.getGroupChannelId();
		cdbooChannelService.save(groupChannel);

		List<String> channelIds = cdbooGroupChild.getChannelIds();
		List<Integer> sorts = cdbooGroupChild.getSorts();

		CdbooGroupChild cdbooGroupChild2 = new CdbooGroupChild();
		cdbooGroupChild2.setGroupChannelId(groupChannel);

		List<CdbooGroupChild> list = dao.findList(cdbooGroupChild2);
		Map<String, CdbooGroupChild> map = Maps.newHashMap();
		if (CollectionUtils.isNotEmpty(list)) {
			for (CdbooGroupChild querObj : list) {
				map.put(querObj.getChildChannelId().getId(), querObj);
			}
		}

		List<CdbooGroupChild> saveList = Lists.newArrayList();
		if (CollectionUtils.isNotEmpty(channelIds)) {
			for (int i = 0; i < channelIds.size(); i++) {
				String channelId = channelIds.get(i);
				Integer sort = sorts.get(i);
				CdbooGroupChild child = null;
				if ((child = map.remove(channelId)) == null) {
					CdbooChannel cdbooChannel = cdbooChannelService.get(channelId);
					child = new CdbooGroupChild(groupChannel, cdbooChannel, sort);
					saveList.add(child);
				}
				else{
					child.setSort(sort);
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
