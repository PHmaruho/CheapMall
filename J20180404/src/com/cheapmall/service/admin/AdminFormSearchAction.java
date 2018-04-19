package com.cheapmall.service.admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.dto.AdminDto;
import com.cheapmall.service.CommandProcess;

public class AdminFormSearchAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

			int index = 0;
			int count = 0;
		
		try {
			String how=request.getParameter("how");
			String search=request.getParameter("search");
	
			
			
			MemberDao md = MemberDao.getInstance();
			ArrayList<AdminDto> list = md.searchAdmin(how, search);
			
//			if(search==null || search.length()==0) {
//				count=md.getCount();
//			} else {
//				count=md.searchCount(search);
//			} 
			
//			if(how=="1") {  //이름
//				index=0;
//				System.out.println("index0->"+index+search);
//			}else if(how=="2") {//권한
//				index=1;
//				System.out.println("index1->"+index+search);
//			}else {  //부서
//				index=2;
//				System.out.println("index2->"+index);
//			}
			
						
			request.setAttribute("count", list.size());
			request.setAttribute("adminList", list);
			
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		
		return "adminForm.jsp";
	}

}
