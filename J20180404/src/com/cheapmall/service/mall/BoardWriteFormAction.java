package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.service.CommandProcess;

public class BoardWriteFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id = session.getAttribute("id") == null ? null : session.getAttribute("id").toString();
		
		if(id == null) {
			request.setAttribute("warning", "notLogin");
			return "cheapmall.jsp";
		}
		
		String board_cd = request.getParameter("board_cd");
		String report_id = request.getParameter("id");
		if (board_cd != null) {
			request.setAttribute("report_id", report_id);
			request.setAttribute("board_cd", board_cd);
			return "boardWriteForm.jsp";
		}
		
		request.setAttribute("id", id);
		request.setAttribute("pageSet", "boardWriteForm.jsp");
		return "cheapmall.jsp";
	}
}
