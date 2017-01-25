/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.music.service;

import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.jaudiotagger.audio.exceptions.CannotReadException;
import org.jaudiotagger.audio.exceptions.InvalidAudioFrameException;
import org.jaudiotagger.audio.exceptions.ReadOnlyFileException;
import org.jaudiotagger.tag.TagException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.channel.service.CdbooChannelService;
import com.cdboo.channelmusic.entity.CdbooChannelMusic;
import com.cdboo.channelmusic.service.CdbooChannelMusicService;
import com.cdboo.common.Constants;
import com.cdboo.music.dao.CdbooMusicDao;
import com.cdboo.music.entity.CdbooMusic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.FileUtils;
import com.thinkgem.jeesite.common.utils.Mp3ResolveUtils;
import com.thinkgem.jeesite.common.web.Servlets;
import com.thinkgem.jeesite.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 曲库管理Service
 * @author yubin
 * @version 2016-12-13
 */
@Service
@Transactional(readOnly = true)
public class CdbooMusicService extends CrudService<CdbooMusicDao, CdbooMusic> {

	@Autowired
	private CdbooChannelService cdbooChannelService;
	
	@Autowired
	private CdbooChannelMusicService cdbooChannelMusicService;
	
	public CdbooMusic get(String id) {
		return super.get(id);
	}
	
	public List<CdbooMusic> findList(CdbooMusic cdbooMusic) {
		return super.findList(cdbooMusic);
	}
	
	public Page<CdbooMusic> findPage(Page<CdbooMusic> page, CdbooMusic cdbooMusic) {
		return super.findPage(page, cdbooMusic);
	}
	
	public Page<CdbooMusic> findPageByUserId(Page<CdbooMusic> page, CdbooMusic cdbooMusic) {
		cdbooMusic.setPage(page);
		List<CdbooMusic> list = dao.findListFromUserId(cdbooMusic);
		page.setList(list);
		return page;
	}
	
	/**
	 * 获得音乐绝对路径
	 * @param path
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public String getMusicPath(String path) throws UnsupportedEncodingException {
		String baseDir = Global.getUserfilesBaseDir();
		baseDir = baseDir.substring(0, baseDir.lastIndexOf("\\"));
		baseDir = baseDir.substring(0, baseDir.lastIndexOf("\\"));
		try {
			String decodePath = URLDecoder.decode(path, "utf-8");
			return baseDir + "/" + decodePath;
		} catch (UnsupportedEncodingException e1) {
			throw e1;
		}
	}
	
	@Transactional(readOnly = false)
	public void save(CdbooMusic cdbooMusic){
		super.save(cdbooMusic);
	}
	
	/**
	 * 保存音乐
	 * @param cdbooMusic
	 * @throws Exception
	 */
	@Transactional(readOnly = false)
	public void saveMusic(CdbooMusic cdbooMusic) throws Exception {
		try {
			String path = getMusicPath(cdbooMusic.getPath());
			Map<String, Object> result = Mp3ResolveUtils.resolveMp3(path);
			cdbooMusic.setMusicName(Objects.toString(result.get("songName")));//歌曲名称
			cdbooMusic.setActor(Objects.toString(result.get("artist")));//歌手
			cdbooMusic.setSpecial(Objects.toString(result.get("album")));//专辑
			cdbooMusic.setDuration(Objects.toString(result.get("duration")));
		} catch (Exception e) {
			throw e;
		}
		super.save(cdbooMusic);
	}
	
	public synchronized int getMaxMusicNo(){
		List<CdbooMusic> maxMusicNo = dao.getMaxMusicNo();
		if(CollectionUtils.isNotEmpty(maxMusicNo)){
			CdbooMusic cdbooMusic = maxMusicNo.get(0);
			if(cdbooMusic!=null){
				Integer musicNo = cdbooMusic.getMusicNo();
				if(musicNo!=null){
					return musicNo+1;
				}
			}
		}
		return 1;
	}
	
