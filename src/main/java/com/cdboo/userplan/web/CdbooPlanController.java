/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.userplan.web;

import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.userchannel.service.CdbooUserChannelService;
import com.cdboo.usergroup.service.CdbooUserGroupService;
import com.cdboo.userplan.entity.CdbooPlan;
import com.cdboo.userplan.model.PlanModel;
import com.cdboo.userplan.service.CdbooPlanService;
import com.cdboo.usertimestep.entity.CdbooUserTimestep;
import com.cdboo.usertimestep.service.CdbooUserTimestepService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

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
	private CdbooUserTimestepService cdbooUserTimestepService;

	@Autowired
	private CdbooUserChannelService cdbooUserChannelService;

	@Autowired
	private OfficeService officeService;
	
	@Autowired
	private CdbooUserGroupService userGroupService;
	
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
		Page<CdbooPlan> page = cdbooPlanService.findMyPage(new Page<CdbooPlan>(request, response), cdbooPlan);

		List<CdbooUserTimestep> timestepList = Lists.newArrayList();
		List<CdbooChannel> channelList = Lists.newArrayList();
		
		User user = cdbooPlan.getUser();
		if(user!=null && StringUtils.isNotBlank(user.getId())){
			timestepList = cdbooUserTimestepService.findTimeStepByUser(user);
			channelList = cdbooUserChannelService.getChannelListByUser(user,null);
		}

		model.addAttribute("channelList", channelList);
		model.addAttribute("timestepList", timestepList);

		model.addAttribute("page", page);
		return "cdboo/userplan/cdbooPlanList";
	}

	@RequiresPermissions("plan:cdbooPlan:view")
	@RequestMapping(value = {"userPlanList"})
	public String userPlanList(CdbooPlan cdbooPlan, HttpServletRequest request, HttpServletResponse response, Model model) {

		User user = UserUtils.getUser();
		cdbooPlan.setUser(user);
		
		Page<CdbooPlan> page = cdbooPlanService.findMyPage(new Page<CdbooPlan>(request, response), cdbooPlan);

		List<CdbooUserTimestep> timestepList = Lists.newArrayList();
		List<CdbooChannel> channelList = Lists.newArrayList();
		
		timestepList = cdbooUserTimestepService.findTimeStepByUser(user);
		channelList = cdbooUserChannelService.getChannelListByUser(user,null);

		model.addAttribute("channelList", channelList);
		model.addAttribute("timestepList", timestepList);

		model.addAttribute("page", page);
		return "cdboo/userplan/userPlanList";
	}

	@RequiresPermissions("userplan:cdbooPlan:edit")
	@RequestMapping(value = "form")
	public String form(CdbooPlan cdbooPlan, HttpServletRequest request, HttpServletResponse response, Model model) {

		PlanModel planModel = new PlanModel();

		if (cdbooPlan != null && org.apache.commons.lang3.StringUtils.isNotBlank(cdbooPlan.getId())) {
			User user = cdbooPlan.getUser();
			
			List<CdbooUserTimestep> userTimeStepList = cdbooUserTimestepService.findTimeStepByUser(user);
			
			List<CdbooChannel> channelList = getChannelByUser(user);
			
			User userObj = UserUtils.get(user.getId());
			Office office = userObj.getOffice();
			List<Office> officeList = officeService.findOfficeListByParentForCondition(office);
			
			planModel.setCdbooUserTimestepList(userTimeStepList);
			planModel.setCdbooChannelList(channelList);
			planModel.setCdbooConditionList(officeList);
			
			
			String userChannelId = cdbooPlan.getUserChannelId();
			String channelType = cdbooPlan.getChannelType();
			cdbooPlan.setChannel(cdbooPlanService.getChannelByUserChannelIdAndChannelType(userChannelId,channelType));
			
			List<CdbooPlan> list = Lists.newArrayList(cdbooPlan);
			
			planModel.setPlanList(list);
			planModel.setUserId(user.getId());
			planModel.setUserName(user.getName());
		}
		model.addAttribute("planModel", planModel);
		return "cdboo/userplan/cdbooPlanForm";
	}

	@RequiresPermissions("plan:cdbooPlan:edit")
	@RequestMapping(value = "userPlanForm")
	public String userPlanForm(CdbooPlan cdbooPlan, HttpServletRequest request, HttpServletResponse response, Model model) {

		PlanModel planModel = new PlanModel();

		if (cdbooPlan != null && org.apache.commons.lang3.StringUtils.isNotBlank(cdbooPlan.getId())) {
			User user = cdbooPlan.getUser();
			
			List<CdbooUserTimestep> userTimeStepList = cdbooUserTimestepService.findTimeStepByUser(user);
			
			List<CdbooChannel> channelList = getChannelByUser(user);
			
			User userObj = UserUtils.get(user.getId());
			Office office = userObj.getOffice();
			List<Office> officeList = officeService.findOfficeListByParentForCondition(office);
			
			planModel.setCdbooUserTimestepList(userTimeStepList);
			planModel.setCdbooChannelList(channelList);
			planModel.setCdbooConditionList(officeList);
			
			
			String userChannelId = cdbooPlan.getUserChannelId();
			String channelType = cdbooPlan.getChannelType();
			cdbooPlan.setChannel(cdbooPlanService.getChannelByUserChannelIdAndChannelType(userChannelId,channelType));
			
			List<CdbooPlan> list = Lists.newArrayList(cdbooPlan);
			
			planModel.setPlanList(list);
			planModel.setUserId(user.getId());
			planModel.setUserName(user.getName());
		}
		model.addAttribute("planModel", planModel);
		return "cdboo/userplan/userPlanForm";
	}

	@RequiresPermissions("userplan:cdbooPlan:edit")
	@RequestMapping(value = "save")
	public String save(PlanModel planModel, Model model, RedirectAttributes redirectAttributes) {
		cdbooPlanService.save(planModel);
		addMessage(redirectAttributes, "保存用户计划成功");
		return "redirect:"+Global.getAdminPath()+"/userplan/cdbooPlan/?repage";
	}

	@RequiresPermissions("plan:cdbooPlan:edit")
	@RequestMapping(value = "userPlanSave")
	public String userPlanSave(PlanModel planModel, Model model, RedirectAttributes redirectAttributes) {
		cdbooPlanService.save(planModel);
		addMessage(redirectAttributes, "保存用户计划成功");
		return "redirect:"+Global.getAdminPath()+"/userplan/cdbooPlan/userPlanList?repage";
	}

	@RequiresPermissions("userplan:cdbooPlan:edit")
	@RequestMapping(value = "delete")
	public String delete(CdbooPlan cdbooPlan, RedirectAttributes redirectAttributes) {
		cdbooPlanService.delete(cdbooPlan);
		addMessage(redirectAttributes, "删除用户计划成功");
		return "redirect:"+Global.getAdminPath()+"/userplan/cdbooPlan/?repage";
	}

	@RequestMapping(value = "getUserInfo")
	@ResponseBody
	public HashMap<String, Object> getUserInfo(@RequestParam(required=true) String userId, RedirectAttributes redirectAttributes) {
		
		User user = new User(userId);
		
		List<CdbooUserTimestep> userTimeStepList = cdbooUserTimestepService.findTimeStepByUser(user);
		
		List<CdbooChannel> channelList = getChannelByUser(user);
		
		User userObj = UserUtils.get(userId);
		Office office = userObj.getOffice();
		List<Office> officeList = officeService.findOfficeListByParentForCondition(office);
		
		HashMap<String, Object> userInfoMap = Maps.newHashMap();
		userInfoMap.put("timeStepList", CollectionUtils.isEmpty(userTimeStepList)?Lists.newArrayList():userTimeStepList);
		userInfoMap.put("channelList", CollectionUtils.isEmpty(channelList)?Lists.newArrayList():channelList);
		userInfoMap.put("officeList", CollectionUtils.isEmpty(officeList)?Lists.newArrayList():officeList);
		
		return userInfoMap;
	}
	
	private List<CdbooChannel> getChannelByUser(User user){
		List<CdbooChannel> channelList = Lists.newArrayList();
		
		List<CdbooChannel> childChannelList = cdbooUserChannelService.getChannelListByUser(user,null);
		if(CollectionUtils.isNotEmpty(childChannelList))
			channelList.addAll(childChannelList);
		
		List<CdbooChannel> groupChannelList = userGroupService.getGroupChannelListByUser(user);
		if(CollectionUtils.isNotEmpty(groupChannelList))
			channelList.addAll(groupChannelList);
		
		return channelList;
	}

}