package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.GoodsDao;
import com.cheapmall.dto.CodeDto;
import com.cheapmall.service.CommandProcess;

public class CodeInsertProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		int result = 0;
		int codeCheckResult = 0;
		CodeDto codeDto = new CodeDto();
		String pageNum = request.getParameter("pageNum");
		String code = request.getParameter("code");
		String category = request.getParameter("category");
		String meaning = request.getParameter("meaning");
		String used = request.getParameter("used");

		codeDto.setCd(code);
		codeDto.setCategory(category);
		codeDto.setMeaning(meaning);
		codeDto.setUsed(used);

		GoodsDao gd = GoodsDao.getInstance();
		result = gd.checkCode(code);
		if (codeCheckResult == 0) {
			result = gd.insertCode(codeDto);
		}else if(codeCheckResult > 0){
			result = 0;
		}
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("result", result);
		System.out.println(pageNum + "  " + code + "  " + category + "  "+ meaning + "  " + used);
		System.out.println("인서트 반환값 : " + result);

		return "codeInsertPro.jsp";
	}

}
