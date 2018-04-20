package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.BoardDao;
import com.cheapmall.service.CommandProcess;

public class ReviewDetailProAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			HttpSession session = request.getSession();
			String id = session.getAttribute("id") == null ? null : session.getAttribute("id").toString();
			
			String sq = request.getParameter("sq");
			String type = request.getParameter("type");
			String writer = request.getParameter("writer");
			
			BoardDao boardDao = BoardDao.getInstance();
			int result = 0;
			if(id.equals(writer)) {
				if(type.equals("delete")) {
					result = boardDao.deleteReview(sq);
					
					request.setAttribute("type", type);
					request.setAttribute("result", result);
				}
			} else {
				request.setAttribute("type", "warning");
			}
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("ReviewDetailProAction Error");
			e.printStackTrace();
		}
		return "reviewDetailPro.jsp";
	}
}
