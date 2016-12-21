/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.usertimestep.web;

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
import com.cdboo.usertimestep.entity.CdbooUserTimestep;
import com.cdboo.usertimestep.service.CdbooUserTimestepService;

/**
 * 用户时段信息Controller
 * @author yubin
 * @version 2016-12-21
 */
@Controller
@RequestMapping(value = "${adminPath}/usertimestep/cdbooUserTimestep")
public class CdbooUserTimestepController extends BaseController {

	@Autowired
	private CdbooUserTimestepService cdbooUserTimestepService;
	
	@ModelAttribute
	public CdbooUserTimestep get(@RequestParam(required=false) String id) {
		CdbooUserTimestep entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cdbooUserTimestepService.get(id);
		}
		if (entity == null){
			entity = new CdbooUserTimestep();
		}
		return entity;
	}
	
	@RequiresPermissions("usertimestep:cdbooUserTimestep:view")
	@RequestMapping(value = {"list", ""})
	public String list(CdbooUserTimestep cdbooUserTimestep, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CdbooUserTimestep> page = cdbooUserTimestepService.findPage(new Page<CdbooUserTimestep>(request, response), cdbooUserTimestep); 
		model.addAttribute("page", page);
		return "cdboo/usertimestep/cdbooUserTimestepList";
	}

	@RequiresPermissions("usertimestep:cdbooUserTimestep:view")
	@RequestMapping(value = "form")
	public String form(CdbooUserTimestep cdbooUserTimestep, Model model) {
		model.addAttribute("cdbooUserTimestep", cdbooUserTimestep);
		return "cdboo/usertimestep/cdbooUserTimestepForm";
	}

	@RequiresPermissions("usertimestep:cdbooUserTimestep:edit")
	@RequestMapping(value = "save")
	public String save(CdbooUserTimestep cdbooUserTimestep, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cdbooUserTimestep)){
			return form(cdbooUserTimestep, model);
		}
		cdbooUserTimestepService.save(cdbooUserTimestep);
		addMessage(redirectAttributes, "保存用户时段成功");
		return "redirect:"+Global.getAdminPath()+"/usertimestep/cdbooUserTimestep/?repage";
	}
	
	@RequiresPermissions("usertimestep:cdbooUserTimestep:edit")
	@RequestMapping(value = "delete")
	public String delete(CdbooUserTimestep cdbooUserTimestep, RedirectAttributes redirectAttributes) {
		cdbooUserTimestepService.delete(cdbooUserTimestep);
		addMessage(redirectAttributes, "删除用户时段成功");
		return "redirect:"+Global.getAdminPath()+"/usertimestep/cdbooUserTimestep/?repage";
	}

}