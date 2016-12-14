/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.timestep.web;

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

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.cdboo.timestep.entity.Timestep;
import com.cdboo.timestep.service.TimestepService;

/**
 * 时段管理Controller
 * @author 朱广成
 * @version 2016-12-13
 */
@Controller
@RequestMapping(value = "${adminPath}/timestep/timestep")
public class TimestepController extends BaseController {

	@Autowired
	private TimestepService timestepService;
	
	@ModelAttribute
	public Timestep get(@RequestParam(required=false) String id) {
		Timestep entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = timestepService.get(id);
		}
		if (entity == null){
			entity = new Timestep();
		}
		return entity;
	}
	
	@RequiresPermissions("timestep:timestep:view")
	@RequestMapping(value = {"list", ""})
	public String list(Timestep timestep, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Timestep> page = timestepService.findPage(new Page<Timestep>(request, response), timestep); 
		model.addAttribute("page", page);
		return "cdboo/timestep/timestepList";
	}

	@RequiresPermissions("timestep:timestep:view")
	@RequestMapping(value = "form")
	public String form(Timestep timestep, Model model) {
		model.addAttribute("timestep", timestep);
		return "cdboo/timestep/timestepForm";
	}

	@RequiresPermissions("timestep:timestep:edit")
	@RequestMapping(value = "save")
	public String save(Timestep timestep, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, timestep)){
			return form(timestep, model);
		}
		timestepService.save(timestep);
		addMessage(redirectAttributes, "保存时段成功");
		return "redirect:"+Global.getAdminPath()+"/timestep/timestep/?repage";
	}
	
	@RequiresPermissions("timestep:timestep:edit")
	@RequestMapping(value = "delete")
	public String delete(Timestep timestep, RedirectAttributes redirectAttributes) {
		timestepService.delete(timestep);
		addMessage(redirectAttributes, "删除时段成功");
		return "redirect:"+Global.getAdminPath()+"/timestep/timestep/?repage";
	}

}