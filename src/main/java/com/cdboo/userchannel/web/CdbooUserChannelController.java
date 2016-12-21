/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.userchannel.web;

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

import com.cdboo.userchannel.entity.CdbooUserChannel;
import com.cdboo.userchannel.service.CdbooUserChannelService;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;

/**
 * 用户频道表Controller
 * @author yubin
 * @version 2016-12-21
 */
@Controller
@RequestMapping(value = "${adminPath}/userchannel/cdbooUserChannel")
public class CdbooUserChannelController extends BaseController {

	@Autowired
	private CdbooUserChannelService cdbooUserChannelService;
	
	@ModelAttribute
	public CdbooUserChannel get(@RequestParam(required=false) String id) {
		CdbooUserChannel entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cdbooUserChannelService.get(id);
		}
		if (entity == null){
			entity = new CdbooUserChannel();
		}
		return entity;
	}
	
	@RequiresPermissions("userchannel:cdbooUserChannel:view")
	@RequestMapping(value = {"list", ""})
	public String list(CdbooUserChannel cdbooUserChannel, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CdbooUserChannel> page = cdbooUserChannelService.findPageForGroupBy(new Page<CdbooUserChannel>(request, response), cdbooUserChannel); 
		model.addAttribute("page", page);
		return "cdboo/userchannel/cdbooUserChannelList";
	}

	@RequiresPermissions("userchannel:cdbooUserChannel:view")
	@RequestMapping(value = "form")
	public String form(CdbooUserChannel cdbooUserChannel, Model model) {
		model.addAttribute("cdbooUserChannel", cdbooUserChannel);
		return "cdboo/userchannel/cdbooUserChannelForm";
	}

	@RequiresPermissions("userchannel:cdbooUserChannel:edit")
	@RequestMapping(value = "save")
	public String save(CdbooUserChannel cdbooUserChannel, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cdbooUserChannel)){
			return form(cdbooUserChannel, model);
		}
		cdbooUserChannelService.save(cdbooUserChannel);
		addMessage(redirectAttributes, "保存用户频道成功");
		return "redirect:"+Global.getAdminPath()+"/userchannel/cdbooUserChannel/?repage";
	}
	
	@RequiresPermissions("userchannel:cdbooUserChannel:edit")
	@RequestMapping(value = "delete")
	public String delete(CdbooUserChannel cdbooUserChannel, RedirectAttributes redirectAttributes) {
		cdbooUserChannelService.delete(cdbooUserChannel);
		addMessage(redirectAttributes, "删除用户频道成功");
		return "redirect:"+Global.getAdminPath()+"/userchannel/cdbooUserChannel/?repage";
	}
	
	@RequiresPermissions("business:business:view")
	@ResponseBody
	@RequestMapping(value = "getChannelList")
	public List<CdbooUserChannel> getChannelList(@RequestParam(required=false) String userId, HttpServletResponse response) {
		List<CdbooUserChannel> channel = cdbooUserChannelService.getChannelListByUser(userId);
		return channel;
	}

}