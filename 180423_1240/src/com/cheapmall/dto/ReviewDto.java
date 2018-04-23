package com.cheapmall.dto;

import java.util.Date;

public class ReviewDto {
	/*
	 * Version 1.0
	 * 최초작성자 : 허진무
	 * 내용 : 관리자 Table DTO
	 */
	
	private String 	sq;
	private String 	user_id;
	private Date	write_dt;
	private String	content;
	private int		cnt;
	private int		up;
	private	int		down;
	private int		star;
	private String	goods_cd;
	private String	ip;
	private	String	path;
	
	public String getSq() {
		return sq;
	}
	public void setSq(String sq) {
		this.sq = sq;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getUp() {
		return up;
	}
	public void setUp(int up) {
		this.up = up;
	}
	public int getDown() {
		return down;
	}
	public void setDown(int down) {
		this.down = down;
	}
	public int getStar() {
		return star;
	}
	public void setStar(int star) {
		this.star = star;
	}
	public String getGoods_cd() {
		return goods_cd;
	}
	public void setGoods_cd(String goods_cd) {
		this.goods_cd = goods_cd;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
}
