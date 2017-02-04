/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.myplan.web;

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
import com.cdboo.myplan.entity.CdbooMyPlan;
import com.cdboo.myplan.service.CdbooMyPlanService;
import com.cdboo.myplan.service.CdbooMyPlanTimestepService;
import com.cdboo.usertimestep.entity.CdbooUserTimestep;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;

/**
 * 新计划表Controller
 * @author yubin
 * @version 2017-02-03
 */
@Controller
@RequestMapping(value = "${adminPath}/myplan/cdbooMyPlan")
public class CdbooMyPlanController extends BaseController {

	@Autowired
	private CdbooMyPlanService cdbooMyPlanService;
	
	@Autowired
	private CdbooMyPlanTimestepService cdbooMyPlanTimestepService;
	
	@ModelAttribute
	public CdbooMyPlan get(@RequestParam(required=false) String id) {
		CdbooMyPlan entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cdbooMyPlanService.get(id);
		}
		if (entity == null){
			entity = new CdbooMyPlan();
		}
		return entity;
	}
	
	@RequiresPermissions("myplan:cdbooMyPlan:view")
	@RequestMapping(value = {"list", ""})
	public String list(CdbooMyPlan cdbooMyPlan, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CdbooMyPlan> page = cdbooMyPlanService.findPage(new Page<CdbooMyPlan>(request, response), cdbooMyPlan); 
		model.addAttribute("page", page);
		return "cdboo/myplan/cdbooMyPlanList";
	}

	@RequiresPermissions("myplan:cdbooMyPlan:view")
	@RequestMapping(value = "form")
	public String form(CdbooMyPlan cdbooMyPlan, Model model) {
		model.addAttribute("cdbooMyPlan", cdbooMyPlan);
		
		String id = cdbooMyPlan.getId();
		if(StringUtils.isNotBlank(id)){
			List<CdbooUserTimestep> cdbooUserTimesteps = cdbooMyPlanTimestepService.findUserTimeStepList(cdbooMyPlan);
			cdbooMyPlan.setCdbooUserTimestepList(cdbooUserTimesteps);
		}
		
		return "cdboo/myplan/cdbooMyPlanForm";
	}

	@RequiresPermissions("myplan:cdbooMyPlan:edit")
	@RequestMapping(value = "save")
	public String save(CdbooMyPlan cdbooMyPlan, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cdbooMyPlan)){
			return form(cdbooMyPlan, model);
		}
		cdbooMyPlanService.save(cdbooMyPlan);
		addMessage(redirectAttributes, "保存计划成功");
		return "redirect:"+Global.getAdminPath()+"/myplan/cdbooMyPlan/?repage";
	}
	
	@RequiresPermissions("myplan:cdbooMyPlan:edit")
	@RequestMapping(value = "delete")
	public String delete(CdbooMyPlan cdbooMyPlan, RedirectAttributes redirectAttributes) {
		cdbooMyPlanService.delete(cdbooMyPlan);
		addMessage(redirectAttributes, "删除计划成功");
		return "redirect:"+Global.getAdminPath()+"/myplan/cdbooMyPlan/?repage";
	}

}