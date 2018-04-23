package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.cheapmall.dao.StatisticsDao;
import com.cheapmall.service.CommandProcess;

public class StatisticsAdminMainAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			String type = request.getParameter("type") == null ? "" : request.getParameter("type");
			
			JSONObject jsonobject = new JSONObject();
			StatisticsDao statisticsDao = StatisticsDao.getInstance();
			if(type.equals("statis1")) {
				jsonobject = statisticsDao.statis1();
			} else if(type.equals("statis2")) {
				jsonobject = statisticsDao.statis2();
			} else if(type.equals("statis3")) {
				jsonobject = statisticsDao.statis3();
			} else if(type.equals("statis4")) {
				jsonobject = statisticsDao.statis4();
			}
			
			request.setAttribute("json", jsonobject);
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("StatisticsAdminMainAction error");
			e.printStackTrace();
		}
		
		return "/admin/statisticsAdminMainPro.jsp";
	}
}
