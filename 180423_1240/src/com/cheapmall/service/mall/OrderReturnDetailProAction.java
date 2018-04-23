package com.cheapmall.service.mall;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.OrderDao;
import com.cheapmall.service.CommandProcess;


public class OrderReturnDetailProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		try {
			HttpSession session = request.getSession();
			String id = session.getAttribute("id") == null ? null : session.getAttribute("id").toString();
			
			if(id == null) {
				request.setAttribute("warning", "notLogin");
				return "cheapmall.jsp";
			}
			
			String[] order_sq1=request.getParameterValues("order_sq");
			String[] detail_sq=request.getParameterValues("detail_sq");
			
			int result=0;
			int resultAll=0;
			String order_sq="";
			if (order_sq1.length>0) order_sq=order_sq1[0];
			OrderDao dao=OrderDao.getInstance();
			
			result=dao.returnOrderPart(id, order_sq, detail_sq);
			
			request.setAttribute("result", result);
			request.setAttribute("pageSet", "/mall/orderReturnDetailPro.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return "/mall/cheapmall.jsp";
	}

}
