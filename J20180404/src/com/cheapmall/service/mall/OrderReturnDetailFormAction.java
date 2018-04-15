package com.cheapmall.service.mall;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.OrderDao;
import com.cheapmall.dto.Order_detailDto;
import com.cheapmall.service.CommandProcess;

public class OrderReturnDetailFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		try {
			HttpSession session = request.getSession();
			String id = session.getAttribute("id").toString();
			/*String id="test2";*/
			String order_sq=request.getParameter("order_sq");
			OrderDao dao=OrderDao.getInstance();
			
			List<Order_detailDto> detailList=new ArrayList<Order_detailDto>();
			String pageNum=request.getParameter("pageNum");
			if(pageNum==null || pageNum.equals("")){
				pageNum="1";
			}
			
			int currentPage=Integer.parseInt(pageNum);
			int pageSize=3, blockSize=3;
			
			int count=dao.detailOrder(id,order_sq).size();
			detailList=dao.detailOrder(id,order_sq);
			
			int totalPage= (int) Math.ceil((double) count/pageSize); 
			int startPage=(int) (currentPage - 1)/ blockSize * blockSize + 1;
			int endPage= startPage+ blockSize-1;
			if(endPage> totalPage) endPage=totalPage;
			
			request.setAttribute("id", id);
			request.setAttribute("order_sq", order_sq);
			request.setAttribute("detailList", detailList);
			request.setAttribute("count", count);
			request.setAttribute("pageSet", "/mall/orderReturnDetailForm.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/mall/cheapmall.jsp";
	}

	

}
