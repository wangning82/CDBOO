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

	@Transactional(readOnly = false)
	public void saveUserGroup(CdbooUserGroup cdbooUserGroup) {
		User user = cdbooUserGroup.getUser();
		CdbooChannel cdbooChannel = cdbooUserGroup.getCdbooChannel();

		List<CdbooUserGroup> userGroupList = super.findList(cdbooUserGroup);
		if (CollectionUtils.isEmpty(userGroupList)) {
			super.save(cdbooUserGroup);
		}

		/***** 根据组合频道查询子频道列表 Start *****/
		CdbooGroupChild cdbooGroupChild = new CdbooGroupChild();
		cdbooGroupChild.setGroupChannelId(cdbooChannel);
		List<CdbooGroupChild> list = groupChildService.findList(cdbooGroupChild);
		/***** 根据组合频道查询子频道列表 End *****/

		if (CollectionUtils.isNotEmpty(list)) {

			/***** 为查询用户是否存在子频道关联创建查询对象 Start *****/
			CdbooUserChannel cdbooUserChannel = new CdbooUserChannel();
			cdbooUserChannel.setUser(user);
			/***** 为查询用户是否存在子频道关联创建查询对象 End *****/

			for (CdbooGroupChild child : list) {

				/***** 查询用户和子频道关联对象 Start *****/
				CdbooChannel childChannel = child.getChildChannelId();
				cdbooUserChannel.setChannel(childChannel);
				List<CdbooUserChannel> userChannelList = cdbooUserChannelService.findList(cdbooUserChannel);
				/***** 查询用户和子频道关联对象 End *****/

				if (CollectionUtils.isEmpty(userChannelList)) {
					/***** 查询用户和子频道关联对象，如果不存在关联，则创建关联 Start *****/
					CdbooUserChannel saveUserChannel = new CdbooUserChannel();
					saveUserChannel.setChannel(childChannel);
					saveUserChannel.setUser(user);
					cdbooUserChannelService.save(saveUserChannel);
					/***** 查询用户和子频道关联对象，如果不存在关联，则创建关联 End *****/
				}
			}
		}
	}

	@Transactional(readOnly = false)
	public void deleteUserGroup(CdbooUserGroup cdbooUserGroup) {
		User user = cdbooUserGroup.getUser();
		CdbooChannel cdbooChannel = cdbooUserGroup.getCdbooChannel();

		List<CdbooUserGroup> userGroupList = super.findList(cdbooUserGroup);
		if (CollectionUtils.isNotEmpty(userGroupList)) {
			for (CdbooUserGroup delUserGroup : userGroupList) {
				dao.remove(delUserGroup);
			}
		}

		/***** 根据组合频道查询子频道列表 Start *****/
		CdbooGroupChild cdbooGroupChild = new CdbooGroupChild();
		cdbooGroupChild.setGroupChannelId(cdbooChannel);
		List<CdbooGroupChild> list = groupChildService.findList(cdbooGroupChild);
		/***** 根据组合频道查询子频道列表 End *****/

		if (CollectionUtils.isNotEmpty(list)) {

			/***** 为查询用户是否存在子频道关联创建查询对象 Start *****/
			CdbooUserChannel cdbooUserChannel = new CdbooUserChannel();
			cdbooUserChannel.setUser(user);
			/***** 为查询用户是否存在子频道关联创建查询对象 End *****/

			for (CdbooGroupChild child : list) {

				/***** 查询用户和子频道关联对象 Start *****/
				CdbooChannel childChannel = child.getChildChannelId();
				cdbooUserChannel.setChannel(childChannel);
				List<CdbooUserChannel> userChannelList = cdbooUserChannelService.findList(cdbooUserChannel);
				/***** 查询用户和子频道关联对象 End *****/

				if (CollectionUtils.isNotEmpty(userChannelList)) {
					for (CdbooUserChannel delUserChannelObj : userChannelList) {
						cdbooUserChannelService.remove(delUserChannelObj);
					}
				}
			}
		}
	}
}
