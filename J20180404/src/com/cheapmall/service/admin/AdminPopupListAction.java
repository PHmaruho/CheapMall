package com.cheapmall.service.admin;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.EtcDao;
import com.cheapmall.dto.PopupDto;
import com.cheapmall.service.CommandProcess;

public class AdminPopupListAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("adminpoupList action ok");
		try {
			EtcDao dao=EtcDao.getInstance();
			List<PopupDto> mainList=new ArrayList<PopupDto>();
			List<PopupDto> subList=new ArrayList<PopupDto>();
			mainList=dao.getPopupMain();
			subList=dao.getPopupSub();
			int mainCount=mainList.size();
			int subCount=subList.size();
			
			request.setAttribute("mainList", mainList);
			request.setAttribute("subList", subList);
			request.setAttribute("mainCount", mainCount);
			request.setAttribute("subCount", subCount);
			/*request.setAttribute("pageSet", "/admin/adminPopupList.jsp");*/
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return "adminPopupList.jsp";
	}

}
