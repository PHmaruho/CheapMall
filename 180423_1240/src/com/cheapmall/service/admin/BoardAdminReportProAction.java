package com.cheapmall.service.admin;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.BoardDao;
import com.cheapmall.dao.EtcDao;
import com.cheapmall.service.CommandProcess;

public class BoardAdminReportProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int days = Integer.parseInt(request.getParameter("radio"));
			String board_sq = request.getParameter("board_sq");
			String user_id = request.getParameter("object");
			String pageNum = request.getParameter("pageNum");
			String board_cd = request.getParameter("board_cd");
			
			BoardDao boardDao = BoardDao.getInstance();
			EtcDao etcDao = EtcDao.getInstance();
			Date check = etcDao.checkReport(user_id);
			
			if (check == null || check.equals("")) {
				int result = 0;
				if (days != 0) {
					result = etcDao.insertReport(user_id, days);
				} else {
					result = 1;
				}
				request.setAttribute("result", result);
			}
			boardDao.updateBp(board_sq, "BP3");
			
			request.setAttribute("check", check);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("board_sq", board_sq);
			request.setAttribute("board_cd", board_cd);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "boardAdminReportPro.jsp";
	}
}
