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
			List<PopupDto> list=new ArrayList<PopupDto>();
			
			list=dao.getPopupInfo();
			int count=list.size();
			
			request.setAttribute("count", count);
			request.setAttribute("listP", list);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return "adminPopupList.jsp";
		
	}

}
