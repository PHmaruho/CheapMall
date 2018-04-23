package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.service.CommandProcess;

public class Cheap implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			request.setAttribute("main", "yes");
			
			HttpSession session = request.getSession(false);
			String id = (String) session.getAttribute("id");
			
			// 이건 세션 테스트 용으로 했습니다.
//			if(id == null || id.equals("")) {
//				request.setAttribute("sessionCheck", "no");
//			} else {
//				request.setAttribute("sessionCheck", "yes");
//			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return "cheapmall.jsp";
	}
}
