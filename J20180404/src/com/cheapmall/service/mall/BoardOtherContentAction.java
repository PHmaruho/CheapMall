package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.BoardDao;
import com.cheapmall.dto.BoardDto;
import com.cheapmall.service.CommandProcess;

public class BoardOtherContentAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			String id = session.getAttribute("id") == null ? null : session.getAttribute("id").toString();
			
			if(id == null) {
				request.setAttribute("warning", "notLogin");
				return "cheapmall.jsp";
			}
			
			
			String board_sq = request.getParameter("board_sq");
			String pageNum = request.getParameter("pageNum");
			String board_cd = request.getParameter("board_cd");
			String board_p_cd = request.getParameter("board_p_cd");
			String content = null;
			BoardDao boardDao = BoardDao.getInstance();
			BoardDto boardDto = boardDao.selectContent(board_sq);
			
			if (boardDto.getBoard_p_cd().equals("BP2")) {
				content = boardDao.getContent(board_sq);
			}
			
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("boardDto", boardDto);
			request.setAttribute("content", content);
			request.setAttribute("board_cd", board_cd);
			request.setAttribute("board_p_cd", board_p_cd);
			request.setAttribute("pageSet", "boardOtherContent.jsp");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return "cheapmall.jsp";
	}
}
