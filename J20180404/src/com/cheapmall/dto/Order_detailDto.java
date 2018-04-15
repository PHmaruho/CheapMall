package com.cheapmall.dto;

public class Order_detailDto {
	/*
	 * Version 1.0
	 * 최초작성자 : 허진무
	 * 내용 : 주문상세 Table DTO
	 */
	
	private String detail_sq;
	private String order_sq;
	private String goods_sq;
	private int    origin_price;
	private int    dc_price;
	private int    cnt;
	
	public String getDetail_sq() {
		return detail_sq;
	}
	public void setDetail_sq(String detail_sq) {
		this.detail_sq = detail_sq;
	}
	public String getOrder_sq() {
		return order_sq;
	}
	public void setOrder_sq(String order_sq) {
		this.order_sq = order_sq;
	}
	public String getGoods_sq() {
		return goods_sq;
	}
	public void setGoods_sq(String goods_sq) {
		this.goods_sq = goods_sq;
	}
	public int getOrigin_price() {
		return origin_price;
	}
	public void setOrigin_price(int origin_price) {
		this.origin_price = origin_price;
	}
	public int getDc_price() {
		return dc_price;
	}
	public void setDc_price(int dc_price) {
		this.dc_price = dc_price;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
}
