package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.GoodsDao;
import com.cheapmall.service.CommandProcess;

public class GoodsAdminUpdateDisplayAction implements CommandProcess{

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		try {
			String[] displayNumber 
			= {request.getParameter("0"), request.getParameter("1"), request.getParameter("0")};
			String[] sq=request.getParameterValues("sq");
			
			GoodsDao dao=GoodsDao.getInstance();
			
			int result=0;
			int resultAdd=0;
			
			for(int i=0;i<displayNumber.length;i++){
				result=dao.updateDisplay(sq[i],displayNumber[i]);
				resultAdd+=result;
			}
			request.setAttribute("result", result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/admin/goodsAdminUpdateDisplayPro.jsp";
	}

}
