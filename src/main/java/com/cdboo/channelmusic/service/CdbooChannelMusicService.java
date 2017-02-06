/**
 * 
 */
package com.cdboo.channelmusic.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.channelmusic.dao.CdbooChannelMusicDao;
import com.cdboo.channelmusic.entity.CdbooChannelMusic;
import com.cdboo.music.dao.CdbooMusicDao;
import com.cdboo.music.entity.CdbooMusic;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * @author yubin
 *
 */
@Service
@Transactional(readOnly = true)
public class CdbooChannelMusicService extends CrudService<CdbooChannelMusicDao, CdbooChannelMusic> {

	@Autowired
	private CdbooMusicDao cdbooMusicDao;
	
	/**
	 * 
	 * @param cdbooChannel
	 */
	@Transactional(readOnly = false)
	public void editChannelMusicSort(CdbooChannel cdbooChannel) {
		List<CdbooChannelMusic> cdbooChannelMusics = cdbooChannel.getCdbooChannelMusics();
		if (CollectionUtils.isNotEmpty(cdbooChannelMusics)) {
			for (CdbooChannelMusic cdbooChannelMusic : cdbooChannelMusics) {
				Integer sort = cdbooChannelMusic.getSort();
				String channelMusicId = cdbooChannelMusic.getId();
				CdbooChannelMusic channelMusic = get(channelMusicId);
				channelMusic.setSort(sort);
				super.save(channelMusic);
			}
		}
	}
	
	/**
	 * 统一编辑频道内音乐音量
	 * @param cdbooChannel 频道对象
	 */
	@Transactional(readOnly = false)
	public void editChannelMusicVolume(CdbooChannel cdbooChannel) {
		CdbooChannelMusic channelMusic = new CdbooChannelMusic();
		channelMusic.setChannel(cdbooChannel);
		List<CdbooChannelMusic> channelMusicList = super.findList(channelMusic);
		if(CollectionUtils.isNotEmpty(channelMusicList)){
			String volume = cdbooChannel.getVolume();
			for (CdbooChannelMusic cdbooChannelMusic : channelMusicList) {
				CdbooMusic music = cdbooChannelMusic.getMusic();
				String musicId = music.getId();
				CdbooMusic cdbooMusic = cdbooMusicDao.get(musicId);
				cdbooMusic.setVolume(volume);
				cdbooMusic.setUpdateDate(new Date());
				cdbooMusic.setUpdateBy(UserUtils.getUser());
				cdbooMusicDao.update(cdbooMusic);
			}
		}
	}

}