package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.cheapmall.dao.EtcDao;
import com.cheapmall.service.CommandProcess;

public class SearchProAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			String keyword = request.getParameter("keyword");
			EtcDao etcDao = EtcDao.getInstance();
			
			JSONObject json = new JSONObject();
			json = etcDao.searchTagGet(keyword);
		
			// SYSO
			System.out.println(keyword);
			System.out.println(json);
			
			request.setAttribute("json", json);
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("SearchProAction error");
			e.printStackTrace();
		}
		return "/mall/searchAjaxPro.jsp";
	}
}
