package com.cheapmall.dto;

public class SearchDto {
	/*
	 * Version 1.0
	 * 최초작성자 : 허진무
	 * 내용 : 검색 Table DTO
	 */
	
	private String tag;
	private int    cnt;
	
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
}
