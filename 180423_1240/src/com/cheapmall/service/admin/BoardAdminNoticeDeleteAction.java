package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.BoardDao;
import com.cheapmall.dto.BoardDto;
import com.cheapmall.service.CommandProcess;

public class BoardAdminNoticeDeleteAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String board_sq = request.getParameter("board_sq");
			String pageNum = request.getParameter("pageNum");
			BoardDao boardDao = BoardDao.getInstance();
			
			int result = boardDao.deleteAdminNotice(board_sq);
			
			request.setAttribute("result", result);
			request.setAttribute("board_sq", board_sq);
			request.setAttribute("pageNum", pageNum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return "boardAdminNoticeDelete.jsp";
	}
}
