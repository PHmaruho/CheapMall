package com.cheapmall.service.mall;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.EtcDao;
import com.cheapmall.dao.GoodsDao;
import com.cheapmall.dto.GoodsDto;
import com.cheapmall.service.CommandProcess;

public class SearchResultAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			String keyword = request.getParameter("keyword");
			
			EtcDao etcDao = EtcDao.getInstance();
			int result = etcDao.keywordCntUp(keyword);
			
			GoodsDao goodsDao = GoodsDao.getInstance();
			ArrayList<GoodsDto> list = goodsDao.searchResultList(keyword);
			if(list != null) {
				request.setAttribute("list", list);
				request.setAttribute("pageSet", "/mall/searchResultForm.jsp");
			} else {
				new Exception();
			}
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("SearchResultAction Error");
			e.printStackTrace();
		}
		
		return "/mall/cheapmall.jsp";
	}
}
