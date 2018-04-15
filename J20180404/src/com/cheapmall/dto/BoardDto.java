package com.cheapmall.dto;

import java.util.Date;

public class BoardDto {
	/*
	 * Version 1.0
	 * 최초작성자 : 허진무
	 * 내용 : 게시판 Table DTO
	 */
	
	private String board_sq;
	private String user_id;
	private Date   write_dt;
	private String board_cd;
	private String content;
	private String object;
	private String board_p_cd;
	private String ip;
	private String subject;
	
	public String getBoard_sq() {
		return board_sq;
	}
	public void setBoard_sq(String board_sq) {
		this.board_sq = board_sq;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Date getWrite_dt() {
		return write_dt;
	}
	public void setWrite_dt(Date write_dt) {
		this.write_dt = write_dt;
	}
	public String getBoard_cd() {
		return board_cd;
	}
	public void setBoard_cd(String board_cd) {
		this.board_cd = board_cd;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getObject() {
		return object;
	}
	public void setObject(String object) {
		this.object = object;
	}
	public String getBoard_p_cd() {
		return board_p_cd;
	}
	public void setBoard_p_cd(String board_p_cd) {
		this.board_p_cd = board_p_cd;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
}
