/**
 * 
 */
package com.cdboo.usergroup.web.system;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.cdboo.common.Constants;
import com.cdboo.userchannel.entity.CdbooUserChannel;
import com.cdboo.userchannel.service.CdbooUserChannelService;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

import jersey.repackaged.com.google.common.collect.Lists;

/**
 * @author yubin
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/channel/groupChannel/user")
public class CdbooUserGroupChannelController extends BaseController {

	@Autowired
	private CdbooChannelService cdbooChannelService;
	
	@Autowired
	private CdbooUserChannelService cdbooUserChannelService;
	
	@ModelAttribute
	public CdbooUserChannel get(@RequestParam(required = false) String id) {
		CdbooUserChannel entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = cdbooUserChannelService.get(id);
		}
		if (entity == null) {
			entity = new CdbooUserChannel();
		}
		return entity;
	}

	@RequiresPermissions("channel:groupChannel:user:view")
	@RequestMapping(value = { "list", "" })
	public String list(CdbooUserChannel userChannel, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		userChannel.setChannelType(Constants.CHANNEL_TYPE_GROUP);
		Page<CdbooUserChannel> page = cdbooUserChannelService.findPageForGroupBy(new Page<CdbooUserChannel>(request, response),
				userChannel);
		model.addAttribute("page", page);

		/**************** 组合频道下拉列表集合查询 Start ******************/
		CdbooChannel cdbooChannel = new CdbooChannel();
		cdbooChannel.setChannelType(Constants.CHANNEL_TYPE_GROUP);
		List<CdbooChannel> groupList = cdbooChannelService.findList(cdbooChannel);
		userChannel.setChannelList(groupList);
		/**************** 组合频道下拉列表集合查询 End ******************/
		
		return "cdboo/groupChannel/system/cdbooUserGroupChannelList";
	}
	
	@RequiresPermissions("channel:groupChannel:user:view")
	@RequestMapping(value = "form")
	public String form(CdbooUserChannel userChannel, Model model, HttpServletRequest request) {
		model.addAttribute("userChannel", userChannel);
		
		User user = userChannel.getUser();
		
		if (userChannel != null && StringUtils.isNotBlank(userChannel.getId())) {
			String id = user.getId();
			user = UserUtils.get(id);
			userChannel.setUser(user);
			
			String channelId = userChannel.getChannel().getId();
			CdbooChannel cdbooChannel = cdbooChannelService.get(channelId);
			List<CdbooChannel> channelList = Lists.newArrayList();
			channelList.add(cdbooChannel);
			
			userChannel.setChannelList(channelList);
			
//			userChannel.setChannel(cdbooChannel);
//			
//			/**************** 查询组合频道下子频道列表 Start ******************/
//			CdbooGroupChild cdbooGroupChild2 = new CdbooGroupChild();
//			cdbooGroupChild2.setGroupChannelId(userChannel.getChannel());
//			List<CdbooGroupChild> groupChildList = groupChildService.findList(cdbooGroupChild2);
//			userChannel.setGroupChildChannelList(groupChildList);
//			/**************** 查询组合频道下子频道列表 End ******************/
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
	public String save(CdbooUserChannel userChannel, Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request) {
		cdbooUserChannelService.saveUserGroupChannel(userChannel);
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
	public String delete(CdbooUserChannel userChannel, Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request) {
		cdbooUserChannelService.remove(userChannel);
		addMessage(redirectAttributes, "删除用户组合频道信息成功");
		return "redirect:" + Global.getAdminPath() + "/channel/groupChannel/user/?repage";
	}
}
