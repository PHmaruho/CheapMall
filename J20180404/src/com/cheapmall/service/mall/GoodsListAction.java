package com.cheapmall.service.mall;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.GoodsDao;
import com.cheapmall.dto.GoodsDto;
import com.cheapmall.service.CommandProcess;

public class GoodsListAction implements CommandProcess{

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String gender = request.getParameter("gender");
			String top_category = request.getParameter("top_category");
			String middle_category = request.getParameter("middle_category");
			ArrayList<GoodsDto> list = new ArrayList<GoodsDto>();
			GoodsDao goodsDao = GoodsDao.getInstance();
			list = goodsDao.listMain(gender, top_category, middle_category);
			
			request.setAttribute("gender", gender);
			request.setAttribute("top_category", top_category);
			request.setAttribute("middle_category", middle_category);
			request.setAttribute("list", list);
			request.setAttribute("pageSet", "goodsList.jsp");
		} catch (Exception e) {
			e.getMessage();
		}
		
		return "/mall/cheapmall.jsp";
	}
}
