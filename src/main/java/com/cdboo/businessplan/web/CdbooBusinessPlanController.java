package com.cdboo.businessplan.web;

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

import com.cdboo.businessplan.entity.CdbooBusinessPlan;
import com.cdboo.businessplan.service.CdbooBusinessPlanService;
import com.cdboo.businessplantimestep.entity.CdbooBusinessPlanTimestep;
import com.cdboo.businessplantimestep.service.CdbooBusinessPlanTimestepService;
import com.cdboo.busiplantimechannel.entity.CdbooBusinessPlanTimestepChannel;
import com.cdboo.busiplantimechannel.service.CdbooBusinessPlanTimestepChannelService;
import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.timestep.entity.Timestep;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.web.Servlets;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;
import com.thinkgem.jeesite.modules.sys.utils.LogUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

@Controller
@RequestMapping(value = "${adminPath}/businessplan/plan")
public class CdbooBusinessPlanController extends BaseController{
	@Autowired
	private CdbooBusinessPlanService cdbooBusinessPlanService;
	
	@Autowired
	private CdbooBusinessPlanTimestepService cdbooBusinessPlanTimestepService;
	
	@Autowired
	private CdbooBusinessPlanTimestepChannelService cdbooBusinessPlanTimestepChannelService;
	
	@Autowired
	private OfficeService officeService;
	
	@ModelAttribute
	public CdbooBusinessPlan get(@RequestParam(required=false) String id) {
		CdbooBusinessPlan entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cdbooBusinessPlanService.get(id);
		}
		if (entity == null){
			entity = new CdbooBusinessPlan();
		}
		return entity;
	}
	
	@RequiresPermissions("businessplan:plan:view")
	@RequestMapping(value = {"index"})
	public String index(CdbooBusinessPlan businessPlan, Model model) {
		return "cdboo/business/businessIndex";
	}
	
	@RequiresPermissions("businessplan:plan:view")
	@RequestMapping(value = { "listTimestep" })
	public String listTimestep(CdbooBusinessPlan businessPlan, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		Page<CdbooBusinessPlan> page = cdbooBusinessPlanService.findPage(new Page<>(request, response), businessPlan);
		model.addAttribute("page", page);
		model.addAttribute("businessPlan", businessPlan);
		return "cdboo/business/businessPlanList";
	}
	
	@RequiresPermissions("businessplan:plan:edit")
	@RequestMapping(value = "form")
	public String form(CdbooBusinessPlan businessPlan, Model model) {
		model.addAttribute("businessPlan", businessPlan);
		return "cdboo/business/businessPlanForm";
	}
	
	@RequiresPermissions("businessplan:plan:edit")
	@RequestMapping(value = "delete")
	public String delete(CdbooBusinessPlan businessPlan, Model model, RedirectAttributes redirectAttributes) {
		try {
			cdbooBusinessPlanService.deleteBusinessPlan(businessPlan);
			addMessage(redirectAttributes, "删除行业计划成功");
		} catch (Exception e) {
			LogUtils.saveLog(Servlets.getRequest(), null, e, "保存行业计划");
			addMessage(redirectAttributes, "删除行业计划失败");
		}
		return "redirect:"+Global.getAdminPath()+"/businessplan/plan/listTimestep?repage";
	}
	
	@RequiresPermissions("businessplan:plan:edit")
	@RequestMapping(value = "save")
	public String save(CdbooBusinessPlan businessPlan, Model model, RedirectAttributes redirectAttributes) {
		try {
			cdbooBusinessPlanService.save(businessPlan);
			addMessage(redirectAttributes, "保存行业计划成功");
		} catch (Exception e) {
			LogUtils.saveLog(Servlets.getRequest(), null, e, "保存行业计划");
			addMessage(redirectAttributes, "保存行业计划失败");
		}
		redirectAttributes.addFlashAttribute(businessPlan);
		return "redirect:"+Global.getAdminPath()+"/businessplan/plan/listTimestep?repage";
	}
	
	@RequiresPermissions("businessplan:plan:edit")
	@RequestMapping(value = "toEditTimestepPage")
	public String toEditTimestepPage(CdbooBusinessPlan businessPlan, Model model) {
		model.addAttribute("businessPlan", businessPlan);
		
		CdbooBusinessPlanTimestep planTimestep = new CdbooBusinessPlanTimestep();
		planTimestep.setBusinessPlan(businessPlan);
		List<Timestep> timesteps = cdbooBusinessPlanTimestepService.findTimeStepsByConditions(planTimestep);
		businessPlan.setTimesteps(timesteps);
		return "cdboo/business/businessTimestepForm";
	}
	
	@RequiresPermissions("businessplan:plan:edit")
	@RequestMapping(value = "saveTimestep")
	public String saveTimestep(CdbooBusinessPlan businessPlan, Model model, RedirectAttributes redirectAttributes) {
		try {
			cdbooBusinessPlanTimestepService.saveTimeStep(businessPlan);
			addMessage(redirectAttributes, "保存行业时段成功");
		} catch (Exception e) {
			LogUtils.saveLog(Servlets.getRequest(), null, e, "保存行业时段");
			addMessage(redirectAttributes, "保存行业时段失败");
		}
		redirectAttributes.addFlashAttribute(businessPlan);
		return "redirect:"+Global.getAdminPath()+"/businessplan/plan/toEditTimestepPage";
	}
	
	@RequiresPermissions("businessplan:plan:edit")
	@RequestMapping(value = "toEditChannelPage")
	public String toEditChannelPage(CdbooBusinessPlan businessPlan, Model model) {
		model.addAttribute("businessPlan", businessPlan);
		
		CdbooBusinessPlanTimestep queryObj = new CdbooBusinessPlanTimestep();
		queryObj.setBusinessPlan(businessPlan);
		queryObj.setTimestep(new Timestep(businessPlan.getTimeStepId()));
		List<CdbooBusinessPlanTimestep> businessPlanTimesteps = cdbooBusinessPlanTimestepService.findList(queryObj);
		
		if(CollectionUtils.isNotEmpty(businessPlanTimesteps)){
			CdbooBusinessPlanTimestep businessPlanTimestep = businessPlanTimesteps.get(0);
			CdbooBusinessPlanTimestepChannel channelQueryObj = new CdbooBusinessPlanTimestepChannel();
			channelQueryObj.setBusinessPlanTimestep(businessPlanTimestep);
			List<CdbooChannel> channels = cdbooBusinessPlanTimestepChannelService.findMyList(channelQueryObj);
			businessPlan.setCdbooChannels(channels);
		}
		
		User user = UserUtils.getUser();
		User userObj = UserUtils.get(user.getId());
		Office office = userObj.getOffice();
		List<Office> officeList = officeService.findOfficeListByParentForCondition(office);
		businessPlan.setCdbooConditionList(officeList);
		
		return "cdboo/business/businessTimestepChannelForm";
	}
	
	@RequiresPermissions("businessplan:plan:edit")
	@RequestMapping(value = "saveTimestepChannel")
	public String saveTimestepChannel(CdbooBusinessPlan businessPlan, Model model, RedirectAttributes redirectAttributes) {
		try {
			cdbooBusinessPlanTimestepChannelService.saveTimestepChannel(businessPlan);
			addMessage(redirectAttributes, "保存频道成功");
		} catch (Exception e) {
			LogUtils.saveLog(Servlets.getRequest(), null, e, "保存时段频道");
			addMessage(redirectAttributes, "保存频道失败");
		}
		redirectAttributes.addFlashAttribute(businessPlan);
		return "redirect:"+Global.getAdminPath()+"/businessplan/plan/toEditChannelPage";
	}
}
