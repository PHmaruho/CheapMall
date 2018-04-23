package com.cheapmall.service.mall;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.GoodsDao;
import com.cheapmall.dto.GoodsDto;
import com.cheapmall.service.CommandProcess;

public class GoodsDetailPictureAjaxAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String color = request.getParameter("color");
			String cd = request.getParameter("cd");
			GoodsDao goodsDao = GoodsDao.getInstance();
			GoodsDto pictureDto = new GoodsDto();
			pictureDto = goodsDao.selectGoodsPath(cd, color);
			
			request.setAttribute("pictureDto", pictureDto);
			request.setAttribute("color", color);
		} catch (Exception e) {
			e.getMessage();
		}
		
		return "goodsDetailPictureAjax.jsp";
	}
}
