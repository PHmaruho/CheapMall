package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.service.CommandProcess;

public class UserChkPwAjaxAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try {
			HttpSession session = request.getSession();
			String id = session.getAttribute("id") == null ? null : session.getAttribute("id").toString();
			
			String check = request.getParameter("check") == null ? null : request.getParameter("check");
			
			if(id == null) {
				request.setAttribute("warning", "notLogin");
				return "cheapmall.jsp";
			}
			MemberDao memberDao = MemberDao.getInstance();
			
			// 같은 액션을 쓰므로, 비밀번호 변경 시, 변경 로직도 여기서 진행된다.
			if(check != null) {
				String pw = request.getParameter("pw");
				
				int result = memberDao.userPwModify(id, pw);
				request.setAttribute("result", result);
				return "userPwModifyPro.jsp";
			}
			
			String pw = request.getParameter("pw");
			
			JSONObject json = new JSONObject();
			int result = memberDao.userLoginCheck(id, pw);
			
			if(result == 1) {
				json.put("value", 1);
			} else {
				json.put("value", 0);
			}
			
			request.setAttribute("json", json);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "userChkPwAjaxPro.jsp";
	}
}
