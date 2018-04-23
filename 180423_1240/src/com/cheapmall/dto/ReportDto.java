package com.cheapmall.dto;

import java.util.Date;

public class ReportDto {
	/*
	 * Version 1.0
	 * 최초작성자 : 최우일
	 * 내용 : 제재 Table DTO
	 */
	
	private String user_id;
	private Date dt;
	private int days;
	
	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public Date getDt() {
		return dt;
	}

	public void setDt(Date dt) {
		this.dt = dt;
	}

	public int getDays() {
		return days;
	}

	public void setDays(int days) {
		this.days = days;
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return super.toString();
	}
}
