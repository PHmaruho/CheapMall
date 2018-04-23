package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.BoardDao;
import com.cheapmall.dto.BoardDto;
import com.cheapmall.service.CommandProcess;

public class BoardAdminNoticeUpdateFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			String auth =session.getAttribute("auth") == null ? null : session.getAttribute("auth").toString();
			
			if(auth == null) {
				session.invalidate();
				return "Admin.jsp";
			}
			String board_sq = request.getParameter("board_sq");
			String pageNum = request.getParameter("pageNum");
			BoardDao boardDao = BoardDao.getInstance();
			BoardDto boardDto = boardDao.selectContent(board_sq);
			
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("boardDto", boardDto);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "boardAdminNoticeUpdateForm.jsp";
	}
}
