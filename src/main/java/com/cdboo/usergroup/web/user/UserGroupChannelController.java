/**
 * 
 */
package com.cdboo.usergroup.web.user;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.collections.CollectionUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.channel.service.CdbooChannelService;
import com.cdboo.childchannel.entity.CdbooGroupChild;
import com.cdboo.childchannel.service.CdbooGroupChildService;
import com.cdboo.common.Constants;
import com.cdboo.usergroup.entity.CdbooUserGroup;
import com.cdboo.usergroup.service.CdbooUserGroupService;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * @author yubin
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/channel/groupChannel/front/user")
public class UserGroupChannelController extends BaseController {
	
	@Autowired
	private CdbooUserGroupService cdbooUserGroupService;
	
	@Autowired
	private CdbooChannelService cdbooChannelService;
	
	@Autowired
	private CdbooGroupChildService groupChildService;
	
	@ModelAttribute
	public CdbooUserGroup get(@RequestParam(required = false) String id) {
		CdbooUserGroup entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = cdbooUserGroupService.get(id);
		}
		if (entity == null) {
			entity = new CdbooUserGroup();
		}
		return entity;
	}

	@RequiresPermissions("channel:groupChannel:user:front:view")
	@RequestMapping(value = { "list", "" })
	public String list(CdbooUserGroup userGroup, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		User user = UserUtils.getUser();
		userGroup.setUser(user);
		
		Page<CdbooUserGroup> page = cdbooUserGroupService.findPage(new Page<CdbooUserGroup>(request, response),
				userGroup);
		model.addAttribute("page", page);

		/**************** 组合频道下拉列表集合查询 Start ******************/
		CdbooChannel cdbooChannel = new CdbooChannel();
		cdbooChannel.setChannelType(Constants.CHANNEL_TYPE_GROUP);
		List<CdbooChannel> groupList = cdbooChannelService.findList(cdbooChannel);
		userGroup.setChannelList(groupList);
		/**************** 组合频道下拉列表集合查询 End ******************/
		
		return "cdboo/groupChannel/user/userGroupChannelList";
	}
	
	@RequiresPermissions("channel:groupChannel:user:front:view")
	@RequestMapping(value = "form")
	public String form(CdbooUserGroup userGroup, Model model, HttpServletRequest request) {

		CdbooChannel channel = userGroup.getCdbooChannel();
		User user = userGroup.getUser();
		
		String id = user.getId();
		user = UserUtils.get(id);
		userGroup.setUser(user);
		
		String channelId = channel.getId();
		channel = cdbooChannelService.get(channelId);
		userGroup.setCdbooChannel(channel);
		
		/**************** 查询用户的组合频道 Start ******************/
		List<CdbooUserGroup> groupList = cdbooUserGroupService.findList(userGroup);
		if(CollectionUtils.isNotEmpty(groupList)){
			CdbooUserGroup cdbooUserGroup = groupList.get(0);
			model.addAttribute("userGroup", cdbooUserGroup);
		}
		else{
			model.addAttribute("userGroup", userGroup);
		}
		/**************** 查询用户的组合频道 End ******************/
		
		/**************** 查询组合频道下子频道列表 Start ******************/
		CdbooGroupChild cdbooGroupChild2 = new CdbooGroupChild();
		cdbooGroupChild2.setGroupChannelId(channel);
		List<CdbooGroupChild> groupChildList = groupChildService.findList(cdbooGroupChild2);
		userGroup.setGroupChildList(groupChildService.convertGroupChannelToChannel(groupChildList));
		/**************** 查询组合频道下子频道列表 End ******************/

		return "cdboo/groupChannel/user/userGroupChannelForm";
	}
	
}
