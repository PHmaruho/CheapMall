package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.BoardDao;
import com.cheapmall.dto.ReviewDto;
import com.cheapmall.service.CommandProcess;

public class ReviewPopUpAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			HttpSession session = request.getSession();
			String id = session.getAttribute("id") == null ? null : session.getAttribute("id").toString();
			
			if(id != null) {
				String sq = request.getParameter("sq");
				String dSq = request.getParameter("dSq");
				
				BoardDao boardDao = BoardDao.getInstance();
				boardDao.upToReviewCnt(sq); // count ++
				ReviewDto reviewDto = boardDao.getReviewOne(sq, dSq);
				
				request.setAttribute("reviewDto", reviewDto);
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return "/mall/reviewPopup.jsp";
	}
}
