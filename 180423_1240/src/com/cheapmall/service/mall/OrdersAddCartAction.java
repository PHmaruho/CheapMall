package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.GoodsDao;
import com.cheapmall.dao.OrderDao;
import com.cheapmall.dto.CartDto;
import com.cheapmall.service.CommandProcess;

public class OrdersAddCartAction implements CommandProcess {

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
			
			GoodsDao goodsDao = GoodsDao.getInstance();
			OrderDao orderDao = OrderDao.getInstance();
			
			String sq = goodsDao.selectSqBeforeCart(cd, color, size);
			int result = orderDao.detailToCart(sq, cnt, price, id);
			
			request.setAttribute("result", result);
		} catch (Exception e) {
			e.getMessage();
		}
		return "/mall/ordersAddCart.jsp";
	}
}
