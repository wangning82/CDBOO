/**
 * 
 */
package com.cdboo.usergroup.web.system;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.channel.service.CdbooChannelService;
import com.cdboo.childchannel.entity.CdbooGroupChild;
import com.cdboo.childchannel.service.CdbooGroupChildService;
import com.cdboo.common.Constants;
import com.cdboo.usergroup.entity.CdbooUserGroup;
import com.cdboo.usergroup.service.CdbooUserGroupService;
import com.thinkgem.jeesite.common.config.Global;
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
@RequestMapping(value = "${adminPath}/channel/groupChannel/user")
public class CdbooUserGroupChannelController extends BaseController {
	
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

	@RequiresPermissions("channel:groupChannel:user:view")
	@RequestMapping(value = { "list", "" })
	public String list(CdbooUserGroup userGroup, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		
		Page<CdbooUserGroup> page = cdbooUserGroupService.findPage(new Page<CdbooUserGroup>(request, response),
				userGroup);
		model.addAttribute("page", page);

		/**************** 组合频道下拉列表集合查询 Start ******************/
		CdbooChannel cdbooChannel = new CdbooChannel();
		cdbooChannel.setChannelType(Constants.CHANNEL_TYPE_GROUP);
		List<CdbooChannel> groupList = cdbooChannelService.findList(cdbooChannel);
		userGroup.setChannelList(groupList);
		/**************** 组合频道下拉列表集合查询 End ******************/
		
		return "cdboo/groupChannel/system/cdbooUserGroupChannelList";
	}
	
	@RequiresPermissions("channel:groupChannel:user:view")
	@RequestMapping(value = "form")
	public String form(CdbooUserGroup userGroup, Model model, HttpServletRequest request) {

		CdbooChannel channel = userGroup.getCdbooChannel();
		User user = userGroup.getUser();
		
		if (channel != null && StringUtils.isNotBlank(channel.getId())&&user != null && StringUtils.isNotBlank(user.getId())) {
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
		}
		else{
			model.addAttribute("userGroup", userGroup);
			List<CdbooChannel> groupChannelList = cdbooChannelService.findGroupChannelList();
			userGroup.setChannelList(groupChannelList);
		}

		return "cdboo/groupChannel/system/cdbooUserGroupChannelForm";
	}
	
	/**
	 * 编辑功能
	 * @param cdbooGroupChild
	 * @param model
	 * @param redirectAttributes
	 * @param request
	 * @return
	 */
	@RequiresPermissions("channel:groupChannel:user:edit")
	@RequestMapping(value = "save")
	public String save(CdbooUserGroup cdbooUserGroup, Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request) {
		cdbooUserGroupService.saveUserGroup(cdbooUserGroup);
		addMessage(redirectAttributes, "保存用户组合频道信息成功");
		return "redirect:" + Global.getAdminPath() + "/channel/groupChannel/user/?repage";
	}

	/**
	 * 删除功能
	 * @param cdbooGroupChild
	 * @param model
	 * @param redirectAttributes
	 * @param request
	 * @return
	 */
	@RequiresPermissions("channel:groupChannel:user:edit")
	@RequestMapping(value = "delete")
	public String delete(CdbooUserGroup cdbooUserGroup, Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request) {
		cdbooUserGroupService.deleteUserGroup(cdbooUserGroup);
		addMessage(redirectAttributes, "删除用户组合频道信息成功");
		return "redirect:" + Global.getAdminPath() + "/channel/groupChannel/user/?repage";
	}
	
	
}