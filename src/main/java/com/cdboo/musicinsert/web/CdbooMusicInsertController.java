/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.musicinsert.web;

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
import com.cdboo.musicinsert.entity.CdbooMusicInsert;
import com.cdboo.musicinsert.service.CdbooMusicInsertService;

/**
 * 插播计划表Controller
 * @author yubin
 * @version 2016-12-21
 */
@Controller
@RequestMapping(value = "${adminPath}/musicinsert/cdbooMusicInsert")
public class CdbooMusicInsertController extends BaseController {

	@Autowired
	private CdbooMusicInsertService cdbooMusicInsertService;
	
	@ModelAttribute
	public CdbooMusicInsert get(@RequestParam(required=false) String id) {
		CdbooMusicInsert entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cdbooMusicInsertService.get(id);
		}
		if (entity == null){
			entity = new CdbooMusicInsert();
		}
		return entity;
	}
	
	@RequiresPermissions("musicinsert:cdbooMusicInsert:view")
	@RequestMapping(value = {"list", ""})
	public String list(CdbooMusicInsert cdbooMusicInsert, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CdbooMusicInsert> page = cdbooMusicInsertService.findPage(new Page<CdbooMusicInsert>(request, response), cdbooMusicInsert); 
		model.addAttribute("page", page);
		return "cdboo/musicinsert/cdbooMusicInsertList";
	}

	@RequiresPermissions("musicinsert:cdbooMusicInsert:view")
	@RequestMapping(value = "form")
	public String form(CdbooMusicInsert cdbooMusicInsert, Model model) {
		model.addAttribute("cdbooMusicInsert", cdbooMusicInsert);
		return "cdboo/musicinsert/cdbooMusicInsertForm";
	}

	@RequiresPermissions("musicinsert:cdbooMusicInsert:edit")
	@RequestMapping(value = "save")
	public String save(CdbooMusicInsert cdbooMusicInsert, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cdbooMusicInsert)){
			return form(cdbooMusicInsert, model);
		}
		cdbooMusicInsertService.save(cdbooMusicInsert);
		addMessage(redirectAttributes, "保存插播计划成功");
		return "redirect:"+Global.getAdminPath()+"/musicinsert/cdbooMusicInsert/?repage";
	}
	
	@RequiresPermissions("musicinsert:cdbooMusicInsert:edit")
	@RequestMapping(value = "delete")
	public String delete(CdbooMusicInsert cdbooMusicInsert, RedirectAttributes redirectAttributes) {
		cdbooMusicInsertService.delete(cdbooMusicInsert);
		addMessage(redirectAttributes, "删除插播计划成功");
		return "redirect:"+Global.getAdminPath()+"/musicinsert/cdbooMusicInsert/?repage";
	}

}