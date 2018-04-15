package com.cheapmall.service.mall;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.OrderDao;
import com.cheapmall.dto.CartDto;
import com.cheapmall.service.CommandProcess;

public class OrdersCartListAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			String id = session.getAttribute("id").toString();
			
			ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
			OrderDao orderDato = OrderDao.getInstance();
			list = orderDato.listCart(id);
			
			request.setAttribute("list", list);
		} catch (Exception e) {
			e.getMessage();
		}
		request.setAttribute("pageSet", "/mall/ordersCartList.jsp");
		return "/mall/cheapmall.jsp";
	}
}
