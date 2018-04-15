package com.cheapmall.dto;

import java.util.Date;

public class ReturnsDto {
	/*
	 * Version 1.0
	 * 최초작성자 : 허진무
	 * 내용 : 반품 Table DTO
	 */
	
	private String return_sq;
	private String user_id;
	private String detail_sq;
	private int    cnt;
	private String return_cd;
	private int    delivery_fee;
	private Date   return_dt;
	
	public String getReturn_sq() {
		return return_sq;
	}
	public void setReturn_sq(String return_sq) {
		this.return_sq = return_sq;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getDetail_sq() {
		return detail_sq;
	}
	public void setDetail_sq(String detail_sq) {
		this.detail_sq = detail_sq;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getReturn_cd() {
		return return_cd;
	}
	public void setReturn_cd(String return_cd) {
		this.return_cd = return_cd;
	}
	public int getDelivery_fee() {
		return delivery_fee;
	}
	public void setDelivery_fee(int delivery_fee) {
		this.delivery_fee = delivery_fee;
	}
	public Date getReturn_dt() {
		return return_dt;
	}
	public void setReturn_dt(Date return_dt) {
		this.return_dt = return_dt;
	}
}
