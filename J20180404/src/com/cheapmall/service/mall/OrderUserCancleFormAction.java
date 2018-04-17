package com.cheapmall.service.mall;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.GoodsDao;
import com.cheapmall.dao.OrderDao;
import com.cheapmall.dto.CodeDto;
import com.cheapmall.service.CommandProcess;

public class OrderUserCancleFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 세션으로 유저 아이디 받아오기
		HttpSession session = request.getSession();
		String id = session.getAttribute("id") ==  null ? null : session.getAttribute("id").toString();
		// -------------------------
		OrderDao od = OrderDao.getInstance();
		try {
			List<HashMap> list = od.khOrderList(id);
			request.setAttribute("list", list);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		request.setAttribute("pageSet", "/mall/orderUserCancleForm.jsp");
		return "/mall/cheapmall.jsp";
	}

}
