package com.thinkgem.jeesite.common.utils;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.farng.mp3.MP3File;
import org.farng.mp3.id3.AbstractID3v2;
import org.farng.mp3.id3.ID3v1;

/**
 * 
 * mp3解析类
 * @author yubin
 *
 */
public class Mp3ResolveUtils {
	
	/**
	 *   TIT2=标题 表示内容为这首歌的标题,下同
		 TPE1=作者
		 TALB=专集
		 TRCK=音轨 格式:N/M        其中 N 为专集中的第 N 首,M 为专集中共 M 首,N 和 M 为 ASCII 码表示的数字
		 TYER=年代 是用 ASCII 码表示的数字
		 TCON=类型 直接用字符串表示
		 COMM=备注 格式:"eng/0 备注内容",其中 eng 表示备注所使用的自然语言
	 * @param mp3Path
	 * @return
	 * @throws Exception
	 */
	public static Map<String, Object> resolveMp3(String mp3Path) throws Exception {
		MP3File file = new MP3File(mp3Path);// 1,lyrics
		AbstractID3v2 id3v2 = file.getID3v2Tag();
		ID3v1 id3v1 = file.getID3v1Tag();

		String songName = "";// 歌曲名称
		String artist = "";// 歌手名字
		String album = "";// 专辑名称
		String track = "";// 音轨
		String year = "";// 年代
		String type = "";// 类型
		String comm = "";// 备注
		String authorComposer = "";// 作曲
		if (id3v2 != null) {
			songName = id3v2.getSongTitle();
			artist = id3v2.getLeadArtist();
			album = id3v2.getAlbumTitle();
			track = id3v2.getTrackNumberOnAlbum();
			year = id3v2.getYearReleased();
			type = id3v2.getSongGenre();
			comm = id3v2.getSongComment();
			authorComposer = id3v2.getAuthorComposer();
		} else {
			songName = id3v1.getSongTitle();
			artist = id3v1.getLeadArtist();
			album = id3v1.getAlbumTitle();
			track = id3v1.getTrackNumberOnAlbum();
			year = id3v1.getYearReleased();
			type = id3v1.getSongGenre();
			comm = id3v1.getSongComment();
			authorComposer = id3v1.getAuthorComposer();
		}

		Map<String, Object> mp3InfoMap = new HashMap<>();
		mp3InfoMap.put("songName", songName);
		mp3InfoMap.put("artist", artist);
		mp3InfoMap.put("album", album);
		mp3InfoMap.put("track", track);
		mp3InfoMap.put("year", year);
		mp3InfoMap.put("type", type);
		mp3InfoMap.put("comm", comm);
		mp3InfoMap.put("authorComposer", authorComposer);
		return mp3InfoMap;
	}

	/** 
     * @param args 
	 * @throws Exception 
     */  
    public static void main(String[] args) throws Exception {  
    	Map<String, Object> resolveMp3 = Mp3ResolveUtils.resolveMp3("C:\\Users\\Administrator\\Desktop\\音乐频道\\风格\\独立民谣（上午）（组合频道）\\民谣欢快男声 112\\Alan Pownall - Chasing Time.mp3");
    	Set<String> keySet = resolveMp3.keySet();
    	for (String key : keySet) {
			System.out.println(key+":"+resolveMp3.get(key));
		}
    	System.out.println("over");  
    }  
}
