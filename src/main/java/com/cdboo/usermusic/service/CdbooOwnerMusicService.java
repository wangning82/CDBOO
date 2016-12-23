/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.usermusic.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cdboo.music.entity.CdbooMusic;
import com.cdboo.music.service.CdbooMusicService;
import com.cdboo.usermusic.dao.CdbooOwnerMusicDao;
import com.cdboo.usermusic.entity.CdbooOwnerMusic;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 用户曲库信息Service
 * @author yubin
 * @version 2016-12-21
 */
@Service
@Transactional(readOnly = true)
public class CdbooOwnerMusicService extends CrudService<CdbooOwnerMusicDao, CdbooOwnerMusic> {

	@Autowired
	private CdbooMusicService cdbooMusicService;
	
	public CdbooOwnerMusic get(String id) {
		return super.get(id);
	}
	
	public List<CdbooOwnerMusic> findList(CdbooOwnerMusic cdbooOwnerMusic) {
		return super.findList(cdbooOwnerMusic);
	}
	
	public Page<CdbooOwnerMusic> findPage(Page<CdbooOwnerMusic> page, CdbooOwnerMusic cdbooOwnerMusic) {
		Page<CdbooOwnerMusic> findPage = super.findPage(page, cdbooOwnerMusic);
		List<CdbooOwnerMusic> list = findPage.getList();
		if(CollectionUtils.isNotEmpty(list)){
			for (CdbooOwnerMusic cdbooOwnerMusic2 : list) {
				
				String userId = cdbooOwnerMusic2.getUser().getId();
				User user = UserUtils.get(userId);
				
				String musicId = cdbooOwnerMusic2.getMusicId().getId();
				CdbooMusic cdbooMusic = cdbooMusicService.get(musicId);
				
				cdbooOwnerMusic2.setUser(user);
				cdbooOwnerMusic2.setMusicId(cdbooMusic);
			}
		}
		return findPage;
	}
	
	@Transactional(readOnly = false)
	public void save(CdbooOwnerMusic cdbooOwnerMusic) {

		/******************* 把音乐id集合转成音乐对象集合 Start ********************/
		List<String> musicIdList = cdbooOwnerMusic.getMusicIds();
		String musicIds = StringUtils.join(musicIdList.toArray(), ",");
		List<CdbooMusic> musicList = Lists.newArrayList();
		if (StringUtils.isNotBlank(musicIds)) {
			CdbooMusic cdbooMusic = new CdbooMusic();
			cdbooMusic.setInIds(musicIds);
			musicList = cdbooMusicService.findList(cdbooMusic);
		}
		/******************* 把音乐id集合转成音乐对象集合 End ********************/

		/*******************
		 * 将原先库里对应用户以及音乐的关联信息封装成map，key是音乐id，值为映射对象，准备下一步过滤操作 Start
		 ********************/
		User user = cdbooOwnerMusic.getUser();
		CdbooOwnerMusic ownerMusic = new CdbooOwnerMusic();
		ownerMusic.setUser(user);
		List<CdbooOwnerMusic> cdbooOwnerMusics = super.findList(ownerMusic);
		Map<String, CdbooOwnerMusic> musicMap = new HashMap<>();
		if (CollectionUtils.isNotEmpty(cdbooOwnerMusics)) {
			for (CdbooOwnerMusic cdbooOwnerMusic2 : cdbooOwnerMusics) {
				String musicId = cdbooOwnerMusic2.getMusicId().getId();
				musicMap.put(musicId, cdbooOwnerMusic2);
			}
		}
		/*******************
		 * 将原先库里对应用户以及音乐的关联信息封装成map，key是音乐id，值为映射对象，准备下一步过滤操作 End
		 ********************/

		/*******************
		 * 过滤加移除，看哪些音乐是原先库里没有的，创建映射对象，存在的则直接移除 Start
		 ********************/
		List<CdbooOwnerMusic> saveList = Lists.newArrayList();
		if (CollectionUtils.isNotEmpty(musicList)) {
			for (CdbooMusic music : musicList) {
				@SuppressWarnings("unused")
				CdbooOwnerMusic tempObj = null;
				if ((tempObj = musicMap.remove(music.getId())) == null) {
					CdbooOwnerMusic saveObj = new CdbooOwnerMusic();
					saveObj.setUser(user);
					saveObj.setMusicId(music);
					saveList.add(saveObj);
				}
			}
		}
		/*******************
		 * 过滤加移除，看哪些是原先库里没有的，创建映射对象，存在的则直接移除 End
		 ********************/

		/*******************
		 * 过滤加移除后map中剩下的就是被前台移除的音乐，取出准备下一步数据库操作 Start
		 ********************/
		List<CdbooOwnerMusic> delList = null;
		if (MapUtils.isNotEmpty(musicMap)) {
			delList = Lists.newArrayList(musicMap.values());
		}
		/*******************
		 * 过滤加移除后map中剩下的就是被前台移除的音乐，取出准备下一步数据库操作 Start
		 ********************/

		if (CollectionUtils.isNotEmpty(saveList)) {
			for (CdbooOwnerMusic saveObj : saveList) {
				super.save(saveObj);
			}
		}

		if (CollectionUtils.isNotEmpty(delList)) {
			for (CdbooOwnerMusic delObj : delList) {
				dao.remove(delObj);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(CdbooOwnerMusic cdbooOwnerMusic) {
		super.delete(cdbooOwnerMusic);
	}
	
	/**
	 * 根据用户查询他的曲库
	 * @param user 用户
	 * @return 曲库信息
	 * @author yubin
	 */
	public List<CdbooMusic> getMusicByUser(User user) {
		CdbooOwnerMusic cdbooOwnerMusic = new CdbooOwnerMusic();
		cdbooOwnerMusic.setUser(user);
		List<CdbooOwnerMusic> ownerMusics = super.findList(cdbooOwnerMusic);
		List<CdbooMusic> musics = Lists.newArrayList();
		if (CollectionUtils.isNotEmpty(ownerMusics)) {
			for (CdbooOwnerMusic cdbooOwnerMusic2 : ownerMusics) {
				String musicId = cdbooOwnerMusic2.getMusicId().getId();
				CdbooMusic cdbooMusic = cdbooMusicService.get(musicId);
				musics.add(cdbooMusic);
			}
		}

		return musics;
	}
}