package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.BoardDao;
import com.cheapmall.dto.BoardDto;
import com.cheapmall.service.CommandProcess;

public class BoardAdminOtherReplyAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// b4 bp2 관리자 [답변]제목
		
		try {
			String pageNum = request.getParameter("pageNum");
			String board_cd = request.getParameter("board_cd");
			BoardDto boardDto = new BoardDto();
			boardDto.setUser_id("관리자");
			boardDto.setSubject(request.getParameter("subject"));
			boardDto.setContent(request.getParameter("content"));
			boardDto.setObject(request.getParameter("board_sq"));
			boardDto.setBoard_cd("B4");
			boardDto.setBoard_p_cd("BP2");
			boardDto.setIp(request.getRemoteAddr());
			
			BoardDao boardDao = BoardDao.getInstance();
			int result = boardDao.write(boardDto);
			boardDao.updateBp(request.getParameter("board_sq"), "BP2");
			
			request.setAttribute("result", result);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("board_cd", board_cd);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "boardAdminOtherReply.jsp";
	}
}
