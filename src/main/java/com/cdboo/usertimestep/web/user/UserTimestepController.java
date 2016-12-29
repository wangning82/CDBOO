/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.usertimestep.web.user;

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

import com.cdboo.usertimestep.entity.CdbooUserTimestep;
import com.cdboo.usertimestep.service.CdbooUserTimestepService;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 用户时段信息Controller
 * @author yubin
 * @version 2016-12-21
 */
@Controller
@RequestMapping(value = "${adminPath}/usertimestep/userTimestep")
public class UserTimestepController extends BaseController {

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
	
	@RequiresPermissions("usertimestep:userTimestep:view")
	@RequestMapping(value = {"list", ""})
	public String list(CdbooUserTimestep cdbooUserTimestep, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		User user = UserUtils.getUser();
		cdbooUserTimestep.setUser(user);
		
		Page<CdbooUserTimestep> page = cdbooUserTimestepService.findPage(new Page<CdbooUserTimestep>(request, response),
				cdbooUserTimestep);
		model.addAttribute("page", page);
		
		List<CdbooUserTimestep> timeStepList = cdbooUserTimestepService.findList(cdbooUserTimestep);
		cdbooUserTimestep.setTimestepList(timeStepList);
		
		return "cdboo/usertimestep/user/cdbooUserTimestepList";
	}

	@RequiresPermissions("usertimestep:userTimestep:view")
	@RequestMapping(value = "form")
	public String form(CdbooUserTimestep cdbooUserTimestep, Model model) {
		model.addAttribute("cdbooUserTimestep", cdbooUserTimestep);
		
		User user = UserUtils.getUser();
		cdbooUserTimestep.setUser(user);
		
		return "cdboo/usertimestep/user/cdbooUserTimestepForm";
	}

	@RequiresPermissions("usertimestep:userTimestep:edit")
	@RequestMapping(value = "save")
	public String save(CdbooUserTimestep cdbooUserTimestep, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cdbooUserTimestep)){
			return form(cdbooUserTimestep, model);
		}
		cdbooUserTimestepService.save(cdbooUserTimestep);
		addMessage(redirectAttributes, "保存用户时段成功");
		return "redirect:"+Global.getAdminPath()+"/usertimestep/userTimestep/?repage";
	}
	
}