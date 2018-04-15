package com.cheapmall.service.mall;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.GoodsDao;
import com.cheapmall.dao.MemberDao;
import com.cheapmall.dto.CartDto;
import com.cheapmall.dto.GoodsDto;
import com.cheapmall.dto.UsersDto;
import com.cheapmall.service.CommandProcess;

public class OrderDetailFormAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			// Session 있는지 확인하고 있으면 주문으로 넘어가고
			// 없으면 로그인 페이지로 이동하는 로직을 추가하여야 한다!!!!!!!!!!!!
			// String id = session.getAttribute("id");
			String id = "asdf";
			
			// Request get
			//int delivery_pay = Integer.parseInt(request.getParameter("delivery_fee"));
			//int total = Integer.parseInt(request.getParameter("total"));
			
			int delivery_pay = 0;
			int total = 20000;
			
			CartDto cartDto = new CartDto();
			cartDto.setCart_sq("C000000001");
			cartDto.setCnt(10);
			cartDto.setGoods_sq("G000000001");
			cartDto.setOrigin_price(5900);
			cartDto.setUser_id("imgroot");
			cartDto.setDc_price(0);
			//G000000009	JAC0000001	2222222	18/04/04	18/04/13	22	M	O	JAC		X2S	G000000009	22	N
			CartDto cartDto2 = new CartDto();
			cartDto2.setCart_sq("C000000002");
			cartDto2.setCnt(3);
			cartDto2.setGoods_sq("G000000009");
			cartDto2.setOrigin_price(30000);
			cartDto2.setUser_id("imgroot");
			cartDto2.setDc_price(100);
			
			ArrayList<CartDto> getList = new ArrayList<>();
			getList.add(cartDto);
			getList.add(cartDto2);
			
			System.out.println(delivery_pay + " / " + total);
			
			// 장바구니에서 온 것은 SQ번호가 있고, 즉시 구매에서는 SQ번호가 없다.
			//ArrayList<CartDto> getList = (ArrayList<CartDto>) request.getAttribute("list");

			// GoodsDao
			GoodsDao goodsDao = GoodsDao.getInstance();
			
			List<Map<String,Object>> orders = goodsDao.goodsGetPicPath(getList);
			Map<String, Object> orderBag = new HashMap<>();
			orderBag.put("orders", orders);
			orderBag.put("total", total);
			orderBag.put("delivery_pay", delivery_pay);
			
			// MemberDao
			MemberDao memberDao = MemberDao.getInstance();
			UsersDto usersDto = memberDao.userGetInfo(id);
			
			orderBag.put("id", usersDto.getId());
			orderBag.put("zipcode", usersDto.getZipcode());
			orderBag.put("addr", usersDto.getAddr());
			orderBag.put("addr_detail", usersDto.getAddr_detail());
			orderBag.put("tel", usersDto.getTel());
			orderBag.put("point", usersDto.getPoint());
			
			request.setAttribute("pageSet", "/mall/orderDetailForm.jsp");
			
			// request Set
			request.setAttribute("orderBag", orderBag);
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("OrderDetailFormAction Error");
			e.printStackTrace();
		}
		
		return "/mall/cheapmall.jsp";
	}
}
