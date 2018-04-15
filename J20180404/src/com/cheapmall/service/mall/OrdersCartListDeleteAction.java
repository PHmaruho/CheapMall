package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.OrderDao;
import com.cheapmall.service.CommandProcess;

public class OrdersCartListDeleteAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String cart_sq = request.getParameter("cart_sq");
			OrderDao orderDao = OrderDao.getInstance();
			
			int result = orderDao.deleteCart(cart_sq);
			request.setAttribute("result", result);
			request.setAttribute("pageSet", "/mall/ordersCartListDelete.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/mall/cheapmall.jsp";
	}
}
