package com.cheapmall.service.mall;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.GoodsDao;
import com.cheapmall.dto.GoodsDto;
import com.cheapmall.service.CommandProcess;

public class GoodsDetailSizeAjaxAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String color = request.getParameter("color");
			String cd = request.getParameter("cd");
			GoodsDao goodsDao = GoodsDao.getInstance();
			ArrayList<GoodsDto> list = new ArrayList<GoodsDto>(); 
			list = goodsDao.listGoodsSize(cd, color);
			
			request.setAttribute("list", list);
		} catch (Exception e) {
			e.getMessage();
		}
		
		return "goodsDetailSizeAjax.jsp";
	}
}
