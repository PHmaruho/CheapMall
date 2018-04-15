package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.GoodsDao;
import com.cheapmall.dto.GoodsDto;
import com.cheapmall.service.CommandProcess;

public class UserWriteReviewFormAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try {
			String id = request.getParameter("id");
			String goods_sq = request.getParameter("goods_sq");
			String ip = request.getParameter("ip");
			
			GoodsDao goodsDao = GoodsDao.getInstance();
			GoodsDto goodsDto = new GoodsDto();
			goodsDto = goodsDao.getGoods(goods_sq);
			
			request.setAttribute("goodsDto", goodsDto);
			request.setAttribute("goods_sq", goods_sq);
			request.setAttribute("id", id);
			request.setAttribute("ip", ip);
			
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("UserWriteReviewFormAction Error");
			e.printStackTrace();
		}
		request.setAttribute("pageSet", "/mall/userWriteReviewForm.jsp");
		return "/mall/cheapmall.jsp";
	}
}
