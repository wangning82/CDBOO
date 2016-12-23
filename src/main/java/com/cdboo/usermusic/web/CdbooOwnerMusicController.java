/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.usermusic.web;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cdboo.music.entity.CdbooMusic;
import com.cdboo.usermusic.entity.CdbooOwnerMusic;
import com.cdboo.usermusic.service.CdbooOwnerMusicService;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 用户曲库信息Controller
 * @author yubin
 * @version 2016-12-21
 */
@Controller
@RequestMapping(value = "${adminPath}/usermusic/cdbooOwnerMusic")
public class CdbooOwnerMusicController extends BaseController {

	@Autowired
	private CdbooOwnerMusicService cdbooOwnerMusicService;
	
	@ModelAttribute
	public CdbooOwnerMusic get(@RequestParam(required=false) String id) {
		CdbooOwnerMusic entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cdbooOwnerMusicService.get(id);
		}
		if (entity == null){
			entity = new CdbooOwnerMusic();
		}
		return entity;
	}
	
	@RequiresPermissions("usermusic:cdbooOwnerMusic:view")
	@RequestMapping(value = {"list", ""})
	public String list(CdbooOwnerMusic cdbooOwnerMusic, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CdbooOwnerMusic> page = cdbooOwnerMusicService.findPage(new Page<CdbooOwnerMusic>(request, response), cdbooOwnerMusic); 
		model.addAttribute("page", page);
		
		User user = cdbooOwnerMusic.getUser();
		if (user != null && StringUtils.isNotBlank(user.getId())) {
			List<CdbooMusic> cdbooMusics = cdbooOwnerMusicService.getMusicByUser(user);
			cdbooOwnerMusic.setMusicList(cdbooMusics);
		}
		return "cdboo/usermusic/cdbooOwnerMusicList";
	}

	@RequiresPermissions("usermusic:cdbooOwnerMusic:view")
	@RequestMapping(value = "form")
	public String form(CdbooOwnerMusic cdbooOwnerMusic, Model model) {

		model.addAttribute("cdbooOwnerMusic", cdbooOwnerMusic);

		User user = cdbooOwnerMusic.getUser();
		if(user!=null && StringUtils.isNotBlank(user.getId())){
			String id = user.getId();
			user = UserUtils.get(id);
			cdbooOwnerMusic.setUser(user);

			List<CdbooMusic> cdbooMusics = cdbooOwnerMusicService.getMusicByUser(user);
			cdbooOwnerMusic.setMusicList(cdbooMusics);
		}

		return "cdboo/usermusic/cdbooOwnerMusicForm";
	}

	@RequiresPermissions("usermusic:cdbooOwnerMusic:edit")
	@RequestMapping(value = "save")
	public String save(CdbooOwnerMusic cdbooOwnerMusic, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cdbooOwnerMusic)){
			return form(cdbooOwnerMusic, model);
		}
		cdbooOwnerMusicService.save(cdbooOwnerMusic);
		addMessage(redirectAttributes, "保存用户曲库信息成功");
		return "redirect:"+Global.getAdminPath()+"/usermusic/cdbooOwnerMusic/?repage";
	}
	
	@RequiresPermissions("usermusic:cdbooOwnerMusic:edit")
	@RequestMapping(value = "delete")
	public String delete(CdbooOwnerMusic cdbooOwnerMusic, RedirectAttributes redirectAttributes) {
		cdbooOwnerMusicService.delete(cdbooOwnerMusic);
		addMessage(redirectAttributes, "删除用户曲库信息成功");
		return "redirect:"+Global.getAdminPath()+"/usermusic/cdbooOwnerMusic/?repage";
	}

	@ResponseBody
	@RequestMapping(value = "getMusicList")
	public List<CdbooMusic> getMusicList(@RequestParam(required = false) String userId) {
		User user = new User(userId);
		List<CdbooMusic> cdbooMusics = cdbooOwnerMusicService.getMusicByUser(user);
		return cdbooMusics;
	}
}