/**
 * 
 */
package com.cdboo.childchannel.web;

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
import com.cdboo.childchannel.entity.CdbooGroupChild;
import com.cdboo.childchannel.service.CdbooGroupChildService;
import com.cdboo.common.Constants;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;

/**
 * 组合频道管理
 * @author yubin
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/channel/groupChannel")
public class CdbooGroupChannelController extends BaseController {

	@Autowired
	private CdbooChannelService cdbooChannelService;

	@Autowired
	private CdbooGroupChildService cdbooGroupChildService;

	@ModelAttribute
	public CdbooChannel get(@RequestParam(required = false) String id) {
		CdbooChannel entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = cdbooChannelService.get(id);
		}
		if (entity == null) {
			entity = new CdbooChannel();
		}
		return entity;
	}

	@RequiresPermissions("channel:groupChannel:view")
	@RequestMapping(value = { "list", "" })
	public String list(CdbooChannel cdbooChannel, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		cdbooChannel.setChannelType(Constants.CHANNEL_TYPE_GROUP);
		Page<CdbooChannel> page = cdbooChannelService.findPage(new Page<CdbooChannel>(request, response), cdbooChannel);
		model.addAttribute("page", page);

		/**************** 组合频道下拉列表集合查询 Start ******************/
		CdbooChannel querySelectObj = new CdbooChannel();
		querySelectObj.setChannelType(Constants.CHANNEL_TYPE_GROUP);
		List<CdbooChannel> groupList = cdbooChannelService.findList(querySelectObj);
		cdbooChannel.setChildChannelList(groupList);
		/**************** 组合频道下拉列表集合查询 End ******************/
		
		return "cdboo/groupChannel/system/cdbooChannelList";
	}

	@RequiresPermissions("channel:groupChannel:view")
	@RequestMapping(value = "form")
	public String form(CdbooChannel cdbooChannel, Model model, HttpServletRequest request) {
		model.addAttribute("cdbooChannel", cdbooChannel);

		if (cdbooChannel != null && StringUtils.isNotBlank(cdbooChannel.getId())) {
			
			/**************** 转换组合频道子频道中间表列表为频道列表 Start ******************/
			CdbooGroupChild cdbooGroupChild2 = new CdbooGroupChild();
			cdbooGroupChild2.setGroupChannelId(cdbooChannel);
			List<CdbooGroupChild> groupChildList = cdbooGroupChildService.findList(cdbooGroupChild2);
			List<CdbooChannel> groupChildChannelList = cdbooGroupChildService
					.convertGroupChannelToChannel(groupChildList);
			/**************** 转换组合频道子频道中间表列表为频道列表 End ******************/
			cdbooChannel.setChildChannelList(groupChildChannelList);
		}

		return "cdboo/groupChannel/system/cdbooChannelForm";
	}

	/**
	 * 编辑功能
	 * @param cdbooGroupChild
	 * @param model
	 * @param redirectAttributes
	 * @param request
	 * @return
	 */
	@RequiresPermissions("channel:groupChannel:edit")
	@RequestMapping(value = "save")
	public String save(CdbooChannel cdbooChannel, Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request) {
		if (!beanValidator(model, cdbooChannel)) {
			return form(cdbooChannel, model, request);
		}
		cdbooGroupChildService.save(cdbooChannel);
		addMessage(redirectAttributes, "保存频道信息成功");
		return "redirect:" + Global.getAdminPath() + "/channel/groupChannel/?repage";
	}

	/**
	 * 删除功能
	 * @param cdbooGroupChild
	 * @param model
	 * @param redirectAttributes
	 * @param request
	 * @return
	 */
	@RequiresPermissions("channel:groupChannel:edit")
	@RequestMapping(value = "delete")
	public String delete(CdbooChannel cdbooChannel, Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request) {
		cdbooGroupChildService.delete(cdbooChannel);
		addMessage(redirectAttributes, "删除频道信息成功");
		return "redirect:" + Global.getAdminPath() + "/channel/groupChannel/?repage";
	}

	/**
	 * 组合频道id查询子频道列表
	 * @param groupChildId
	 * @return
	 */
	@RequestMapping(value = "getGroupChannelList")
	@ResponseBody
	public List<CdbooChannel> getGroupChannelList(@RequestParam(required = true) String groupChildId) {

		CdbooChannel groupChannel = new CdbooChannel(groupChildId);
		CdbooGroupChild cdbooGroupChild2 = new CdbooGroupChild();
		cdbooGroupChild2.setGroupChannelId(groupChannel);

		List<CdbooGroupChild> groupChildList = cdbooGroupChildService.findList(cdbooGroupChild2);
		List<CdbooChannel> channelList = cdbooGroupChildService.convertGroupChannelToChannel(groupChildList);

		return channelList;
	}
}
