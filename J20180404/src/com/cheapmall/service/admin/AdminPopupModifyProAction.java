package com.cheapmall.service.admin;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.EtcDao;
import com.cheapmall.dto.PopupDto;
import com.cheapmall.service.CommandProcess;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class AdminPopupModifyProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			String path=request.getSession().getServletContext().getRealPath("/images/popup");
			int size= 2* 1024* 1024;
			
			MultipartRequest mr=null;
			
			System.out.println("경로: "+path);
			
			mr=new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
			
			String origin=mr.getOriginalFileName("url");
			String fileName=mr.getFilesystemName("url");
			
			String[] fileN= fileName.split("\\.");
			
			if(fileName==null||fileName.length()==0){
				System.out.println("fail");
			}else
				System.out.println("ok!");
			
			String url=fileN[0];
			
			String sq= mr.getParameter("sq");
			String nm=mr.getParameter("nm");
			String startDt=mr.getParameter("start_dt");
			System.out.println("startDt: "+startDt);
			
			//test!
			String[] d=startDt.split("-");
			String str="";
			for(String s:d){
				str+=s;
			}
			System.out.println("str: "+str);
			
			PopupDto dto=new PopupDto();
			EtcDao dao=EtcDao.getInstance();
			int result=0;
			
			dto.setSq(sq);
			dto.setNm(nm);
			dto.setUrl(url);
			Date start_dt= new Date();
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			start_dt=sdf.parse(startDt);
			
			dto.setStart_dt(start_dt);
			
			result=dao.modifyPopup(dto);
			request.setAttribute("result", result);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "adminPopupModifyPro.jsp";
	}

}
