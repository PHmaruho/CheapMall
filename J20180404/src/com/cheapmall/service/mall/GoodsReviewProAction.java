package com.cheapmall.service.mall;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.cheapmall.dao.BoardDao;
import com.cheapmall.dto.ReviewDto;
import com.cheapmall.dto.UsersDto;
import com.cheapmall.service.CommandProcess;

public class GoodsReviewProAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			String goods_cd = request.getParameter("goods_cd");
			String reviewType = request.getParameter("reviewType");
			String pageNum = request.getParameter("pageNum");
			
			BoardDao boardDao = BoardDao.getInstance();
			
			int totCnt  = boardDao.getTotalReview(goods_cd, reviewType);
			if (pageNum==null || pageNum.equals("")) {	pageNum = "1";	}
			int currentPage = Integer.parseInt(pageNum);	
			int pageSize  = 5, blockSize = 5;
			int startRow = (currentPage - 1) * pageSize + 1;
			int endRow   = startRow + pageSize - 1;
			int startNum = totCnt - startRow + 1;
			//list = boardDao.getReviews(goods_cd, reviewType, startRow, endRow);
			JSONObject json = boardDao.getReview(goods_cd, reviewType, startRow, endRow);
			//List<UsersDto> list = memberDao.userList(startRow, endRow);	
			int pageCnt = (int)Math.ceil((double)totCnt/pageSize);
			int startPage = (int)(currentPage-1)/blockSize*blockSize + 1;
			int endPage = startPage + blockSize -1;	
			if (endPage > pageCnt) endPage = pageCnt;
			
			json.put("totCnt", totCnt);
			json.put("pageNum", pageNum);
			json.put("currentPage", currentPage);
			json.put("startNum", startNum);
			json.put("blockSize", blockSize);
			json.put("pageCnt", pageCnt);
			json.put("startPage", startPage);
			json.put("endPage", endPage);
			
			request.setAttribute("list", json); // list -> json
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("GoodsReviewProAction Error");
			e.printStackTrace();
		}
		
		return "goodsReview.jsp";
	}
}
