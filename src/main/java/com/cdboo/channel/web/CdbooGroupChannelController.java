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
	public String list(CdbooChannel cdbooChannel, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CdbooChannel> page = cdbooChannelService.findPage(new Page<CdbooChannel>(request, response), cdbooChannel); 
		model.addAttribute("page", page);
		return "cdboo/groupChannel/cdbooChannelList";
	}
	
	@RequiresPermissions("channel:groupChannel:view")
	@RequestMapping(value = "form")
	public String form(CdbooChannel cdbooChannel, Model model, HttpServletRequest request) {
		model.addAttribute("cdbooChannel", cdbooChannel);

		String id = cdbooChannel.getId();
		if (StringUtils.isNotBlank(id)) {
			CdbooGroupChild cdbooGroupChild = new CdbooGroupChild();
			cdbooGroupChild.setGroupChannelId(cdbooChannel);
			List<CdbooChannel> childChannelList = cdbooGroupChildService
					.findCdbooChannelFromGroupChannel(cdbooGroupChild);
			cdbooChannel.setChildChannelList(childChannelList);
		} else {
			User user = UserUtils.getUser();
			List<CdbooChannel> userChannelList = cdbooUserChannelService.getChannelListByUser(user);
			cdbooChannel.setChildChannelList(userChannelList);
		}

		return "cdboo/groupChannel/cdbooChannelForm";
	}
	
	@RequiresPermissions("channel:groupChannel:edit")
	@RequestMapping(value = "save")
	public String save(CdbooChannel cdbooChannel, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request) {
		if (!beanValidator(model, cdbooChannel)){
			return form(cdbooChannel, model,request);
		}
		cdbooChannelService.save(cdbooChannel);
		addMessage(redirectAttributes, "保存频道信息成功");
		return "redirect:"+Global.getAdminPath()+"/channel/cdbooChannel/?repage";
	}
}
