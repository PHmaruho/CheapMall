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
			System.out.println("AdminDeleteFormAction start" );
		
		
			MemberDao md = MemberDao.getInstance();

		//	String search=request.getParameter("search");
			String[] checkRow = request.getParameterValues("checkRow");
			String[] id       = request.getParameterValues("id");
			System.out.println("checkRow count 방금?->" +checkRow.length);
			for (int i = 0; i < checkRow.length; i++) {
				System.out.println(checkRow[i]);
			}
			for (int i = 0; i < checkRow.length; i++) {
				System.out.println(id[i]);
			}
		

			for(int i=0; i < checkRow.length; i++) {
				if(checkRow[i].equals("1")) {
					System.out.println("AdminDeleteFormAction id[i]->"+id[i]); 
					result= md.adminDelete(id[i]);
					System.out.println("result?"+result);
					count += result;
				}
				
			}

		}catch (Exception e) { System.out.println(e.getMessage()); }
		
		System.out.println("AdminDeleteFormAction count->" +count);

		return "AdminForm.admin";
		
	}

}
