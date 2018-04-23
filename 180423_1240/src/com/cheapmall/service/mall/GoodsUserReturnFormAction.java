package com.cheapmall.service.mall;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.OrderDao;
import com.cheapmall.service.CommandProcess;


public class GoodsUserReturnFormAction implements CommandProcess{

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		try {
			HttpSession session = request.getSession();
			String id = session.getAttribute("id") == null ? null : session.getAttribute("id").toString();
			String order_sq=request.getParameter("order_sq");
			if(id == null) {
				request.setAttribute("warning", "notLogin");
				return "cheapmall.jsp";
			}
			
			
			OrderDao dao=OrderDao.getInstance();
			/*
			
			String pageNum=request.getParameter("pageNum");
			if(pageNum==null || pageNum.equals("")){
				pageNum="1";
			}
			
			int currentPage=Integer.parseInt(pageNum);
			int pageSize=15, blockSize=10;
			
			int startRow= (currentPage-1)* pageSize+1;
			int endRow= startRow+pageSize-1;*/
			List<HashMap> list=new ArrayList<HashMap>();
			list=dao.selectOrders(id,order_sq);
			/*int count=dao.selectOrders(id,order_sq).size();
			int startNum=count-startRow+1;
			
			int totalPage= (int) Math.ceil((double) count/pageSize); 
			int startPage=(int) (currentPage - 1)/ blockSize * blockSize + 1;
			int endPage= startPage+ blockSize-1;
			if(endPage> totalPage) endPage=totalPage;
			*/
			request.setAttribute("id", id);
			request.setAttribute("order_sq", order_sq);
			request.setAttribute("list", list);
			/*request.setAttribute("count", count);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("blockSize", blockSize);
			request.setAttribute("startNum", startNum);
			request.setAttribute("totalPage", totalPage);
			request.setAttribute("startPage",startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("pageNum", pageNum);*/
			request.setAttribute("pageSet", "/mall/goodsUserReturnForm.jsp");
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
/*		return "/mall/cheapmall.jsp";*/
		return "/mall/goodsUserReturnForm.jsp";
	}

}
