package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.service.CommandProcess;

public class BoardAdminOtherContentGoodsAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String goods_sq = request.getParameter("goods_sq");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "boardAdminOtherReplyGoods.jsp";
	}
}
