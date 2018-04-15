package com.cheapmall.service.admin;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.GoodsDao;
import com.cheapmall.dto.GoodsDto;
import com.cheapmall.service.CommandProcess;

public class GoodsAdminUpdateFormProAction implements CommandProcess{

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		try {
			HttpSession session=request.getSession();
			String id=session.getAttribute("id").toString();
			
			String sq=request.getParameter("sq");
			String cd=request.getParameter("cd");
			String nm=request.getParameter("nm");
			int price=Integer.parseInt(request.getParameter("price"));
			String gender=request.getParameter("gender");
			String top_category=request.getParameter("top_category");
			String middle_category=request.getParameter("middle_category");
			String color=request.getParameter("color");
			int stock=Integer.parseInt(request.getParameter("stock"));
			String display=request.getParameter("display");
			GoodsDto dto=new GoodsDto();
			GoodsDao dao=GoodsDao.getInstance();
			
			dto.setSq(sq);
			dto.setCd(cd);
			dto.setNm(nm);
			dto.setPrice(price);
			dto.setGender(gender);
			dto.setTop_category(top_category);
			dto.setMiddle_category(middle_category);
			dto.setColor(color);
			dto.setStock(stock);
			dto.setDisplay(display);
			Date start_dt=new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("start_dt"));
			Date end_dt=new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("end_dt"));
			dto.setStart_dt(start_dt);
			dto.setEnd_dt(end_dt);
			
			int result=dao.updateDisplay();
			
			if(result>=0){
				result=dao.updateGoods(dto);
			}else result=0;
			
			request.setAttribute("result", result);
			request.setAttribute("pageSet", "/admin/goodsAdminUpdateFormPro.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return "/mall/cheapmall.jsp";
	}

}
