package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.OrderDao;
import com.cheapmall.service.CommandProcess;

public class GoodsUserReturnProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			String id = session.getAttribute("id").toString();
			/*String id="test2";*/
			String[] order_sq = request.getParameterValues("returnOrder_sq");
			OrderDao dao = OrderDao.getInstance();
			int result = 0;
			int resultAll = 0;

			for (int i = 0; i < order_sq.length; i++) {
				result = dao.returnOrder(id, order_sq[i]);
				resultAll += result;
			}
			
			request.setAttribute("result", result);
			request.setAttribute("id", id);
			request.setAttribute("pageSet", "/mall/goodsUserReturnPro.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/mall/cheapmall.jsp";
	}

}
