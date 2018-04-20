package com.cheapmall.service.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.GoodsDao;
import com.cheapmall.dto.GoodsDto;
import com.cheapmall.service.CommandProcess;

public class GoodsAdminDisplayListAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("여기 들어옴");
		HttpSession session = request.getSession();
		String id = session.getAttribute("id").toString();
/*		String category = request.getParameter("category");*/
		String gender=request.getParameter("gender");
		String top_category=request.getParameter("top_category");
		String middle_category=request.getParameter("middle_category");
		try {

			GoodsDao dao = GoodsDao.getInstance();

			String pageNum = request.getParameter("pageNum");
			if (pageNum == null || pageNum.equals("")) {
				pageNum = "1";
			}

			int currentPage = Integer.parseInt(pageNum);
			int pageSize = 15, blockSize = 10;

			int startRow = (currentPage - 1) * pageSize + 1;
			int endRow = startRow + pageSize - 1;

			int count = 0;

			List<GoodsDto> list = new ArrayList<GoodsDto>();

			
			if (gender == null) gender = "All";
			if (top_category == null) top_category = "All";
			if (middle_category == null) middle_category = "All";

					
			list = dao.selectDisplayGoods(gender, top_category,middle_category, 0, 0);
			count = list.size();
			list = dao.selectDisplayGoods(gender, top_category,middle_category, startRow,endRow);
	
			/*list = dao.selectDisplayGoods(0, 0);
			count = list.size();
			list = dao.selectDisplayGoods(startRow, endRow);
*/
			int startNum = count - startRow + 1;

			int totalPage = (int) Math.ceil((double) count / pageSize);
			int startPage = (int) (currentPage - 1) / blockSize * blockSize + 1;
			int endPage = startPage + blockSize - 1;
			if (endPage > totalPage)
				endPage = totalPage;

			request.setAttribute("count", count);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("blockSize", blockSize);
			request.setAttribute("startNum", startNum);
			request.setAttribute("totalPage", totalPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("list", list);
			/*request.setAttribute("category", category);*/
			request.setAttribute("gender", gender);
			request.setAttribute("top_category", top_category);
			request.setAttribute("middle_category", middle_category);
			
			System.out.println("count: " + count);
			System.out.println("currentPage: " + currentPage);
			System.out.println("blockSize: " + blockSize);
			System.out.println("startNum: " + startNum);
			System.out.println("totalPage: " + totalPage);
			System.out.println("startPage: " + startPage);
			System.out.println("endPage: " + endPage);
			System.out.println("pageNum: " + pageNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "goodsAdminDisplayList.jsp";
	}

}
