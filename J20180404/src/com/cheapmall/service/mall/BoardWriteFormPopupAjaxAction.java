package com.cheapmall.service.mall;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.GoodsDao;
import com.cheapmall.dto.GoodsDto;
import com.cheapmall.service.CommandProcess;

public class BoardWriteFormPopupAjaxAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String nm = request.getParameter("nm");
			GoodsDao goodsDao = GoodsDao.getInstance();
			ArrayList<GoodsDto> list = new ArrayList<GoodsDto>();
			list = goodsDao.searchResultList(nm);
			
			request.setAttribute("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "boardWriteFormPopupAjax.jsp";
	}
}
