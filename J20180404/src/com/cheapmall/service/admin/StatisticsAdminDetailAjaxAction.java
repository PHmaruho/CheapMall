package com.cheapmall.service.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.StatisticsDao;
import com.cheapmall.service.CommandProcess;

public class StatisticsAdminDetailAjaxAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			String auth =session.getAttribute("auth") == null ? null : session.getAttribute("auth").toString();
			
			if(auth == null) {
				session.invalidate();
				return "Admin.jsp";
			}
			
			String type = request.getParameter("type");
			StatisticsDao statisticsDao = StatisticsDao.getInstance();
			ArrayList<HashMap> list = new ArrayList<>();
			
			if (type.equals("op1")) {
				
			} else if (type.equals("op2")) {
				list = statisticsDao.saleReturnPeoplePerPriceRange();
				request.setAttribute("list", list);
				return "statisticsAdminDetailAjaxOp2.jsp";
			} else if (type.equals("op3")) {
				String[] columnType = {"cAddr", "cGrade", "cGender", "cYear"};
				String[] resultType = {"rCnt", "rSsum", "rRsum"};
				request.setAttribute("columnType", columnType);
				request.setAttribute("resultType", resultType);
				return "statisticsAdminDetailAjaxOp3.jsp";
			} else if (type.equals("op4")) {
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "statisticsAdminDetailAjax.jsp";
	}
}
