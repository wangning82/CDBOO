/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.channel.web;

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

import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.channel.service.CdbooChannelService;
import com.cdboo.common.Constants;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;

/**
 * 频道管理Controller
 * @author 于滨
 * @version 2016-12-17
 */
@Controller
@RequestMapping(value = "${adminPath}/channel/cdbooChannel")
public class CdbooChannelController extends BaseController {

	@Autowired
	private CdbooChannelService cdbooChannelService;
	
	@ModelAttribute
	public CdbooChannel get(@RequestParam(required=false) String id) {
		CdbooChannel entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cdbooChannelService.get(id);
		}
		if (entity == null){
			entity = new CdbooChannel();
		}
		return entity;
	}
	
	@RequiresPermissions("channel:cdbooChannel:view")
	@RequestMapping(value = {"list", ""})
	public String list(CdbooChannel cdbooChannel, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CdbooChannel> page = cdbooChannelService.findPage(new Page<CdbooChannel>(request, response), cdbooChannel); 
		model.addAttribute("page", page);
		
		setThemeConcreteTypeListToRequest(cdbooChannel, request);
		
		return "cdboo/channel/cdbooChannelList";
	}

	private void setThemeConcreteTypeListToRequest(CdbooChannel cdbooChannel, HttpServletRequest request){
		String themeType = cdbooChannel.getThemeType();
		if(StringUtils.isNotBlank(themeType)){
			List<Dict> dictList = Lists.newArrayList();
			if(StringUtils.equals(themeType, Constants.THEMETYPE_THEME)){
				dictList = DictUtils.getDictList(Constants.DICT_SEASON_TYPE_NAME);
			}
			if(StringUtils.equals(themeType, Constants.THEMETYPE_HOLIDAY)){
				dictList = DictUtils.getDictList(Constants.DICT_HOLIDAY_TYPE_NAME);
			}
			request.setAttribute("themeConcreteTypeList", dictList);
		}
	}
	
	@RequiresPermissions("channel:cdbooChannel:view")
	@RequestMapping(value = "form")
	public String form(CdbooChannel cdbooChannel, Model model, HttpServletRequest request) {
		model.addAttribute("cdbooChannel", cdbooChannel);

		List<Dict> musicStyleList = DictUtils.getDictList(Constants.DICT_MUSIC_STYLE_NAME);
		model.addAttribute("allMusicStyleList", musicStyleList);
		
		List<Dict> elementTypeList = DictUtils.getDictList(Constants.DICT_ELEMENT_TYPE_NAME);
		model.addAttribute("allElementTypeList", elementTypeList);
		
		List<Dict> emotionTypeList = DictUtils.getDictList(Constants.DICT_EMOTION_TYPE_NAME);
		model.addAttribute("allEmotionTypeList", emotionTypeList);
		
		List<Dict> instrumentTypeList = DictUtils.getDictList(Constants.DICT_INSTRUMENT_TYPE_NAME);
		model.addAttribute("allInstrumentTypeList", instrumentTypeList);
		
		setThemeConcreteTypeListToRequest(cdbooChannel, request);
		
		return "cdboo/channel/cdbooChannelForm";
	}

	@RequiresPermissions("channel:cdbooChannel:edit")
	@RequestMapping(value = "save")
	public String save(CdbooChannel cdbooChannel, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request) {
		if (!beanValidator(model, cdbooChannel)){
			return form(cdbooChannel, model,request);
		}
		cdbooChannelService.save(cdbooChannel);
		addMessage(redirectAttributes, "保存频道信息成功");
		return "redirect:"+Global.getAdminPath()+"/channel/cdbooChannel/?repage";
	}
	
	@RequiresPermissions("channel:cdbooChannel:edit")
	@RequestMapping(value = "delete")
	public String delete(CdbooChannel cdbooChannel, RedirectAttributes redirectAttributes) {
		cdbooChannelService.delete(cdbooChannel);
		addMessage(redirectAttributes, "删除频道信息成功");
		return "redirect:"+Global.getAdminPath()+"/channel/cdbooChannel/?repage";
	}

}