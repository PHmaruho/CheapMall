package com.cheapmall.dto;

public class CartDto {
	/*
	 * Version 1.0
	 * 최초작성자 : 허진무
	 * 내용 : 장바구니 Table DTO
	 */
	
	private String cart_sq;
	private String user_id;
	private String goods_sq;
	private int    cnt;
	private int    origin_price;
	private int    dc_price;
	private int    delivery_fee;
	
	public String getCart_sq() {
		return cart_sq;
	}
	public void setCart_sq(String cart_sq) {
		this.cart_sq = cart_sq;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getGoods_sq() {
		return goods_sq;
	}
	public void setGoods_sq(String goods_sq) {
		this.goods_sq = goods_sq;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
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
	public int getDelivery_fee() {
		return delivery_fee;
	}
	public void setDelivery_fee(int delivery_fee) {
		this.delivery_fee = delivery_fee;
	}
}
