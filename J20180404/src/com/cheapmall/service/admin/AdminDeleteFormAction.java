package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.service.CommandProcess;

public class AdminDeleteFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			
			int result = 0 ;
			int count = 0 ;
		
		try {
		
		
			MemberDao md = MemberDao.getInstance();

		//	String search=request.getParameter("search");
			String[] checkRow = request.getParameterValues("checkRow");
			String[] id       = request.getParameterValues("id");
		

			for(int i=0; i < checkRow.length; i++) {
				if(checkRow[i].equals("1")) {
					result= md.adminDelete(id[i]);
					count += result;
				}
				
			}

		}catch (Exception e) { System.out.println(e.getMessage()); }
		

		return "AdminForm.admin";
		
	}

}
