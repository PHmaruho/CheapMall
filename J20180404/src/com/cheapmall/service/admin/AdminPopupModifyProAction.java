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
			
			
			mr=new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
			
			String origin=mr.getOriginalFileName("url");
			String fileName=mr.getFilesystemName("url");
			
			
			
			String sq= mr.getParameter("sq");
			String nm=mr.getParameter("nm");
			String startD=mr.getParameter("start_dt");
			String endD=mr.getParameter("end_dt");
			
			
			
			/*String dateCompare=new SimpleDateFormat("yyyy-MM-dd").format(new Date());*/
			
			PopupDto dto=new PopupDto();
			EtcDao dao=EtcDao.getInstance();
			int result=0;
			
			dto.setSq(sq);
			dto.setNm(nm);
			Date start_dt= new Date();
			Date end_dt=new Date();
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			start_dt=sdf.parse(startD);
			end_dt=sdf.parse(endD);
			dto.setStart_dt(start_dt);
			dto.setEnd_dt(end_dt);
			
			String[] sArr=startD.split("-");
			String[] eArr=endD.split("-");
			
			String start_dt1="";
			String end_dt1="";
			for(String s:sArr) start_dt1+=s;
			for(String s:eArr) end_dt1+=s;
			
			int sD=Integer.parseInt(start_dt1);
			int eD=Integer.parseInt(end_dt1);
			System.out.println("sD: "+sD);
			System.out.println("eD: "+eD);
			
			String currentD="";
			Date d=new Date();
			currentD=sdf.format(d);
			String arr[]=currentD.split("-");
			currentD="";
			for(String s:arr){
				currentD+=s;
			}
			int cD=Integer.parseInt(currentD);
			System.out.println("cD: "+cD);
			if (sD>eD) result=-1;
			else if((cD>sD) || (cD<eD)){
				result=-2;
				if((cD<=sD)&&(cD<=eD)&&(sD<eD)) result=dao.modifyPopup(dto);
			}
			else{
				result=dao.modifyPopup(dto);
			}
			
			
			request.setAttribute("result", result);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "adminPopupModifyPro.jsp";
	}

}
