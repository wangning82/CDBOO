/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.userplan.web;

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
import com.cdboo.timestep.entity.Timestep;
import com.cdboo.timestep.service.TimestepService;
import com.cdboo.userplan.entity.CdbooPlan;
import com.cdboo.userplan.model.PlanModel;
import com.cdboo.userplan.service.CdbooPlanService;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;

/**
 * 用户计划表Controller
 * @author yubin
 * @version 2016-12-21
 */
@Controller
@RequestMapping(value = "${adminPath}/userplan/cdbooPlan")
public class CdbooPlanController extends BaseController {

	@Autowired
	private CdbooPlanService cdbooPlanService;

	@Autowired
	private TimestepService timestepService;

	@Autowired
	private CdbooChannelService channelService;

	@Autowired
	private SystemService systemService;

	@ModelAttribute
	public CdbooPlan get(@RequestParam(required=false) String id) {
		CdbooPlan entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cdbooPlanService.get(id);
		}
		if (entity == null){
			entity = new CdbooPlan();
		}
		return entity;
	}
	
	@RequiresPermissions("userplan:cdbooPlan:view")
	@RequestMapping(value = {"list", ""})
	public String list(CdbooPlan cdbooPlan, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CdbooPlan> page = cdbooPlanService.findPage(new Page<CdbooPlan>(request, response), cdbooPlan);

		List<Timestep> timestepList = timestepService.findList(new Timestep());
		List<CdbooChannel> channelList = channelService.findList(new CdbooChannel());

		model.addAttribute("channelList", channelList);
		model.addAttribute("timestepList", timestepList);

		model.addAttribute("page", page);
		return "cdboo/userplan/cdbooPlanList";
	}

	@RequiresPermissions("userplan:cdbooPlan:view")
	@RequestMapping(value = "form")
	public String form(CdbooPlan cdbooPlan, HttpServletRequest request, HttpServletResponse response, Model model) {

		PlanModel planModel = new PlanModel();

		if (org.apache.commons.lang3.StringUtils.isNotBlank(cdbooPlan.getUser().getId())) {
			List<CdbooPlan> list = cdbooPlanService.findList(cdbooPlan);
			User user = systemService.getUser(cdbooPlan.getUser().getId());

			planModel.setPlanList(list);
			planModel.setUserId(user.getId());
			planModel.setUserName(user.getName());
		}

		//所有时段
		List<Timestep> timestepList = timestepService.findList(new Timestep());
		List<CdbooChannel> channelList = channelService.findList(new CdbooChannel());

		model.addAttribute("channelList", channelList);
		model.addAttribute("timestepList", timestepList);
		model.addAttribute("planModel", planModel);
		return "cdboo/userplan/cdbooPlanForm";
	}

	@RequiresPermissions("userplan:cdbooPlan:edit")
	@RequestMapping(value = "save")
	public String save(PlanModel planModel, Model model, RedirectAttributes redirectAttributes) {
		cdbooPlanService.save(planModel);
		addMessage(redirectAttributes, "保存用户计划成功");
		return "redirect:"+Global.getAdminPath()+"/userplan/cdbooPlan/?repage";
	}
	
	@RequiresPermissions("userplan:cdbooPlan:edit")
	@RequestMapping(value = "delete")
	public String delete(CdbooPlan cdbooPlan, RedirectAttributes redirectAttributes) {
		cdbooPlanService.delete(cdbooPlan);
		addMessage(redirectAttributes, "删除用户计划成功");
		return "redirect:"+Global.getAdminPath()+"/userplan/cdbooPlan/?repage";
	}

}