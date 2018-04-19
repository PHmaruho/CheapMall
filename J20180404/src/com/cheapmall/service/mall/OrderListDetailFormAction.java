package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.service.CommandProcess;

public class OrderListDetailFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		String id = session.getAttribute("id") == null ? null : session.getAttribute("id").toString();
		
		if(id == null) {
			request.setAttribute("warning", "notLogin");
			return "cheapmall.jsp";
		}
		
		
		
		request.setAttribute("pageSet", "/mall/orderListDetailForm.jsp");
		return "/mall/cheapmall.jsp";
	}

}
