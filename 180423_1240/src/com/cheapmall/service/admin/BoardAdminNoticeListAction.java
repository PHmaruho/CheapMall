package com.cheapmall.service.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.BoardDao;
import com.cheapmall.dto.BoardDto;
import com.cheapmall.service.CommandProcess;

public class BoardAdminNoticeListAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			BoardDao boardDao = BoardDao.getInstance();
			String pageNum = request.getParameter("pageNum");
			String option = request.getParameter("option") == null ? "all" : request.getParameter("option");
			String searchText = request.getParameter("searchText") == null ? "" : request.getParameter("searchText");
			int totCnt = boardDao.getBoardCount("B0", "all", option, searchText);
			
			if (pageNum == null || pageNum.equals("")) {
				pageNum = "1";
			}
			
			int currentPage = Integer.parseInt(pageNum);
			int pageSize = 10, blockSize = 10;
			int startRow = (currentPage - 1) * pageSize + 1;
			int endRow = startRow + pageSize - 1;
			int startNum = totCnt - startRow + 1;
			List<BoardDto> list = boardDao.listNotice(startRow, endRow, option, searchText);
			int pageCnt = (int)Math.ceil((double)totCnt/pageSize);
			int startPage = (int)(currentPage - 1) / blockSize * blockSize + 1;
			int endPage = startPage + blockSize - 1;
			if (endPage > pageCnt) {
				endPage = pageCnt;
			}
			
			request.setAttribute("totCnt", totCnt);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("startNum", startNum);
			request.setAttribute("list", list);
			request.setAttribute("blockSize", blockSize);
			request.setAttribute("pageCnt", pageCnt);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("option", option);
			request.setAttribute("searchText", searchText);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "boardAdminNoticeList.jsp";
	}
}
