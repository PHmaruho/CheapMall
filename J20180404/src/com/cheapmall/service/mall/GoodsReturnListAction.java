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
import com.cheapmall.dto.ReturnsDto;
import com.cheapmall.service.CommandProcess;

public class GoodsReturnListAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session=request.getSession();
			String id = session.getAttribute("id").toString();
			/*String id="test2";*/
			List<ReturnsDto> list=new ArrayList<ReturnsDto>();
			List<String> orderId=new ArrayList<String>();
			
			OrderDao dao=OrderDao.getInstance();
			list=dao.getReturnList(id);
			for(int i=0;i<list.size();i++){
				orderId=dao.getOrderId(list.get(i).getDetail_sq()      );
			}
			
			request.setAttribute("list",list);
			request.setAttribute("orderId", orderId);
			request.setAttribute("pageSet", "/mall/goodsReturnList.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return "/mall/cheapmall.jsp";
	}

}
