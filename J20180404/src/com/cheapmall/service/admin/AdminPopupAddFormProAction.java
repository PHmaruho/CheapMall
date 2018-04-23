package com.cheapmall.service.admin;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
			HttpSession session = request.getSession();
			String auth =session.getAttribute("auth") == null ? null : session.getAttribute("auth").toString();
			
			if(auth == null) {
				session.invalidate();
				return "Admin.jsp";
			}
			
			String path=request.getSession().getServletContext().getRealPath("/images/popup");
			/*String path="C:/jsp/Sources1/J20180404/WebContent/images/popup";*/
			int size= 2*1024*1024;
			int result=0;
			MultipartRequest mr=null;
			
			
			mr=new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
			
			String origin= mr.getOriginalFileName("url");
			String fileName=mr.getFilesystemName("url");
			
			String[] fileN=fileName.split("\\.");
			String url=fileN[0];
			
			PopupDto dto=new PopupDto();
			EtcDao dao=EtcDao.getInstance();
			
			String category=mr.getParameter("category");
			String nm=mr.getParameter("nm");
			
			String startD=mr.getParameter("start_dt");
			String endD=mr.getParameter("end_dt");
			System.out.println("start: "+startD);
			System.out.println("end: "+endD);
			String[] sArr=startD.split("-");
			String[] eArr=endD.split("-");
			
			String start_dt="";
			String end_dt="";
			for(String s:sArr) start_dt+=s;
			for(String s:eArr) end_dt+=s;
			
			int sD=Integer.parseInt(start_dt);
			int eD=Integer.parseInt(end_dt);
			System.out.println("sD: "+sD);
			System.out.println("eD: "+eD);
			
			String currentD="";
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			Date d=new Date();
			currentD=sdf.format(d);
			String arr[]=currentD.split("-");
			currentD="";
			for(String s:arr){
				currentD+=s;
			}
			int cD=Integer.parseInt(currentD);

			dto.setNm(nm);
			dto.setUrl(url);
			dto.setSq(category);
			System.out.println("cD: "+cD);
			if (sD>eD) result=-1;
			else if((cD>sD) || (cD<eD)){
				result=-2;
				if((cD<=sD)&&(cD<=eD)&&(sD<=eD)) result=dao.insertPopup(dto,start_dt,end_dt);
			}
			else{
				result=dao.insertPopup(dto,start_dt,end_dt);
			}
			
			request.setAttribute("result", result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "adminPopupAddFormPro.jsp";
	}

}
