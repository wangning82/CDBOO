/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.music.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.cdboo.music.entity.CdbooMusic;
import com.cdboo.music.service.CdbooMusicService;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.web.Servlets;
import com.thinkgem.jeesite.modules.sys.utils.LogUtils;

/**
 * 曲库管理Controller
 * @author yubin
 * @version 2016-12-13
 */
@Controller
@RequestMapping(value = "${adminPath}/music/cdbooMusic")
public class CdbooMusicController extends BaseController {

	@Autowired
	private CdbooMusicService cdbooMusicService;
	
	@ModelAttribute
	public CdbooMusic get(@RequestParam(required=false) String id) {
		CdbooMusic entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cdbooMusicService.get(id);
		}
		if (entity == null){
			entity = new CdbooMusic();
		}
		return entity;
	}
	
	@RequiresPermissions("music:cdbooMusic:view")
	@RequestMapping(value = {"list", ""})
	public String list(CdbooMusic cdbooMusic, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CdbooMusic> page = cdbooMusicService.findPage(new Page<CdbooMusic>(request, response), cdbooMusic); 
		model.addAttribute("page", page);
		return "cdboo/music/cdbooMusicList";
	}
	
	@RequestMapping(value = {"openMusicWin"})
	public String openMusicWin(CdbooMusic cdbooMusic, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CdbooMusic> page = cdbooMusicService.findPage(new Page<CdbooMusic>(request, response), cdbooMusic); 
		model.addAttribute("page", page);
		return "cdboo/music/cdbooMusicOpenWin";
	}
	
	@RequiresPermissions("music:cdbooMusic:view")
	@RequestMapping(value = "form")
	public String form(CdbooMusic cdbooMusic, Model model) {
		model.addAttribute("cdbooMusic", cdbooMusic);
		return "cdboo/music/cdbooMusicForm";
	}

	@RequiresPermissions("music:cdbooMusic:edit")
	@RequestMapping(value = "save")
	public String save(CdbooMusic cdbooMusic, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cdbooMusic)){
			return form(cdbooMusic, model);
		}
		cdbooMusicService.save(cdbooMusic);
		addMessage(redirectAttributes, "保存歌曲信息成功");
		return "redirect:"+Global.getAdminPath()+"/music/cdbooMusic/?repage";
	}
	
	@RequiresPermissions("music:cdbooMusic:edit")
	@RequestMapping(value = "delete")
	public String delete(CdbooMusic cdbooMusic, RedirectAttributes redirectAttributes) {
		cdbooMusicService.delete(cdbooMusic);
		addMessage(redirectAttributes, "删除歌曲信息成功");
		return "redirect:"+Global.getAdminPath()+"/music/cdbooMusic/?repage";
	}
	
	/**
	 * 导入用户数据
	 * @param file
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("music:cdbooMusic:edit")
    @RequestMapping(value = "import", method=RequestMethod.POST)
	public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			cdbooMusicService.importMusicFile(file);
			addMessage(redirectAttributes, "导入歌曲信息成功");
		} catch (Exception e) {
			LogUtils.saveLog(Servlets.getRequest(), null, e, "导入歌曲");
			addMessage(redirectAttributes, "导入歌曲信息失败");
		}
		return "redirect:" + Global.getAdminPath() + "/music/cdbooMusic/?repage";
	}

}