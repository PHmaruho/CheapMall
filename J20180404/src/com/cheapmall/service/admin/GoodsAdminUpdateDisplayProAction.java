package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.GoodsDao;
import com.cheapmall.service.CommandProcess;

public class GoodsAdminUpdateDisplayProAction implements CommandProcess{

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		try {
			HttpSession session=request.getSession();
			String id= session.getAttribute("id").toString();
			/*String id="test2";*/
			String[] displayNumber 
			= {request.getParameter("0"), request.getParameter("1"), request.getParameter("2")};
			String[] sq=request.getParameterValues("sq");
			
			GoodsDao dao=GoodsDao.getInstance();
			
			int result=0;
			int resultAdd=0;
			
			for(int i=0;i<displayNumber.length;i++){
				if (displayNumber[i]==null||displayNumber[i].length()==0) break;
				result=dao.updateGoods(sq[i],displayNumber[i]);
				resultAdd+=result;
			}
			
			request.setAttribute("result", result);
			request.setAttribute("pageSet", "/admin/goodsAdminUpdateDisplayPro.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/mall/cheapmall.jsp";
	}

}
