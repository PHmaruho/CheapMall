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
			String path=request.getSession().getServletContext().getRealPath("/images/popup");
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
			String nm=mr.getParameter("nm");
			Date start_dt= new SimpleDateFormat("yyyy-MM-dd")
						.parse(mr.getParameter("start_dt"));
			Date end_dt=new SimpleDateFormat("yyyy-MM-dd")
						.parse(mr.getParameter("end_dt"));

			dto.setNm(nm);
			dto.setUrl(url);
			dto.setStart_dt(start_dt);
			dto.setEnd_dt(end_dt);
			dto.setSq(category);
			/*int result=dao.insertPopup(dto);*/
			
			/*request.setAttribute("result", result);*/
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "adminPopupAddFormPro.jsp";
	}

}
