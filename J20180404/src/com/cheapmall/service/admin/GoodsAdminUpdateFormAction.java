package com.cheapmall.service.admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.GoodsDao;
import com.cheapmall.dto.GoodsDto;
import com.cheapmall.service.CommandProcess;

public class GoodsAdminUpdateFormAction implements CommandProcess{

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		String auth =session.getAttribute("auth") == null ? null : session.getAttribute("auth").toString();
		
		if(auth == null) {
			session.invalidate();
			return "Admin.jsp";
		}
		GoodsDto dto=new GoodsDto();
		GoodsDao dao=GoodsDao.getInstance();
		String sq=request.getParameter("sq");
		try {
			
			int result=dao.updateDisplay();
			if(result>=0) dto=dao.selectGoods(sq);
			request.setAttribute("dto", dto);
			request.setAttribute("sq", sq);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("goodsAdminUpdateFormAction 완료");
		return "/admin/goodsAdminUpdateForm.jsp";
	}

}
