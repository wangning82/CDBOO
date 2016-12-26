/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.usermusic.web.user;

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

import com.cdboo.music.entity.CdbooMusic;
import com.cdboo.usermusic.entity.CdbooOwnerMusic;
import com.cdboo.usermusic.service.CdbooOwnerMusicService;
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
@RequestMapping(value = "${adminPath}/usermusic/ownerMusic")
public class OwnerMusicController extends BaseController {

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
	
	@RequiresPermissions("usermusic:ownerMusic:view")
	@RequestMapping(value = {"list", ""})
	public String list(CdbooOwnerMusic cdbooOwnerMusic, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CdbooOwnerMusic> page = cdbooOwnerMusicService.findPage(new Page<CdbooOwnerMusic>(request, response), cdbooOwnerMusic); 
		model.addAttribute("page", page);
		
		User currentUser = UserUtils.getUser();
		cdbooOwnerMusic.setUser(currentUser);
		
		List<CdbooMusic> cdbooMusics = cdbooOwnerMusicService.getMusicByUser(currentUser);
		cdbooOwnerMusic.setMusicList(cdbooMusics);
		
		return "cdboo/usermusic/user/cdbooOwnerMusicList";
	}
}