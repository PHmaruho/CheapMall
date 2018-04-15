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
import com.cheapmall.dto.UsersDto;
import com.cheapmall.service.CommandProcess;

public class GoodsAdminUpdateListAction implements CommandProcess{

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
	
		HttpSession session=request.getSession();
		String id=session.getAttribute("id").toString();
		/*String id="test3";*/
		String category=request.getParameter("category");
		String search=request.getParameter("search");
		try {
			
			GoodsDao dao=GoodsDao.getInstance();

			String pageNum=request.getParameter("pageNum");
			if(pageNum==null || pageNum.equals("")){
				pageNum="1";
			}
			
			int currentPage=Integer.parseInt(pageNum);
			int pageSize=3, blockSize=3;
			
			int startRow= (currentPage-1)* pageSize+1;
			int endRow= startRow+pageSize-1;
			
			int result=dao.updateDisplay();
			int count=0;
			
			
			List<GoodsDto> list=new ArrayList<GoodsDto>();
			
			if(result>=0){
				
				if(search==null|| search.length()==0){ 
					list=dao.selectGoods(0,0);
					count=list.size();
					list=dao.selectGoods(startRow,endRow);
				}else{
					list=dao.selectGoods(category,search,0,0);
					count=list.size();
					list=dao.selectGoods(category,search,startRow,endRow);
				}
				
				
			}else list=null;
			
			int startNum=count-startRow+1;
			
			int totalPage= (int) Math.ceil((double) count/pageSize); 
			int startPage=(int) (currentPage - 1)/ blockSize * blockSize + 1;
			int endPage= startPage+ blockSize-1;
			if(endPage> totalPage) endPage=totalPage;
			
			
			request.setAttribute("count", count);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("blockSize", blockSize);
			request.setAttribute("startNum", startNum);
			request.setAttribute("totalPage", totalPage);
			request.setAttribute("startPage",startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("list",list);
			request.setAttribute("search", search);
			request.setAttribute("category", category);
			request.setAttribute("pageSet", "/admin/goodsAdminUpdateList.jsp");
			
			System.out.println("count: "+count);
			System.out.println("currentPage: "+currentPage);
			System.out.println("blockSize: "+blockSize);
			System.out.println("startNum: "+startNum);
			System.out.println("totalPage: "+totalPage);
			System.out.println("startPage: "+startPage);
			System.out.println("endPage: "+endPage);
			System.out.println("pageNum: "+pageNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/mall/cheapmall.jsp";
	}


}
