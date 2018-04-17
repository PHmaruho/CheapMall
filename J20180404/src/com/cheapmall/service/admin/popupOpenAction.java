package com.cheapmall.service.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.EtcDao;
import com.cheapmall.service.CommandProcess;

public class popupOpenAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		try {
			EtcDao dao=EtcDao.getInstance();
			List<String> urlL=new ArrayList<>();
			urlL=dao.getPopupUrl();
			Collections.shuffle(urlL);
			String url=urlL.get(0);
			request.setAttribute("url", url);
			
			for(int i=0;i<urlL.size();i++){
				System.out.println(urlL.get(i));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/admin/popupOpenList.jsp";
	}

}
