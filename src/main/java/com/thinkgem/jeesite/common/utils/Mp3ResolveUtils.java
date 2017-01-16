package com.thinkgem.jeesite.common.utils;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import org.jaudiotagger.audio.AudioFileIO;
import org.jaudiotagger.audio.exceptions.CannotReadException;
import org.jaudiotagger.audio.exceptions.InvalidAudioFrameException;
import org.jaudiotagger.audio.exceptions.ReadOnlyFileException;
import org.jaudiotagger.audio.mp3.MP3AudioHeader;
import org.jaudiotagger.audio.mp3.MP3File;
import org.jaudiotagger.tag.Tag;
import org.jaudiotagger.tag.TagException;
import org.jaudiotagger.tag.id3.ID3v24Frames;

public class Mp3ResolveUtils {
	
	public static Map<String, Object> resolveMp3(String mp3Path)
			throws CannotReadException, IOException, TagException, ReadOnlyFileException, InvalidAudioFrameException {
		
		MP3File f = (MP3File) AudioFileIO.read(new File(mp3Path));
		Tag tag = null;

		String songName = "";// 歌曲名称
		String artist = "";// 歌手名字
		String album = "";// 专辑名称
		String track = "";// 音轨
		String year = "";// 年代
		String type = "";// 类型
		String comm = "";// 备注

		if (f.hasID3v2Tag()) {
			// 是否存在id3v2的标签
			tag = f.getID3v2Tag();
		} else {
			// 如果不存在id3v2的标签，判断是否存在id3v1的标签
			if (f.hasID3v1Tag()) {
				tag = f.getTag();
			}
		}

		Map<String, Object> mp3InfoMap = new HashMap<>();

		if (tag != null) {
			songName = tag.getFirst(ID3v24Frames.FRAME_ID_TITLE);
			artist = tag.getFirst(ID3v24Frames.FRAME_ID_ARTIST);
			album = tag.getFirst(ID3v24Frames.FRAME_ID_ALBUM);
			year = tag.getFirst(ID3v24Frames.FRAME_ID_YEAR);
			track = tag.getFirst(ID3v24Frames.FRAME_ID_TRACK);
			type = tag.getFirst(ID3v24Frames.FRAME_ID_GENRE);
			comm = tag.getFirst(ID3v24Frames.FRAME_ID_COMMENT);

			mp3InfoMap.put("songName", songName);
			mp3InfoMap.put("artist", artist);
			mp3InfoMap.put("album", album);
			mp3InfoMap.put("track", track);
			mp3InfoMap.put("year", year);
			mp3InfoMap.put("type", type);
			mp3InfoMap.put("comm", comm);
			
			String musicLength = getMusicLength(f);
			mp3InfoMap.put("duration", musicLength);
		}
		
		return mp3InfoMap;
	}
	
	public static String getMusicLength(MP3File f) {
		MP3AudioHeader audioHeader = (MP3AudioHeader) f.getAudioHeader();
		String trackLength = audioHeader.getTrackLengthAsString();
		String[] time = StringUtils.split(trackLength, ":");
		String str = "";
		if (time.length == 1) {
			int s = Integer.parseInt(time[0]);
			if (s < 10) {
				str = "00:00:0" + s;
			} else {
				str = "00:00:" + s;
			}
		} else if (time.length == 2) {
			int m = Integer.parseInt(time[0]);
			if (m < 10) {
				str = "00:0" + m;
			} else {
				str = "00:" + m;
			}

			int s = Integer.parseInt(time[1]);
			if (s < 10) {
				str += ":0" + s;
			} else {
				str += ":" + s;
			}
		} else if (time.length == 3) {
			int h = Integer.parseInt(time[0]);
			if (h < 10) {
				str = "0" + h;
			} else {
				str = "" + h;
			}

			int m = Integer.parseInt(time[1]);
			if (m < 10) {
				str += ":0" + m;
			} else {
				str += ":" + m;
			}

			int s = Integer.parseInt(time[2]);
			if (s < 10) {
				str += ":0" + s;
			} else {
				str += ":" + s;
			}
		}
		return str;
	}
	
	public static void main(String[] args) throws CannotReadException, IOException, TagException, ReadOnlyFileException, InvalidAudioFrameException {
		Map<String, Object> resolveMp3 = Mp3ResolveUtils.resolveMp3("C:\\Users\\Administrator\\Desktop\\音乐频道\\风格\\独立民谣（上午）（组合频道）\\民谣欢快男声 112\\Jason Mraz - I'm Yours.mp3");
		Set<String> keySet = resolveMp3.keySet();
		for (String key : keySet) {
			System.out.println(key+":"+resolveMp3.get(key));
		}
	}
}
