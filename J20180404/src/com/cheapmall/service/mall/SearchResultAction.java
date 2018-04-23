package com.cheapmall.service.mall;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.EtcDao;
import com.cheapmall.dao.GoodsDao;
import com.cheapmall.dto.GoodsDto;
import com.cheapmall.dto.UsersDto;
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
			
			// board
			String pageNum=request.getParameter("pageNum");
			if(pageNum==null || pageNum.equals("")){
				pageNum="1";
			}
			
			
			GoodsDao goodsDao = GoodsDao.getInstance();
			
			int totCnt = 0;
			totCnt = goodsDao.searchResultCnt(keyword);
			
			int currentPage=Integer.parseInt(pageNum);
			int pageSize=12, blockSize=10;
			int startRow= ((currentPage-1)* pageSize)+1;
			int endRow= startRow+pageSize-1;
			int startNum=totCnt-startRow+1;
			
			ArrayList<GoodsDto> list = goodsDao.searchResultBoard(keyword, startRow, endRow);
			
			int totalPage= (int) Math.ceil((double) totCnt/pageSize); 
			int startPage=(int) (currentPage - 1)/ blockSize * blockSize + 1;
			int endPage= startPage+ blockSize-1;
			if(endPage> totalPage) endPage=totalPage;
			
			request.setAttribute("totCnt", totCnt);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("blockSize", blockSize);
			request.setAttribute("startNum", startNum);
			request.setAttribute("totalPage", totalPage);
			request.setAttribute("startPage",startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("pageNum", pageNum);
			
			request.setAttribute("keyword", keyword);
			
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
