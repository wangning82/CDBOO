/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.userchannel.web.system;

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
import com.cdboo.channel.service.CdbooChannelService;
import com.cdboo.common.Constants;
import com.cdboo.music.entity.CdbooMusic;
import com.cdboo.userchannel.entity.CdbooUserChannel;
import com.cdboo.userchannel.service.CdbooUserChannelService;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 用户频道表Controller
 * 
 * @author yubin
 * @version 2016-12-21
 */
@Controller
@RequestMapping(value = "${adminPath}/userchannel/cdbooUserChannel")
public class CdbooUserChannelController extends BaseController {

	@Autowired
	private CdbooUserChannelService cdbooUserChannelService;

	@Autowired
	private CdbooChannelService cdbooChannelService;

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

	@RequiresPermissions("userchannel:cdbooUserChannel:view")
	@RequestMapping(value = { "list", "" })
	public String list(CdbooUserChannel cdbooUserChannel, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		Page<CdbooUserChannel> page = cdbooUserChannelService
				.findPageForGroupBy(new Page<CdbooUserChannel>(request, response), cdbooUserChannel);
		model.addAttribute("page", page);

		User user = cdbooUserChannel.getUser();
		if (user != null && StringUtils.isNotBlank(user.getId())) {
			List<CdbooChannel> channelList = cdbooUserChannelService.getChannelListByUser(user,Constants.CHANNEL_TYPE_CHILD);
			cdbooUserChannel.setChannelList(channelList);
		}
		return "cdboo/userchannel/system/cdbooUserChannelList";
	}

	@RequiresPermissions("userchannel:cdbooUserChannel:view")
	@RequestMapping(value = "form")
	public String form(CdbooUserChannel cdbooUserChannel, Model model) {
		model.addAttribute("cdbooUserChannel", cdbooUserChannel);
		User user = cdbooUserChannel.getUser();
		CdbooChannel channel = cdbooUserChannel.getChannel();
		if (user != null && StringUtils.isNotBlank(user.getId()) && channel != null
				&& StringUtils.isNotBlank(channel.getId())) {
			/************************
			 * 根据用户检索绑定子频道信息列表 Start
			 ***********************/
			List<CdbooChannel> userChannels = cdbooUserChannelService.getChannelListByUser(user,Constants.CHANNEL_TYPE_CHILD);
			model.addAttribute("channelList", userChannels);
			/************************
			 * 根据用户检索绑定频道信息列表 End
			 ***********************/

			/************************
			 * 根据用户和频道检索绑定音乐信息列表 Start
			 ***********************/
			List<CdbooMusic> musicList = cdbooUserChannelService.getMusicListByUserAndChannel(user, channel);
			model.addAttribute("musicList", musicList);
			/************************
			 * 根据用户和频道检索绑定音乐信息列表 End
			 ***********************/
		} else {
			/************************
			 * 新增时查询所有子频道列表信息返回 Start
			 ***********************/
			List<CdbooChannel> channels = cdbooChannelService.findChildChannelList();
			model.addAttribute("channelList", channels);
			/************************
			 * 新增时查询所有频道列表信息返回 End
			 ***********************/
		}
		return "cdboo/userchannel/system/cdbooUserChannelForm";
	}

	@RequiresPermissions("userchannel:cdbooUserChannel:edit")
	@RequestMapping(value = "save")
	public String save(CdbooUserChannel cdbooUserChannel, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cdbooUserChannel)) {
			return form(cdbooUserChannel, model);
		}
		cdbooUserChannelService.saveUserChannel(cdbooUserChannel);
		addMessage(redirectAttributes, "保存用户频道成功");
		return "redirect:" + Global.getAdminPath() + "/userchannel/cdbooUserChannel/?repage";
	}

	@RequiresPermissions("userchannel:cdbooUserChannel:edit")
	@RequestMapping(value = "delete")
	public String delete(CdbooUserChannel cdbooUserChannel, RedirectAttributes redirectAttributes) {
		cdbooUserChannelService.delete(cdbooUserChannel);
		addMessage(redirectAttributes, "删除用户频道成功");
		return "redirect:" + Global.getAdminPath() + "/userchannel/cdbooUserChannel/?repage";
	}

	@ResponseBody
	@RequestMapping(value = "getChannelList")
	public List<CdbooChannel> getChannelList(@RequestParam(required = false) String userId,
			HttpServletResponse response) {
		User user = new User(userId);
		List<CdbooChannel> channel = cdbooUserChannelService.getChannelListByUser(user,Constants.CHANNEL_TYPE_CHILD);
		return channel;
	}

	@ResponseBody
	@RequestMapping(value = "getMusicList")
	public List<CdbooMusic> getMusicList(@RequestParam(required = false) String userId,
			@RequestParam(required = false) String channelId, HttpServletResponse response) {
		User user = new User(userId);
		CdbooChannel channel = new CdbooChannel(channelId);
		List<CdbooMusic> musicList = cdbooUserChannelService.getMusicListByUserAndChannel(user, channel);
		return musicList;
	}
}