/**
 * 
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.channel.service.CdbooChannelService;
import com.cdboo.childchannel.entity.CdbooGroupChild;
import com.cdboo.childchannel.service.CdbooGroupChildService;
import com.cdboo.userchannel.service.CdbooUserChannelService;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/channel/groupChannel")
public class CdbooGroupChannelController extends BaseController {
	
	@Autowired
	private CdbooChannelService cdbooChannelService;
	
	@Autowired
	private CdbooGroupChildService cdbooGroupChildService;
	
	@Autowired
	private CdbooUserChannelService cdbooUserChannelService;
	
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
	
	@RequiresPermissions("channel:groupChannel:view")
	@RequestMapping(value = {"list", ""})
	public String list(CdbooGroupChild cdbooGroupChild, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CdbooGroupChild> page = cdbooGroupChildService.findGroupList(new Page<CdbooGroupChild>(request,response),cdbooGroupChild);
		model.addAttribute("page", page);
		
		User user = cdbooGroupChild.getUserId();
		if(user!=null && StringUtils.isNotBlank(user.getId())){
			List<CdbooChannel> channelList = cdbooGroupChildService.findGroupChannelListByUserid(cdbooGroupChild);
			cdbooGroupChild.setChannelList(channelList);
		}
		
		return "cdboo/groupChannel/cdbooChannelList";
	}
	
	@RequiresPermissions("channel:groupChannel:view")
	@RequestMapping(value = "form")
	public String form(CdbooGroupChild cdbooGroupChild, Model model, HttpServletRequest request) {
		model.addAttribute("cdbooGroupChild", cdbooGroupChild);

		User userId = cdbooGroupChild.getUserId();
		CdbooChannel groupChannelId = cdbooGroupChild.getGroupChannelId();
		
		
		if(userId!=null && StringUtils.isNotBlank(userId.getId()) && groupChannelId!=null && StringUtils.isNotBlank(groupChannelId.getId())){
			List<CdbooChannel> list = cdbooGroupChildService.findChildChannelListByConditions(cdbooGroupChild);
			cdbooGroupChild.setChildChannelList(list);
			
			CdbooChannel cdbooChannel = cdbooChannelService.get(groupChannelId);
			cdbooGroupChild.setGroupChannelId(cdbooChannel);
		}
		else{
			User user = UserUtils.getUser();
			List<CdbooChannel> list = cdbooUserChannelService.getChannelListByUser(user);
			cdbooGroupChild.setChildChannelList(list);
		}

		return "cdboo/groupChannel/cdbooChannelForm";
	}
	
	@RequiresPermissions("channel:groupChannel:edit")
	@RequestMapping(value = "save")
	public String save(CdbooGroupChild cdbooGroupChild, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request) {
		if (!beanValidator(model, cdbooGroupChild)){
			return form(cdbooGroupChild, model,request);
		}
		cdbooGroupChildService.save(cdbooGroupChild);
		addMessage(redirectAttributes, "保存频道信息成功");
		return "redirect:"+Global.getAdminPath()+"/channel/cdbooChannel/?repage";
	}
	
	@RequestMapping(value = "getGroupChannelList")
	@ResponseBody
	public List<CdbooChannel> getGroupChannelList(@RequestParam(required=true) String userId){
		CdbooGroupChild cdbooGroupChild = new CdbooGroupChild();
		User user = new User(userId);
		cdbooGroupChild.setUserId(user);
		
		List<CdbooChannel> channelList = cdbooGroupChildService.findGroupChannelListByUserid(cdbooGroupChild);
		return channelList;
	}
}
