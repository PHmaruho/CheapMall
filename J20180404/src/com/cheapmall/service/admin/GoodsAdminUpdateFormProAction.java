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
			HttpSession session = request.getSession();
			String auth =session.getAttribute("auth") == null ? null : session.getAttribute("auth").toString();
			
			if(auth == null) {
				session.invalidate();
				return "Admin.jsp";
			}
			String sq=request.getParameter("sq");
			String cd=request.getParameter("cd");
			String nm=request.getParameter("nm");
			int price=Integer.parseInt(request.getParameter("price"));
			String gender=request.getParameter("gender");
			String top_category=request.getParameter("top_category");
			String middle_category=request.getParameter("middle_category");
			String color=request.getParameter("color")=="none"? null:request.getParameter("color");
			String goods_size=request.getParameter("goods_size")=="none"? null:request.getParameter("goods_size");
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
			dto.setGoods_size(goods_size);
			dto.setStock(stock);
			dto.setDisplay(display);
			Date start_dt=new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("start_dt"));
			Date end_dt=new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("end_dt"));
			dto.setStart_dt(start_dt);
			dto.setEnd_dt(end_dt);
			
			String startD=request.getParameter("start_dt");
			String endD=request.getParameter("end_dt");
			String[] sArr=startD.split("-");
			String[] eArr=endD.split("-");
			
			String start_dt1="";
			String end_dt1="";
			for(String s:sArr) start_dt1+=s;
			for(String s:eArr) end_dt1+=s;
			
			int sD=Integer.parseInt(start_dt1);
			int eD=Integer.parseInt(end_dt1);
			System.out.println("sD: "+sD);
			System.out.println("eD: "+eD);
			
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			String currentD="";
			Date d=new Date();
			currentD=sdf.format(d);
			String arr[]=currentD.split("-");
			currentD="";
			for(String s:arr){
				currentD+=s;
			}
			int cD=Integer.parseInt(currentD);
			System.out.println("cD: "+cD);
			
			int result=0;
			result=dao.updateDisplay();
			if (sD>eD) result=-1;
			else if((cD>sD) || (cD<eD)){
				result=-2;
				if((cD<=sD)&&(cD<=eD)&&(sD<eD)) result=dao.updateGoods(dto);
			}
			else{
				result=dao.updateGoods(dto);
			}
			
			request.setAttribute("result", result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return "/admin/goodsAdminUpdateFormPro.jsp";
	}

}
