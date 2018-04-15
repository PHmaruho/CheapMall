package com.cheapmall.dto;

public class CodeDto {
	/*
	 * Version 1.0
	 * 최초작성자 : 허진무
	 * 내용 : 코드 Table DTO
	 */
	
	private String cd;
	private String category;
	private String meaning;
	private String used;
	
	public String getCd() {
		return cd;
	}
	public void setCd(String cd) {
		this.cd = cd;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getMeaning() {
		return meaning;
	}
	public void setMeaning(String meaning) {
		this.meaning = meaning;
	}
	public String getUsed() {
		return used;
	}
	public void setUsed(String used) {
		this.used = used;
	}
}
