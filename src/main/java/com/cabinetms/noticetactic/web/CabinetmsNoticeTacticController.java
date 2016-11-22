/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cabinetms.noticetactic.web;

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
import com.cabinetms.noticetactic.entity.CabinetmsNoticeTactic;
import com.cabinetms.noticetactic.service.CabinetmsNoticeTacticService;

/**
 * 消息策略Controller
 * @author 付殿东
 * @version 2016-10-11
 */
@Controller
@RequestMapping(value = "${adminPath}/noticetactic/cabinetmsNoticeTactic")
public class CabinetmsNoticeTacticController extends BaseController {

	@Autowired
	private CabinetmsNoticeTacticService cabinetmsNoticeTacticService;
	
	@ModelAttribute
	public CabinetmsNoticeTactic get(@RequestParam(required=false) String id) {
		CabinetmsNoticeTactic entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cabinetmsNoticeTacticService.get(id);
		}
		if (entity == null){
			entity = new CabinetmsNoticeTactic();
		}
		return entity;
	}
	
	@RequiresPermissions("noticetactic:cabinetmsNoticeTactic:view")
	@RequestMapping(value = {"list", ""})
	public String list(CabinetmsNoticeTactic cabinetmsNoticeTactic, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CabinetmsNoticeTactic> page = cabinetmsNoticeTacticService.findPage(new Page<CabinetmsNoticeTactic>(request, response), cabinetmsNoticeTactic); 
		model.addAttribute("page", page);
		return "cabinetms/noticetactic/cabinetmsNoticeTacticList";
	}

	@RequiresPermissions("noticetactic:cabinetmsNoticeTactic:view")
	@RequestMapping(value = "form")
	public String form(CabinetmsNoticeTactic cabinetmsNoticeTactic, Model model) {
		model.addAttribute("cabinetmsNoticeTactic", cabinetmsNoticeTactic);
		return "cabinetms/noticetactic/cabinetmsNoticeTacticForm";
	}

	@RequiresPermissions("noticetactic:cabinetmsNoticeTactic:edit")
	@RequestMapping(value = "save")
	public String save(CabinetmsNoticeTactic cabinetmsNoticeTactic, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cabinetmsNoticeTactic)){
			return form(cabinetmsNoticeTactic, model);
		}
		cabinetmsNoticeTacticService.save(cabinetmsNoticeTactic);
		addMessage(redirectAttributes, "保存消息策略成功");
		return "redirect:"+Global.getAdminPath()+"/noticetactic/cabinetmsNoticeTactic/?repage";
	}
	
	@RequiresPermissions("noticetactic:cabinetmsNoticeTactic:edit")
	@RequestMapping(value = "delete")
	public String delete(CabinetmsNoticeTactic cabinetmsNoticeTactic, RedirectAttributes redirectAttributes) {
		cabinetmsNoticeTacticService.delete(cabinetmsNoticeTactic);
		addMessage(redirectAttributes, "删除消息策略成功");
		return "redirect:"+Global.getAdminPath()+"/noticetactic/cabinetmsNoticeTactic/?repage";
	}

}