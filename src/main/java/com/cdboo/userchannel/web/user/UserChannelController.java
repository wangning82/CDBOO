package com.cdboo.userchannel.web.user;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.common.Constants;
import com.cdboo.userchannel.entity.CdbooUserChannel;
import com.cdboo.userchannel.service.CdbooUserChannelService;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

@Controller
@RequestMapping(value = "${adminPath}/userchannel/userChannel")
public class UserChannelController extends BaseController {
	
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

	@RequiresPermissions("userchannel:userChannel:view")
	@RequestMapping(value = { "list", "" })
	public String list(CdbooUserChannel cdbooUserChannel, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		User currentUser = UserUtils.getUser();
		cdbooUserChannel.setUser(currentUser);
		
		Page<CdbooUserChannel> page = cdbooUserChannelService
				.findPageForGroupBy(new Page<CdbooUserChannel>(request, response), cdbooUserChannel);
		model.addAttribute("page", page);

		User user = cdbooUserChannel.getUser();
		if (user != null && StringUtils.isNotBlank(user.getId())) {
			List<CdbooChannel> channelList = cdbooUserChannelService.getChannelListByUser(user,Constants.CHANNEL_TYPE_CHILD);
			cdbooUserChannel.setChannelList(channelList);
		}
		return "cdboo/userchannel/user/cdbooUserChannelList";
	}

	@RequiresPermissions("userchannel:userChannel:view")
	@RequestMapping(value = "form")
	public String form(CdbooUserChannel cdbooUserChannel, Model model) {
		model.addAttribute("cdbooUserChannel", cdbooUserChannel);

		User user = UserUtils.getUser();
		cdbooUserChannel.setUser(user);
		
		/************************
		 * 根据用户检索绑定频道信息列表 Start
		 ***********************/
		List<CdbooChannel> userChannels = cdbooUserChannelService.getChannelListByUser(user,Constants.CHANNEL_TYPE_CHILD);
		cdbooUserChannel.setChannelList(userChannels);
		/************************
		 * 根据用户检索绑定频道信息列表 End
		 ***********************/

		return "cdboo/userchannel/user/cdbooUserChannelForm";
	}

	@RequiresPermissions("userchannel:userChannel:edit")
	@RequestMapping(value = "save")
	public String save(CdbooUserChannel cdbooUserChannel, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cdbooUserChannel)) {
			return form(cdbooUserChannel, model);
		}
		cdbooUserChannelService.saveUserChannel(cdbooUserChannel);
		addMessage(redirectAttributes, "保存频道成功");
		return "redirect:" + Global.getAdminPath() + "/userchannel/userChannel/?repage";
	}

	@RequiresPermissions("userchannel:userChannel:edit")
	@RequestMapping(value = "delete")
	public String delete(CdbooUserChannel cdbooUserChannel, RedirectAttributes redirectAttributes) {
		cdbooUserChannelService.delete(cdbooUserChannel);
		addMessage(redirectAttributes, "删除频道成功");
		return "redirect:" + Global.getAdminPath() + "/userchannel/userChannel/?repage";
	}

	@ResponseBody
	@RequestMapping(value = "getChannelList")
	public List<CdbooChannel> getChannelList(@RequestParam(required = false) String userId,
			HttpServletResponse response) {
		User user = new User(userId);
		List<CdbooChannel> channel = cdbooUserChannelService.getChannelListByUser(user,Constants.CHANNEL_TYPE_CHILD);
		return channel;
	}
}
