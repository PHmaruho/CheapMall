package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.EtcDao;
import com.cheapmall.dto.PopupDto;
import com.cheapmall.service.CommandProcess;

public class AdminPopupModifyFormAction implements CommandProcess{

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
			
			PopupDto dto=new PopupDto();
			EtcDao dao=EtcDao.getInstance();
					
			dto=dao.getPopupInfo(sq);
			
			request.setAttribute("sq", sq);
			request.setAttribute("url", dto.getUrl());
			request.setAttribute("nm", dto.getNm());
			request.setAttribute("start_dt", dto.getStart_dt());
			request.setAttribute("end_dt", dto.getEnd_dt());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/admin/adminPopupModifyForm.jsp";
	}

}
