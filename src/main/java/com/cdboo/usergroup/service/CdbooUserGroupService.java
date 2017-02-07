package com.cdboo.usergroup.service;

import java.util.List;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.channel.service.CdbooChannelService;
import com.cdboo.childchannel.entity.CdbooGroupChild;
import com.cdboo.childchannel.service.CdbooGroupChildService;
import com.cdboo.common.Constants;
import com.cdboo.userchannel.entity.CdbooUserChannel;
import com.cdboo.userchannel.service.CdbooUserChannelService;
import com.cdboo.usergroup.dao.CdbooUserGroupDao;
import com.cdboo.usergroup.entity.CdbooUserGroup;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

import jersey.repackaged.com.google.common.collect.Lists;

/**
 * Created by mmzz on 2017/1/3.
 */
@Service
@Transactional(readOnly = true)
public class CdbooUserGroupService extends CrudService<CdbooUserGroupDao, CdbooUserGroup> {

	@Autowired
	private CdbooChannelService channelService;

	@Autowired
	private CdbooGroupChildService groupChildService;

	@Autowired
	private CdbooUserChannelService cdbooUserChannelService;

	public List<CdbooChannel> getGroupChannelListByUser(User user) {
		CdbooUserGroup cdbooUserGroup = new CdbooUserGroup();
		cdbooUserGroup.setUser(user);
		List<CdbooUserGroup> list = this.findList(cdbooUserGroup);
		return convertUserGroupToChannel(list);
	}
	
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

	@Override
	public Page<CdbooUserGroup> findPage(Page<CdbooUserGroup> page, CdbooUserGroup cdbooUserGroup) {
		Page<CdbooUserGroup> findPage = super.findPage(page, cdbooUserGroup);
		List<CdbooUserGroup> list = findPage.getList();
		if (CollectionUtils.isNotEmpty(list)) {
			for (CdbooUserGroup userGroup : list) {
				User user = userGroup.getUser();
				CdbooChannel cdbooChannel = userGroup.getCdbooChannel();

				user = UserUtils.get(user.getId());
				userGroup.setUser(user);

				String channelId = cdbooChannel.getId();
				cdbooChannel = channelService.get(channelId);
				userGroup.setCdbooChannel(cdbooChannel);

				CdbooGroupChild cdbooGroupChild = new CdbooGroupChild();
				cdbooGroupChild.setGroupChannelId(cdbooChannel);
				List<CdbooGroupChild> groupChildList = groupChildService.findList(cdbooGroupChild);
				if (CollectionUtils.isNotEmpty(groupChildList)) {
					userGroup.setChildChannelSize(groupChildList.size());
				}
			}
		}
		return page;
	}

	/**
	 * 保存用户和组合频道的关联关系，这里只跟组合频道关联，而不关心他下面的子频道，如果用的话去groupchild表取即可
	 * @param userChannel
	 */
	@Transactional(readOnly = false)
	public void saveUserGroup(CdbooUserChannel userChannel) {
		List<CdbooUserChannel> userChannelList = cdbooUserChannelService.findList(userChannel);
		if(CollectionUtils.isEmpty(userChannelList)){
			userChannel.setChannelType(Constants.CHANNEL_TYPE_GROUP);
			cdbooUserChannelService.save(userChannel);
		}
	}

	@Transactional(readOnly = false)
	public void deleteUserGroup(CdbooUserChannel userChannel) {
		cdbooUserChannelService.remove(userChannel);
	}
}
