package com.cheapmall.service.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.BoardDao;
import com.cheapmall.dto.BoardDto;
import com.cheapmall.service.CommandProcess;

public class BoardAdminOtherListAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String board_cd = request.getParameter("board_cd");
		
		try {
			String pageNum = request.getParameter("pageNum");
			String bp = request.getParameter("bp") == null ? "all" : request.getParameter("bp");
			String option = request.getParameter("option") == null ? "all" : request.getParameter("option");
			String searchText = request.getParameter("searchText") == null ? "" : request.getParameter("searchText");
			BoardDao boardDao = BoardDao.getInstance();
			int totCnt = boardDao.getBoardCount(board_cd, bp, option, searchText);
			
			if (pageNum == null || pageNum.equals("")) {
				pageNum = "1";
			}
			if (bp == null || pageNum.equals("")) {
				bp = "all";
			}
			
			int currentPage = Integer.parseInt(pageNum);
			int pageSize = 10, blockSize = 10;
			int startRow = (currentPage - 1) * pageSize + 1;
			int endRow = startRow + pageSize - 1;
			int startNum = totCnt - startRow + 1;
			List<HashMap> list = boardDao.listAdminOther(startRow, endRow, board_cd, bp, option, searchText);
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
			request.setAttribute("board_cd", board_cd);
			request.setAttribute("bp", bp);
			request.setAttribute("option", option);
			request.setAttribute("searchText", searchText);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if (board_cd.equals("B1") || board_cd.equals("B2")) {
			return "boardAdminOtherList.jsp";
		} else if (board_cd.equals("B3")) {
			return "boardAdminReportList.jsp";
		} else {
			System.out.println("BoardAdminOtherListAction error");
			return "boardAdminTempPageCwi.jsp";
		}
	}
}
