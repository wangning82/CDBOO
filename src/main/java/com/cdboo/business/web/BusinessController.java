/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.business.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cdboo.business.entity.BusinessTimestep;
import com.cdboo.timestep.entity.Timestep;
import com.cdboo.timestep.service.TimestepService;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.cdboo.business.entity.Business;
import com.cdboo.business.service.BusinessService;

/**
 * 行业Controller
 * @author 朱广成
 * @version 2016-12-01
 */
@Controller
@RequestMapping(value = "${adminPath}/business/business")
public class BusinessController extends BaseController {

	@Autowired
	private BusinessService businessService;

	@Autowired
	private TimestepService timestepService;

	@ModelAttribute
	public Business get(@RequestParam(required=false) String id) {
		Business entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = businessService.get(id);
		}
		if (entity == null){
			entity = new Business();
		}
		return entity;
	}
	
	@RequiresPermissions("business:business:view")
	@RequestMapping(value = {"list", ""})
	public String list(Business business, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<Business> list = businessService.findList(business); 
		model.addAttribute("list", list);
		return "cdboo/business/businessList";
	}

	@RequiresPermissions("business:business:view")
	@RequestMapping(value = "form")
	public String form(Business business, Model model) {
		if (business.getParent()!=null && StringUtils.isNotBlank(business.getParent().getId())){
			business.setParent(businessService.get(business.getParent().getId()));
			// 获取排序号，最末节点排序号+30
			if (StringUtils.isBlank(business.getId())){
				Business businessChild = new Business();
				businessChild.setParent(new Business(business.getParent().getId()));
				List<Business> list = businessService.findList(business); 
				if (list.size() > 0){
					business.setSort(list.get(list.size()-1).getSort());
					if (business.getSort() != null){
						business.setSort(business.getSort() + 30);
					}
				}
			}
		}
		if (business.getSort() == null){
			business.setSort(30);
		}
		model.addAttribute("business", business);
		return "cdboo/business/businessForm";
	}

	@RequiresPermissions("business:business:edit")
	@RequestMapping(value = "save")
	public String save(Business business, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, business)){
			return form(business, model);
		}
		businessService.save(business);
		addMessage(redirectAttributes, "保存行业成功");
		return "redirect:"+Global.getAdminPath()+"/business/business/?repage";
	}
	
	@RequiresPermissions("business:business:edit")
	@RequestMapping(value = "delete")
	public String delete(Business business, RedirectAttributes redirectAttributes) {
		businessService.delete(business);
		addMessage(redirectAttributes, "删除行业成功");
		return "redirect:"+Global.getAdminPath()+"/business/business/?repage";
	}

	@RequiresPermissions("business:business:view")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Business> list = businessService.findList(new Business());
		for (int i=0; i<list.size(); i++){
			Business e = list.get(i);
			if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}

	@RequiresPermissions("business:timestep:view")
	@RequestMapping(value = {"index"})
	public String index(BusinessTimestep businessTimestep, Model model) {
		return "cdboo/business/businessIndex";
	}

	@RequiresPermissions("business:timestep:view")
	@RequestMapping(value = {"listTimestep"})
	public String listTimestep(BusinessTimestep businessTimestep, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BusinessTimestep> page = businessService.findTimestepByBusinessTimestep(new Page<>(request, response), businessTimestep);

		model.addAttribute("page", page);
		return "cdboo/business/businessTimestepList";
	}

	@RequiresPermissions("business:timestep:edit")
	@RequestMapping(value = "businessTimestepForm")
	public String businessTimestepForm(BusinessTimestep businessTimestep, Model model) {
		List<Timestep> timestepList = timestepService.findList(new Timestep());
		model.addAttribute("timestepList", timestepList);
		return "cdboo/business/businessTimestepForm";
	}

	@RequiresPermissions("business:timestep:edit")
	@RequestMapping(value = "businessTimestepSave")
	public String businessTimestepSave(BusinessTimestep businessTimestep, Model model, RedirectAttributes redirectAttributes) {
		businessService.insertBusinessTimestep(businessTimestep);
		addMessage(redirectAttributes, "保存行业时段成功");
		return "redirect:"+Global.getAdminPath()+"/business/business/listTimestep?repage";
	}

	
}