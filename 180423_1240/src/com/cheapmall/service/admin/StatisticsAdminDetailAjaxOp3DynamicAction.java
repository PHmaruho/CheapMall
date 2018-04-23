package com.cheapmall.service.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.StatisticsDao;
import com.cheapmall.service.CommandProcess;

public class StatisticsAdminDetailAjaxOp3DynamicAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String[] columnType = request.getParameterValues("columnType");
			String[] resultType = request.getParameterValues("resultType");
			ArrayList<HashMap> list = new ArrayList<>(); 
			
			StatisticsDao statisticsDao = StatisticsDao.getInstance(); 
			list = statisticsDao.dynamicQuery(columnType, resultType);
			
			request.setAttribute("list", list);
			request.setAttribute("columnType", columnType);
			request.setAttribute("resultType", resultType);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "statisticsAdminDetailAjaxOp3Dynamic.jsp";
	}
}
