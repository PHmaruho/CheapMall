package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.GoodsDao;
import com.cheapmall.dto.CodeDto;
import com.cheapmall.service.CommandProcess;

public class CodeChangeProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String auth =session.getAttribute("auth") == null ? null : session.getAttribute("auth").toString();
		
		if(auth == null) {
			session.invalidate();
			return "Admin.jsp";
		}
		int result = 0;
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		String code = request.getParameter("code");
		String category = request.getParameter("category");
		String meaning = request.getParameter("meaning");
		String used = request.getParameter("used");
		CodeDto codeDto = new CodeDto();
		codeDto.setCd(code);
		codeDto.setCategory(category);
		codeDto.setMeaning(meaning);
		codeDto.setUsed(used);
		GoodsDao gd = GoodsDao.getInstance();

		result = gd.changeCode(codeDto);

		request.setAttribute("pageNum", pageNum);
		request.setAttribute("result", result);
		System.out.println("여기볼거에요 code : " + code + "  pageNum : " + pageNum);

		return "codeChangePro.jsp";
	}

}
