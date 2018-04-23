package com.cheapmall.dto;

import java.util.Date;

public class OrdersDto {
	/*
	 * Version 1.0
	 * 최초작성자 : 허진무
	 * 내용 : 주문 Table DTO
	 */
	
	private String order_sq;
	private String user_id;
	private int    origin_price;
	private int    dc_price;
	private String pay_method;
	private int    use_point;
	private int    delivery_fee;
	private String addr;
	private String addr_detail;
	private String order_cd;
	private Date order_dt;
	
	public String getOrder_sq() {
		return order_sq;
	}
	public void setOrder_sq(String order_sq) {
		this.order_sq = order_sq;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
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
	public String getPay_method() {
		return pay_method;
	}
	public void setPay_method(String pay_method) {
		this.pay_method = pay_method;
	}
	public int getUse_point() {
		return use_point;
	}
	public void setUse_point(int use_point) {
		this.use_point = use_point;
	}
	public int getDelivery_fee() {
		return delivery_fee;
	}
	public void setDelivery_fee(int delivery_fee) {
		this.delivery_fee = delivery_fee;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getAddr_detail() {
		return addr_detail;
	}
	public void setAddr_detail(String addr_detail) {
		this.addr_detail = addr_detail;
	}
	public String getOrder_cd() {
		return order_cd;
	}
	public void setOrder_cd(String order_cd) {
		this.order_cd = order_cd;
	}
	public Date getOrder_dt() {
		return order_dt;
	}
	public void setOrder_dt(Date order_dt) {
		this.order_dt = order_dt;
	}
}
