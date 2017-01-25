/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.channel.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.channel.service.CdbooChannelService;
import com.cdboo.channelmusic.entity.CdbooChannelMusic;
import com.cdboo.channelmusic.service.CdbooChannelMusicService;
import com.cdboo.childchannel.entity.CdbooGroupChild;
import com.cdboo.childchannel.service.CdbooGroupChildService;
import com.cdboo.common.Constants;
import com.cdboo.music.service.CdbooMusicService;
import com.cdboo.usergroup.entity.CdbooUserGroup;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.web.Servlets;
import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.LogUtils;

/**
 * 频道管理Controller
 * 
 * @author 于滨
 * @version 2016-12-17
 */
@Controller
@RequestMapping(value = "${adminPath}/channel/cdbooChannel")
public class CdbooChannelController extends BaseController {

	@Autowired
	private CdbooChannelService cdbooChannelService;

	@Autowired
	private CdbooGroupChildService cdbooGroupChildService;

	@Autowired
	private CdbooMusicService cdbooMusicService;

	@Autowired
	private CdbooChannelMusicService cdbooChannelMusicService;

	@ModelAttribute
	public CdbooChannel get(@RequestParam(required = false) String id) {
		CdbooChannel entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = cdbooChannelService.get(id);
		}
		if (entity == null) {
			entity = new CdbooChannel();
		}
		return entity;
	}

	@RequiresPermissions("channel:cdbooChannel:view")
	@RequestMapping(value = { "list", "" })
	public String list(CdbooChannel cdbooChannel, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		cdbooChannel.setChannelType(Constants.CHANNEL_TYPE_CHILD);
		Page<CdbooChannel> page = cdbooChannelService.findPage(new Page<CdbooChannel>(request, response), cdbooChannel);
		model.addAttribute("page", page);

		setThemeConcreteTypeListToRequest(cdbooChannel, request);

		return "cdboo/channel/cdbooChannelList";
	}

	private void setThemeConcreteTypeListToRequest(CdbooChannel cdbooChannel, HttpServletRequest request) {
		String themeType = cdbooChannel.getThemeType();
		if (StringUtils.isNotBlank(themeType)) {
			List<Dict> dictList = Lists.newArrayList();
			if (StringUtils.equals(themeType, Constants.THEMETYPE_THEME)) {
				dictList = DictUtils.getDictList(Constants.DICT_SEASON_TYPE_NAME);
			}
			if (StringUtils.equals(themeType, Constants.THEMETYPE_HOLIDAY)) {
				dictList = DictUtils.getDictList(Constants.DICT_HOLIDAY_TYPE_NAME);
			}
			if (StringUtils.equals(themeType, Constants.THEMETYPE_STYLE)) {
				dictList = DictUtils.getDictList(Constants.DICT_STYLE_TYPE_NAME);
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
	@RequestMapping(value = "mapping")
	public String mapping(CdbooChannel cdbooChannel, Model model, HttpServletRequest request) {

		model.addAttribute("cdbooChannel", cdbooChannel);

		/***** 关联音乐的频道只能是子频道，组合频道不能再被组合 Start ******/
		CdbooChannel queryChannel = new CdbooChannel();
		queryChannel.setChannelType(Constants.CHANNEL_TYPE_CHILD);
		List<CdbooChannel> channelList = cdbooChannelService.findList(queryChannel);
		request.setAttribute("channelList", channelList);
		/***** 关联音乐的频道只能是子频道，组合频道不能再被组合 End ******/

		return "cdboo/channel/cdbooChannelMusicMapping";
	}

	@RequiresPermissions("channel:cdbooChannel:edit")
	@RequestMapping(value = "save")
	public String save(CdbooChannel cdbooChannel, Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request) {
		if (!beanValidator(model, cdbooChannel)) {
			return form(cdbooChannel, model, request);
		}
		cdbooChannelService.save(cdbooChannel);
		addMessage(redirectAttributes, "保存频道信息成功");
		return "redirect:" + Global.getAdminPath() + "/channel/cdbooChannel/?repage";
	}

	@RequestMapping(value = "saveMapping")
	public String saveMapping(CdbooChannel cdbooChannel, Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request) {
		cdbooChannelService.save(cdbooChannel);
		addMessage(redirectAttributes, "保存频道信息成功");
		return "redirect:" + Global.getAdminPath() + "/channel/cdbooChannel/?repage";
	}

	@RequiresPermissions("channel:cdbooChannel:edit")
	@RequestMapping(value = "delete")
	public String delete(CdbooChannel cdbooChannel, RedirectAttributes redirectAttributes) {
		cdbooChannelService.delete(cdbooChannel);
		addMessage(redirectAttributes, "删除频道信息成功");
		return "redirect:" + Global.getAdminPath() + "/channel/cdbooChannel/?repage";
	}

	@RequestMapping(value = { "openChannelWin" })
	public String openChannelWin(CdbooChannel cdbooChannel, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		String userId = cdbooChannel.getUserId();
		Page<CdbooChannel> page = null;
		if (StringUtils.isNotBlank(userId)) {
			page = cdbooChannelService.findPageByUserId(new Page<CdbooChannel>(request, response), cdbooChannel);
		} else {
			page = cdbooChannelService.findPage(new Page<CdbooChannel>(request, response), cdbooChannel);
		}
		model.addAttribute("page", page);
		return "cdboo/channel/cdbooChannelOpenWin";
	}

	@RequestMapping(value = { "getGroupChannelInfo" })
	@ResponseBody
	public CdbooUserGroup getGroupChannelInfo(@RequestParam(required = true) String groupChannelId) {
		CdbooUserGroup cdbooUserGroup = new CdbooUserGroup();

		CdbooChannel cdbooChannel = cdbooChannelService.get(groupChannelId);
		if (cdbooChannel != null) {
			String channelType = cdbooChannel.getChannelType();
			if (StringUtils.equals(Constants.CHANNEL_TYPE_GROUP, channelType)) {
				CdbooGroupChild cdbooGroupChild = new CdbooGroupChild();
				cdbooGroupChild.setGroupChannelId(cdbooChannel);
				List<CdbooGroupChild> groupChilds = cdbooGroupChildService.findList(cdbooGroupChild);

				if (CollectionUtils.isNotEmpty(groupChilds)) {
					for (CdbooGroupChild groupChild : groupChilds) {
						CdbooChannel childChannel = groupChild.getChildChannelId();
						String theme = childChannel.getThemeType();
						String themeConcreteType = childChannel.getThemeConcreteType();
						childChannel.setThemeType(DictUtils.getDictLabel(theme, "theme_type", ""));
						if (StringUtils.equals(Constants.THEMETYPE_THEME, theme)) {
							childChannel
									.setThemeConcreteType(DictUtils.getDictLabel(themeConcreteType, "season_type", ""));
						}
						if (StringUtils.equals(Constants.THEMETYPE_HOLIDAY, theme)) {
							childChannel.setThemeConcreteType(
									DictUtils.getDictLabel(themeConcreteType, "holiday_type", ""));
						}
					}
				}

				cdbooUserGroup.setGroupChildChannelList(groupChilds);
			}
		}
		return cdbooUserGroup;
	}

	/**
	 * 导入用户数据
	 * 
	 * @param file
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("channel:cdbooChannel:edit")
	@RequestMapping(value = "import", method = RequestMethod.POST)
	public String importFile(@RequestParam(required = true) String channelId, MultipartFile file,
			RedirectAttributes redirectAttributes) {
		try {
			cdbooMusicService.importMusicFile(file, channelId);
			addMessage(redirectAttributes, "导入歌曲信息成功");
		} catch (Exception e) {
			LogUtils.saveLog(Servlets.getRequest(), null, e, "导入歌曲");
			addMessage(redirectAttributes, "导入歌曲信息失败");
		}
		return "redirect:" + Global.getAdminPath() + "/channel/cdbooChannel/?repage";
	}

	/**
	 * 导入用户数据
	 * 
	 * @param file
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "openChannelMusicWin")
	public String openChannelMusicWin(CdbooChannel cdbooChannel, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		CdbooChannelMusic cdbooChannelMusic = new CdbooChannelMusic();
		cdbooChannelMusic.setChannel(cdbooChannel);
		List<CdbooChannelMusic> list = cdbooChannelMusicService.findList(cdbooChannelMusic);
		model.addAttribute("cdbooChannelMusics", list);
		return "cdboo/channel/cdbooChannelMusicList";
	}
	
	@RequiresPermissions("channel:cdbooChannel:edit")
	@RequestMapping(value = "channelMusicSave")
	public String channelMusicSave(CdbooChannel cdbooChannel,RedirectAttributes redirectAttributes){
		try {
			cdbooChannelMusicService.editChannelMusicSort(cdbooChannel);
			addMessage(redirectAttributes, "编辑歌曲顺序成功");
		} catch (Exception e) {
			LogUtils.saveLog(Servlets.getRequest(), null, e, "编辑歌曲顺序");
			addMessage(redirectAttributes, "编辑歌曲顺序失败");
		}
		redirectAttributes.addFlashAttribute("cdbooChannel", cdbooChannel);
		return "redirect:" + Global.getAdminPath() + "/channel/cdbooChannel/openChannelMusicWin";
	}
	
	@RequiresPermissions("channel:cdbooChannel:edit")
	@RequestMapping(value = "setVolume")
	public String setVolume(CdbooChannel cdbooChannel,RedirectAttributes redirectAttributes){
		try {
			cdbooChannelMusicService.editChannelMusicVolume(cdbooChannel);
			addMessage(redirectAttributes, "编辑音量成功");
		} catch (Exception e) {
			LogUtils.saveLog(Servlets.getRequest(), null, e, "根据频道编辑音量");
			addMessage(redirectAttributes, "编辑音量失败");
		}
		return "redirect:" + Global.getAdminPath() + "/channel/cdbooChannel/?repage";
	}
}