package com.cheapmall.service.mall;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.BoardDao;
import com.cheapmall.service.CommandProcess;

public class BoardOtherListAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			String id = (String) session.getAttribute("id");
			if(id == null) {
				request.setAttribute("warning", "notLogin");
				return "cheapmall.jsp";
			}
			
			BoardDao boardDao = BoardDao.getInstance();
			int totCnt = boardDao.getBoardCount(null);
			String pageNum = request.getParameter("pageNum");
			
			if (pageNum == null || pageNum.equals("")) {
				pageNum = "1";
			}
			
			int currentPage = Integer.parseInt(pageNum);
			int pageSize = 10, blockSize = 10;
			int startRow = (currentPage - 1) * pageSize + 1;
			int endRow = startRow + pageSize - 1;
			int startNum = totCnt - startRow + 1;
			List<HashMap> list = boardDao.listUserOther(startRow, endRow, id);
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
			request.setAttribute("pageSet", "boardOtherList.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("BoardOtherListAction error");
		}
		return "cheapmall.jsp";
	}
}
