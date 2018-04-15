package com.cheapmall.service.mall;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.OrderDao;
import com.cheapmall.dto.OrdersDto;
import com.cheapmall.service.CommandProcess;


public class GoodsUserReturnFormAction implements CommandProcess{

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		try {
			HttpSession session = request.getSession();
			String id = session.getAttribute("id").toString();
			/*String id="test2";*/
			OrderDao dao=OrderDao.getInstance();
			
			
			String pageNum=request.getParameter("pageNum");
			if(pageNum==null || pageNum.equals("")){
				pageNum="1";
			}
			
			int currentPage=Integer.parseInt(pageNum);
			int pageSize=3, blockSize=3;
			
			int startRow= (currentPage-1)* pageSize+1;
			int endRow= startRow+pageSize-1;
			int count=dao.selectOrders(id,0,0).size();
			int startNum=count-startRow+1;
			List<OrdersDto> list=new ArrayList<OrdersDto>();
			list=dao.selectOrders(id,startRow,endRow);
			
			int totalPage= (int) Math.ceil((double) count/pageSize); 
			int startPage=(int) (currentPage - 1)/ blockSize * blockSize + 1;
			int endPage= startPage+ blockSize-1;
			if(endPage> totalPage) endPage=totalPage;
			
			request.setAttribute("id", id);
			request.setAttribute("list", list);
			request.setAttribute("count", count);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("blockSize", blockSize);
			request.setAttribute("startNum", startNum);
			request.setAttribute("totalPage", totalPage);
			request.setAttribute("startPage",startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("pageSet", "/mall/goodsUserReturnForm.jsp");
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return "/mall/cheapmall.jsp";
	}

}