	@Transactional(readOnly = false)
	public void delete(CdbooMusic cdbooMusic) {
		super.delete(cdbooMusic);
	}
	
	
	@Transactional(readOnly=false)
	public void importMusicFile(MultipartFile file,String channelId) throws Exception {
		File tempPath = null;
		File tempFile = null;
		try {
			/****************** 创建临时目录，把上传的zip文件拷贝过去 Start *******************/
			String tempFilePath = Global.getUserfilesBaseDir()+"/temp";
			tempPath = new File(tempFilePath);
			if (!tempPath.exists() || !tempPath.isDirectory()) {
				tempPath.mkdir(); // 如果不存在，则创建该文件夹
			}
			tempFile = File.createTempFile("musicZip", ".zip", tempPath);
			file.transferTo(tempFile);
			/****************** 创建临时目录，把上传的zip文件拷贝过去 End *******************/

			/****************** 获得当前时间的年月 Start *******************/
			Calendar now = Calendar.getInstance();
			String year = now.get(Calendar.YEAR) + "";
			String month = (now.get(Calendar.MONTH)+1) + "";
			/****************** 获得当前时间的年月 End *******************/

			/****************** 解压文件 Start *******************/
			FileUtils.unZipFiles(tempFile.getAbsolutePath(), tempFilePath+"/");
			/****************** 解压文件 End *******************/

			/******************
			 * 从临时文件目录下过滤出扩展名是mp3的文件集合 Start
			 *******************/
			File[] mp3Files = tempPath.listFiles(new FileFilter() {
				@Override
				public boolean accept(File pathname) {
					System.out.println(pathname.getName());
					if (pathname.getName().endsWith(".mp3")) {
						return true;
					}
					return false;
				}
			});
			/****************** 从临时文件目录下过滤出扩展名是mp3的文件集合 End *******************/

			if (mp3Files != null && mp3Files.length > 0) {// 如果mp3文件存在
				
				Principal principal = (Principal) UserUtils.getPrincipal();
				
				String dir = FileUtils.path(Servlets.getRequest().getContextPath() + Global.USERFILES_BASE_URL + principal + "/");
				
				String path = FileUtils.path(Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL + principal + "/");
				
				// 获取项目内部mp3文件待上传路径
				String realPath = path + "media" + "/" + "music" + "/" + year + "/" + month;
				String realDir = dir + "media" + "/" + "music" + "/" + year + "/" + month;
				
				int maxMusicNo = getMaxMusicNo();
				for (int i = 0; i < mp3Files.length; i++) {
					File mp3File = mp3Files[i];
					String destMp3Path = null;
					String destMp3Dir = null;
					try {
						String orgMp3Path = mp3File.getAbsolutePath();// 临时目录下mp3绝对路径
						String mp3Name = mp3File.getName();// 临时目录下mp3名称
						destMp3Path = realPath + "/" + mp3Name;// 真是目录下mp3绝对路径
						destMp3Dir = realDir + "/" + mp3Name;
						// 拷贝文件到真实路径
						boolean copyFileFlag = FileUtils.copyFile(orgMp3Path, destMp3Path);

						if (copyFileFlag) {// 拷贝成功走下面

							/******************
							 * 创建音乐文件记录，保存到数据库中 Start
							 *******************/
							Map<String, Object> result = Mp3ResolveUtils.resolveMp3(destMp3Path);
							CdbooMusic cdbooMusic = new CdbooMusic();
							cdbooMusic.setMusicNo(maxMusicNo++);
							cdbooMusic.setMusicName(Objects.toString(result.get("songName")));//歌曲名称
							cdbooMusic.setActor(Objects.toString(result.get("artist")));//歌手
							cdbooMusic.setSpecial(Objects.toString(result.get("album")));//专辑
							cdbooMusic.setDuration(Objects.toString(result.get("duration")));
							cdbooMusic.setCreateBy(UserUtils.getUser());
							cdbooMusic.setCreateDate(new Date());
							cdbooMusic.setDelFlag(CdbooMusic.DEL_FLAG_NORMAL);
							cdbooMusic.setMusicOwner(Constants.MUSICOWNER_PUBLIC);
							cdbooMusic.setPath(destMp3Dir);
							cdbooMusic.setVolume(Constants.MUSIC_VOLUME_DEFAULT);
							save(cdbooMusic);
							
							/******************
							 * 创建音乐文件记录并保存到数据库后需要跟频道进行关联，这样就直接放到对应的频道列表里了 Start
							 *******************/
							CdbooChannel cdbooChannel = cdbooChannelService.get(channelId);
							CdbooChannelMusic cdbooChannelMusic = new CdbooChannelMusic();
							cdbooChannelMusic.setChannel(cdbooChannel);
							cdbooChannelMusic.setMusic(cdbooMusic);
							cdbooChannelMusic.setSort(0);
							cdbooChannelMusicService.save(cdbooChannelMusic);
							/******************
							 * 创建音乐文件记录并保存到数据库后需要跟频道进行关联，这样就直接放到对应的频道列表里了 End
							 *******************/
							/******************
							 * 创建音乐文件记录，保存到数据库中 End
							 *******************/
						}
						else{
							throw new Exception("拷贝歌曲失败");
						}
					} catch (Exception e) {
						e.printStackTrace();
						
						//如果数据库保存失败，需要把之前拷贝的文件也跟着删除，实现数据文件存在一致性
						if(StringUtils.isNotBlank(destMp3Path)){
							File destMp3File = new File(destMp3Path);
							if (destMp3File.exists()) {
								destMp3File.delete();
							}
						}
					} finally {
						// 不论成功失败，即时删除临时文件
						if (mp3File.exists()) {
							mp3File.delete();
						}
					}
				}
			}
		} catch (Exception e) {
			throw e;
		}finally {
			// 不论成功失败，即时删除临时文件
			if (tempFile.exists()) {
				tempFile.delete();
			}
		}
	}
	
	public static void main(String[] args) throws CannotReadException, IOException, TagException, ReadOnlyFileException, InvalidAudioFrameException {
		String path = "/cdboo/userfiles/1/media/music/2017/01/%E4%BD%99%E6%B3%A2%E8%8D%A1%E6%BC%BE.mp3";
		path = URLDecoder.decode(path, "utf-8");
//		Map<String, Object> resolveMp3 = Mp3ResolveUtils.resolveMp3("D:\\workspace-cdboo\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\CDBOO\\userfiles\\1\\media\\music\\2017\\01\\余波荡漾.mp3");
//		System.out.println(resolveMp3.toString());
		System.out.println(path);
	}
}