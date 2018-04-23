package com.cheapmall.service.mall;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.GoodsDao;
import com.cheapmall.dto.GoodsDto;
import com.cheapmall.service.CommandProcess;

public class GoodsDetailAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String cd = request.getParameter("cd");
			String gender = request.getParameter("gender");
			String top_category = request.getParameter("top_category");
			String middle_category = request.getParameter("middle_category");
			
			ArrayList<GoodsDto> colorList = new ArrayList<GoodsDto>();
			GoodsDto detailDto = new GoodsDto();
			GoodsDao goodsDao = GoodsDao.getInstance();
			
			colorList = goodsDao.listGoodsColor(cd);
			detailDto = goodsDao.selectGoodsDetail(cd);
			
			request.setAttribute("cd", cd);
			request.setAttribute("gender", gender);
			request.setAttribute("top_category", top_category);
			request.setAttribute("middle_category", middle_category);
			request.setAttribute("colorList", colorList);
			request.setAttribute("detailDto", detailDto);
			request.setAttribute("pageSet", "goodsDetail.jsp");
		} catch (Exception e) {
			e.getMessage();
		}
		
		return "cheapmall.jsp";
	}
}
