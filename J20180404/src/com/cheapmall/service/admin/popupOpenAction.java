package com.cheapmall.service.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.EtcDao;
import com.cheapmall.service.CommandProcess;

public class popupOpenAction implements CommandProcess {

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
			EtcDao dao=EtcDao.getInstance();
			String c=request.getParameter("sub")==null? "main":request.getParameter("sub");
			List<String> urlL=new ArrayList<>();
			urlL=dao.getPopupUrl(c);
			int result=0;
			
			if (urlL==null||urlL.size()==0){
				result=0;
			}else{
				Collections.shuffle(urlL);
				String url=urlL.get(0);
				request.setAttribute("url", url);
				result=1;
			}
			
			request.setAttribute("result", result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/admin/popupOpenList.jsp";
	}

}
