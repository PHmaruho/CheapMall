package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.BoardDao;
import com.cheapmall.dto.BoardDto;
import com.cheapmall.service.CommandProcess;

public class BoardWriteProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			BoardDto boardDto = new BoardDto();
			BoardDao boardDao = BoardDao.getInstance();
			
			boardDto.setUser_id(session.getAttribute("id").toString());
			boardDto.setSubject(request.getParameter("subject"));
			boardDto.setContent(request.getParameter("content"));
			boardDto.setObject(request.getParameter("object"));
			boardDto.setBoard_cd(request.getParameter("board_cd"));
			boardDto.setBoard_p_cd("BP0");
			boardDto.setIp(request.getRemoteAddr());
			
			int result = boardDao.write(boardDto);
			
			request.setAttribute("result", result);
			request.setAttribute("pageSet", "boardWritePro.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "cheapmall.jsp";
	}
}
