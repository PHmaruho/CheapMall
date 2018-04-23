package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.GoodsDao;
import com.cheapmall.dto.CodeDto;
import com.cheapmall.service.CommandProcess;

public class CodeChangeFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String auth =session.getAttribute("auth") == null ? null : session.getAttribute("auth").toString();
		
		if(auth == null) {
			session.invalidate();
			return "Admin.jsp";
		}
		String code = request.getParameter("code");
		String pageNum = request.getParameter("pageNum");
		GoodsDao gd = GoodsDao.getInstance();
		CodeDto codeDto = gd.selectCode(code);
		String used = ""+codeDto.getUsed();
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("codeDto", codeDto);
		request.setAttribute("used", used);
		return "codeChangeForm.jsp";
	}

}