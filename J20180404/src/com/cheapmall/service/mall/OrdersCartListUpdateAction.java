package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.OrderDao;
import com.cheapmall.service.CommandProcess;

public class OrdersCartListUpdateAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			String id = session.getAttribute("id") == null ? null : session.getAttribute("id").toString();
			
			if(id == null) {
				request.setAttribute("warning", "notLogin");
				return "cheapmall.jsp";
			}
			
			String cnt = request.getParameter("cnt");
			String cart_sq = request.getParameter("cart_sq");
			OrderDao orderDao = OrderDao.getInstance();
			
			int result = orderDao.updateCart(cnt, cart_sq);
			request.setAttribute("result", result);
			request.setAttribute("pageSet", "/mall/ordersCartListUpdate.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/mall/cheapmall.jsp";
	}
}
