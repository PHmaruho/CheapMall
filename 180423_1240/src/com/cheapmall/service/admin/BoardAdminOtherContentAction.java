package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.BoardDao;
import com.cheapmall.dto.BoardDto;
import com.cheapmall.service.CommandProcess;

public class BoardAdminOtherContentAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String board_sq = request.getParameter("board_sq");
			String pageNum = request.getParameter("pageNum");
			String board_cd = request.getParameter("board_cd");
			String content = null;
			BoardDao boardDao = BoardDao.getInstance();
			BoardDto boardDto = boardDao.selectContent(board_sq);
			boardDao.updateBp(board_sq, "BP1");
			
			if (boardDto.getBoard_p_cd().equals("BP2")) {
				content = boardDao.getContent(board_sq);
			}
			
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("boardDto", boardDto);
			request.setAttribute("board_cd", board_cd);
			request.setAttribute("content", content);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return "boardAdminOtherContent.jsp";
	}
}
