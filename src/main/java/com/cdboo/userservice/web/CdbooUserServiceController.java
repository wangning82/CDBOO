/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.userservice.web;

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
import com.cdboo.userservice.entity.CdbooUserService;
import com.cdboo.userservice.service.CdbooUserServiceService;

/**
 * 用户服务信息Controller
 * @author yubin
 * @version 2016-12-21
 */
@Controller
@RequestMapping(value = "${adminPath}/userservice/cdbooUserService")
public class CdbooUserServiceController extends BaseController {

	@Autowired
	private CdbooUserServiceService cdbooUserServiceService;
	
	@ModelAttribute
	public CdbooUserService get(@RequestParam(required=false) String id) {
		CdbooUserService entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cdbooUserServiceService.get(id);
		}
		if (entity == null){
			entity = new CdbooUserService();
		}
		return entity;
	}
	
	@RequiresPermissions("userservice:cdbooUserService:view")
	@RequestMapping(value = {"list", ""})
	public String list(CdbooUserService cdbooUserService, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CdbooUserService> page = cdbooUserServiceService.findPage(new Page<CdbooUserService>(request, response), cdbooUserService); 
		model.addAttribute("page", page);
		return "cdboo/userservice/cdbooUserServiceList";
	}

	@RequiresPermissions("userservice:cdbooUserService:view")
	@RequestMapping(value = "form")
	public String form(CdbooUserService cdbooUserService, Model model) {
		model.addAttribute("cdbooUserService", cdbooUserService);
		return "cdboo/userservice/cdbooUserServiceForm";
	}

	@RequiresPermissions("userservice:cdbooUserService:edit")
	@RequestMapping(value = "save")
	public String save(CdbooUserService cdbooUserService, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cdbooUserService)){
			return form(cdbooUserService, model);
		}
		cdbooUserServiceService.save(cdbooUserService);
		addMessage(redirectAttributes, "保存用户服务信息成功");
		return "redirect:"+Global.getAdminPath()+"/userservice/cdbooUserService/?repage";
	}
	
	@RequiresPermissions("userservice:cdbooUserService:edit")
	@RequestMapping(value = "delete")
	public String delete(CdbooUserService cdbooUserService, RedirectAttributes redirectAttributes) {
		cdbooUserServiceService.delete(cdbooUserService);
		addMessage(redirectAttributes, "删除用户服务信息成功");
		return "redirect:"+Global.getAdminPath()+"/userservice/cdbooUserService/?repage";
	}

}