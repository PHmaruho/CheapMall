package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.BoardDao;
import com.cheapmall.dao.GoodsDao;
import com.cheapmall.dto.GoodsDto;
import com.cheapmall.service.CommandProcess;

public class UserWriteReviewFormAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try {
			HttpSession session = request.getSession();
			String id = session.getAttribute("id") == null ? null : session.getAttribute("id").toString();
			
			if(id == null) {
				request.setAttribute("result", -1);
				return "reviewNotPro.jsp";
			}
			// String id = request.getParameter("id");
			String goods_sq = request.getParameter("goods_sq");
			String dSq = request.getParameter("dSq");
			String ip = request.getRemoteAddr();
			
			BoardDao boardDao = BoardDao.getInstance();
			int result = boardDao.checkReviewWrite(dSq);
			
			if(result == 1) {
				request.setAttribute("result", "1");
				return "reviewNotPro.jsp";
			}
			
			GoodsDao goodsDao = GoodsDao.getInstance();
			GoodsDto goodsDto = new GoodsDto();
			goodsDto = goodsDao.getGoods(goods_sq);
			
			request.setAttribute("goodsDto", goodsDto);
			request.setAttribute("goods_sq", goods_sq);
			request.setAttribute("dSq", dSq);
			request.setAttribute("ip", ip);
			
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("UserWriteReviewFormAction Error");
			e.printStackTrace();
		}
		return "/mall/userWriteReviewForm.jsp";
	}
}
