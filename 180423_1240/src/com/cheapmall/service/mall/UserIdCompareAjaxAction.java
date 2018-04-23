package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.service.CommandProcess;

public class UserIdCompareAjaxAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			String id = request.getParameter("id");
			
			MemberDao memberDao = MemberDao.getInstance();
			JSONObject json = new JSONObject();
			json = memberDao.checkIdAjax(id);
			
			request.setAttribute("json", json);
			
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("UserIdCompareAjaxAction Error");
			e.printStackTrace();
		}
		
		return "/mall/userIdComareAjax.jsp";
	}
}
