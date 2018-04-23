package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.BoardDao;
import com.cheapmall.dto.BoardDto;
import com.cheapmall.service.CommandProcess;

public class BoardAdminNoticeWriteFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String pageNum = request.getParameter("pageNum");
			
			if (pageNum == null) {
				pageNum = "1";
			}
			
			request.setAttribute("pageNum", pageNum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return "boardAdminNoticeWriteForm.jsp";
	}
}
