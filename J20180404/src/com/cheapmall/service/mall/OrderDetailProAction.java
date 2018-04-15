package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.OrderDao;
import com.cheapmall.dto.OrdersDto;
import com.cheapmall.service.CommandProcess;

public class OrderDetailProAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			HttpSession session = request.getSession();
			String id = session.getAttribute("id") == null ? null : session.getAttribute("id").toString();
			
			if(id == null) {
				return "cheapmall.jsp";
			}
			
			String[] goods_sq = request.getParameterValues("goods_sq");
			String[] cart_sq = request.getParameterValues("cart_sq") == null ? null : request.getParameterValues("cart_sq");
			String[] s_origin_price = request.getParameterValues("origin_price");
			String[] s_dc_price = request.getParameterValues("dc_price");
			String[] s_cnt = request.getParameterValues("cnt");
	
			
			int delivery_fee = request.getParameter("delivery_fee") == null ? 0 :Integer.parseInt(request.getParameter("delivery_fee"));
			int total = Integer.parseInt(request.getParameter("total"));
			int point = Integer.parseInt(request.getParameter("point"));
			int totalDc = 0;
			int[] dc_price = new int[s_cnt.length];
			int[] origin_price = new int[s_cnt.length];
			int[] cnt = new int[s_cnt.length];
			
			String address = request.getParameter("address");
			String payment = request.getParameter("payment");
			
			String zipcode = null;
			String addr = null;
			String addr_detail = null;
			String pay_method = null;
			
			if(address.equals("defaultAddr")) {
				zipcode = request.getParameter("zipcode");
				addr = request.getParameter("addr");
				addr_detail = request.getParameter("addr_detail") == null ? "" : request.getParameter("addr_detail");
			} else if(address.equals("newAddr")) {
				zipcode = request.getParameter("newZipcode");
				addr = request.getParameter("newAddr");
				addr_detail = request.getParameter("newAddr_detail");
			}
			
			if(payment.equals("kakaopay")) {
				pay_method = request.getParameter("kakaopay");
			} else if(payment.equals("creditcard")) {
				pay_method = request.getParameter("creditcard");
			} else if(payment.equals("bankbook")) {
				pay_method = request.getParameter("bankbook");
			}
			
			// 전체 할인가격 구한다
			for(int i=0 ; i<s_dc_price.length ;i++) {
				totalDc = Integer.parseInt(s_dc_price[i]);
				origin_price[i] = Integer.parseInt(s_origin_price[i]);
				dc_price[i] = Integer.parseInt(s_dc_price[i]);
				cnt[i] = Integer.parseInt(s_cnt[i]);
			}
			
			OrdersDto ordersDto = new OrdersDto();
			ordersDto.setUser_id(id);
			ordersDto.setPay_method(pay_method);
			ordersDto.setUse_point(point);
			ordersDto.setOrigin_price(total);
			ordersDto.setDelivery_fee(delivery_fee);
			ordersDto.setAddr(addr);
			ordersDto.setAddr_detail(addr_detail);
			ordersDto.setDc_price(totalDc);
			
			OrderDao orderDao = OrderDao.getInstance();
			int result = orderDao.userOrder(goods_sq, origin_price, dc_price, cnt, cart_sq,ordersDto);
			
			request.setAttribute("result", result);
			//request.setAttribute("pageSet", arg1);
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("OrderDetailProAction error");
			e.printStackTrace();
		}
		
		return "cheapmall.jsp";
	}
}
