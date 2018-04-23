package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.BoardDao;
import com.cheapmall.dto.BoardDto;
import com.cheapmall.service.CommandProcess;

public class BoardAdminNoticeUpdateProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			String auth =session.getAttribute("auth") == null ? null : session.getAttribute("auth").toString();
			
			if(auth == null) {
				session.invalidate();
				return "Admin.jsp";
			}
			BoardDto boardDto = new BoardDto();
			BoardDao boardDao = BoardDao.getInstance();
			String pageNum = request.getParameter("pageNum");
			
			boardDto.setBoard_sq(request.getParameter("board_sq"));
			boardDto.setSubject(request.getParameter("subject"));
			boardDto.setContent(request.getParameter("content"));
			boardDto.setIp(request.getRemoteAddr());
			int result = boardDao.updateAdminNotice(boardDto);
			
			request.setAttribute("board_sq", boardDto.getBoard_sq());
			request.setAttribute("result", result);
			request.setAttribute("pageNum", pageNum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "boardAdminNoticeUpdatePro.jsp";
	}
}
