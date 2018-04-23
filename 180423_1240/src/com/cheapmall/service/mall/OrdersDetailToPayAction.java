package com.cheapmall.service.mall;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.GoodsDao;
import com.cheapmall.dao.MemberDao;
import com.cheapmall.dao.OrderDao;
import com.cheapmall.dto.CartDto;
import com.cheapmall.dto.UsersDto;
import com.cheapmall.service.CommandProcess;

public class OrdersDetailToPayAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			String id = session.getAttribute("id") == null ? null : session.getAttribute("id").toString();
			
			if(id == null) {
				request.setAttribute("warning", "notLogin");
				return "cheapmall.jsp";
			}
			
			String cd = request.getParameter("cd");
			String color = request.getParameter("color");
			String size = request.getParameter("size");
			int cnt = Integer.parseInt(request.getParameter("cnt"));
			int price = Integer.parseInt(request.getParameter("price"));
			int delivery_fee = 0;
			int total = cnt * price;
			
			CartDto cartDto = new CartDto();
			ArrayList<CartDto> list = new ArrayList<CartDto>();
			GoodsDao goodsDao = GoodsDao.getInstance();
			
			String goods_sq = goodsDao.selectSqBeforeCart(cd, color, size);
			cartDto.setUser_id(id);
			cartDto.setGoods_sq(goods_sq);
			cartDto.setCnt(cnt);
			cartDto.setOrigin_price(price);
			cartDto.setDc_price(0);
			list.add(cartDto);
			
			if (total < 30000) {
				delivery_fee = 2500;
			}
			
			List<Map<String,Object>> orders = goodsDao.goodsGetPicPath(list);
			Map<String, Object> orderBag = new HashMap<>();
			orderBag.put("orders", orders);
			orderBag.put("total", total);
			orderBag.put("delivery_fee", delivery_fee);
			
			// MemberDao
			MemberDao memberDao = MemberDao.getInstance();
			UsersDto usersDto = memberDao.userGetInfo(id);
			
			orderBag.put("id", usersDto.getId());
			orderBag.put("zipcode", usersDto.getZipcode());
			orderBag.put("addr", usersDto.getAddr());
			orderBag.put("addr_detail", usersDto.getAddr_detail());
			orderBag.put("tel", usersDto.getTel());
			orderBag.put("point", usersDto.getPoint());
			
			// request Set
			request.setAttribute("orderBag", orderBag);
			request.setAttribute("pageSet", "/mall/orderDetailForm.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/mall/cheapmall.jsp";
	}
}
