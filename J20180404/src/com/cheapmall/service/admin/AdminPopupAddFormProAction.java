package com.cheapmall.service.admin;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.EtcDao;
import com.cheapmall.dto.PopupDto;
import com.cheapmall.service.CommandProcess;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class AdminPopupAddFormProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		try {
/*			String path=request.getSession().getServletContext().getRealPath("/images/popup");*/
			String path="C:/jsp/Sources1/J20180404/WebContent/images/popup";
			int size= 2*1024*1024;
			
			MultipartRequest mr=null;
			
			System.out.println("path: "+path);
			
			mr=new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
			
			String origin= mr.getOriginalFileName("url");
			String fileName=mr.getFilesystemName("url");
			
			if(fileName==null|| fileName.length()==0){
				System.out.println("fail");
			}else System.out.println("ok!");
			
			String[] fileN=fileName.split("\\.");
			String url=fileN[0];
			
			PopupDto dto=new PopupDto();
			EtcDao dao=EtcDao.getInstance();
			
			String category=mr.getParameter("category");
			System.out.println("category: "+category);
			String nm=mr.getParameter("nm");
			
			String startD=mr.getParameter("start_dt");
			String endD=mr.getParameter("end_dt");
			System.out.println("startD: "+startD);
			System.out.println("endD: "+endD);
			
			String[] sArr=startD.split("-");
			String[] eArr=endD.split("-");
			
			String start_dt="";
			String end_dt="";
			for(String s:sArr) start_dt+=s;
			for(String s:eArr) end_dt+=s;
			
			dto.setNm(nm);
			dto.setUrl(url);
			dto.setSq(category);
			int result=dao.insertPopup(dto,start_dt,end_dt);
			
			request.setAttribute("result", result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "adminPopupAddFormPro.jsp";
	}

}
