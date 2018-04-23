package com.cheapmall.service.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.GoodsDao;
import com.cheapmall.dto.CodeDto;
import com.cheapmall.service.CommandProcess;

public class GoodsAdminInsertFormAction implements CommandProcess {

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
			GoodsDao gd = GoodsDao.getInstance();
			int startRow = 0;
			int endRow = gd.getCodeTotalCnt();
			List<CodeDto> list = gd.codeList(startRow, endRow);
			request.setAttribute("list", list);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return "goodsAdminInsertForm.jsp";
	}
}
