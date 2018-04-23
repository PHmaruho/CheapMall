package com.cheapmall.dto;

import java.util.Date;

public class GoodsDto {
	/*
	 * Version 1.0
	 * 최초작성자 : 허진무
	 * 내용 : 상품 Table DTO
	 */
	
	private String sq;
	private String cd;
	private String nm;
	private Date   start_dt;
	private Date   end_dt;
	private int    price;
	private String gender;
	private String top_category;
	private String middle_category;
	private String color;
	private String goods_size;
	private String path;
	private int    stock;
	private String display;
	
	public String getSq() {
		return sq;
	}
	public void setSq(String sq) {
		this.sq = sq;
	}
	public String getCd() {
		return cd;
	}
	public void setCd(String cd) {
		this.cd = cd;
	}
	public String getNm() {
		return nm;
	}
	public void setNm(String nm) {
		this.nm = nm;
	}
	public Date getStart_dt() {
		return start_dt;
	}
	public void setStart_dt(Date start_dt) {
		this.start_dt = start_dt;
	}
	public Date getEnd_dt() {
		return end_dt;
	}
	public void setEnd_dt(Date end_dt) {
		this.end_dt = end_dt;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getTop_category() {
		return top_category;
	}
	public void setTop_category(String top_category) {
		this.top_category = top_category;
	}
	public String getMiddle_category() {
		return middle_category;
	}
	public void setMiddle_category(String middle_category) {
		this.middle_category = middle_category;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getGoods_size() {
		return goods_size;
	}
	public void setGoods_size(String goods_size) {
		this.goods_size = goods_size;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public String getDisplay() {
		return display;
	}
	public void setDisplay(String display) {
		this.display = display;
	}
}
