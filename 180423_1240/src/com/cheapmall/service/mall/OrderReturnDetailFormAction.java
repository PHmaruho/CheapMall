package com.cheapmall.service.mall;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.OrderDao;
import com.cheapmall.service.CommandProcess;

public class OrderReturnDetailFormAction implements CommandProcess {

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
			
			
			String order_sq=request.getParameter("order_sq");
			OrderDao dao=OrderDao.getInstance();
			System.out.println("order_sq: "+order_sq);
			List<HashMap> detailList=new ArrayList<HashMap>();
			String pageNum=request.getParameter("pageNum");
			if(pageNum==null || pageNum.equals("")){
				pageNum="1";
			}
			
			int currentPage=Integer.parseInt(pageNum);
			int pageSize=15, blockSize=10;
			
			int count=dao.detailOrder(order_sq).size();
			detailList=dao.detailOrder(order_sq);
		
			
			request.setAttribute("id", id);
			request.setAttribute("order_sq", order_sq);
			request.setAttribute("detailList", detailList);
			request.setAttribute("count", count);
			System.out.println("count: "+count);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/mall/orderReturnDetailForm.jsp";
	}

	

}
