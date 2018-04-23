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

public class OrdersCartToPayAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			String id = session.getAttribute("id") == null ? null : session.getAttribute("id").toString();
			
			if(id == null) {
				request.setAttribute("warning", "notLogin");
				return "cheapmall.jsp";
			}
			
			int delivery_fee = Integer.parseInt(request.getParameter("delivery_fee"));
			int total = Integer.parseInt(request.getParameter("total"));
			
			ArrayList<CartDto> list = new ArrayList<CartDto>();
			OrderDao orderDao = OrderDao.getInstance();
			list = orderDao.selectCartBeforePay(id);
			
			// Cart_sq Save
			String[] cart_sq = new String[list.size()];
			for(int i=0 ; i<list.size() ; i++) {
				cart_sq[i] = list.get(i).getCart_sq();
			}
			
			GoodsDao goodsDao = GoodsDao.getInstance();
			
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
			request.setAttribute("cart_sq", cart_sq);
			request.setAttribute("pageSet", "/mall/orderDetailForm.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/mall/cheapmall.jsp";
	}
}
