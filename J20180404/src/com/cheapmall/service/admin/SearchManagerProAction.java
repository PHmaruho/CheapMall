package com.cheapmall.service.admin;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.cheapmall.dao.EtcDao;
import com.cheapmall.service.CommandProcess;

public class SearchManagerProAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			String select = request.getParameter("overlap");
			String keyword = request.getParameter("keyword");
			
			EtcDao etcDao = EtcDao.getInstance();
			
			JSONObject jsonObject = new JSONObject();
			
			//SYSO
			System.out.println(keyword);
			System.out.println(select);
			
			//JSONArray jsonList = new JSONArray();
			if(select.equals("overlap")) {
				
				int result = etcDao.searchKeyword(keyword);
				
				if(result == 0) {
					jsonObject.put("result", "데이터가 없습니다");
					jsonObject.put("value", result);
					//jsonList.add(jsonObject);
				} else {
					jsonObject.put("result", "데이터가 중복됩니다.");
					jsonObject.put("value", result);
					//jsonList.add(jsonObject);
				}
			} else if(select.equals("search")){
				jsonObject = etcDao.searchTagGet(keyword);
				//jsonList.add(jsonObject);
			} else if(select.equals("regist")) {
				String transKeyword = request.getParameter("transKeyword");
				int result = etcDao.registKeyword(keyword, transKeyword);
				
				// SYSO
				System.out.println(keyword + " / " + transKeyword);
				
				if(result == 1) {
					jsonObject.put("result", "등록되었습니다");
				} else {
					jsonObject.put("result", "등록이 안됬습니다.");
				}
				
			} else if(select.equals("modify")) {
				jsonObject = etcDao.getKeyword(keyword);
			}
			
			jsonObject.put("overlap", select);
			// SYSO
			System.out.println(jsonObject);
			
			request.setAttribute("jsonObject", jsonObject);
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("SearchManagerProAction Error");
			e.printStackTrace();
		}
		
		return "/admin/searchManagerPro.jsp";
	}
}
