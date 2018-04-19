package com.cheapmall.service.mall;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.OrderDao;
import com.cheapmall.dto.OrdersDto;
import com.cheapmall.service.CommandProcess;

public class OrderUserCancleProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id = session.getAttribute("id") == null ? null : session.getAttribute("id").toString();
		
		if(id == null) {
			request.setAttribute("warning", "notLogin");
			return "cheapmall.jsp";
		}
		
		String[] detail_sq = request.getParameterValues("check");
		int result = 0;
		int result2 = 0;
		List<HashMap>[] list = null;
		OrderDao od = OrderDao.getInstance();
		try {
			result = od.khOrderCancle(detail_sq);
			HashSet<String> set = od.khGetOrder_Sq(detail_sq);
			list = new ArrayList[set.size()];
			Object[] valueList = set.toArray();
			for (int i = 0; i < valueList.length; i++) {
				list[i] = od.khReMakeOrderList(valueList[i].toString());
			}

			for (int i = 0; i < list.length; i++) {
				int control = 0;
				int size = list[i].size();
				for (int j = 0; j < size; j++) {

							+ list[i].size());
					HashMap testMap = new HashMap();
					testMap = list[i].get(j - control);
					for (int k = 0; k < detail_sq.length; k++) {
						if (testMap.get("detail_sq").equals(detail_sq[k])) {
							list[i].remove(j - control);
							++control;
							break;
						}
					}
				}
			}
			// -------------------------------주문 재등록--------------
			for (int i = 0; i < list.length; i++) {
				OrdersDto orderDto = new OrdersDto();
				orderDto.setOrigin_price(0);
				orderDto.setDc_price(0);
				if (list[i].size() > 0) {
					for (int j = 0; j < list[i].size(); j++) {
						HashMap testMap = new HashMap();
						testMap = list[i].get(j);
						String user_id = "" + testMap.get("user_id");
						String pay_method = "" + testMap.get("pay_method");
						int use_point = Integer.parseInt(""
								+ testMap.get("use_point"));
						String addr = "" + testMap.get("addr");
						String addr_detail = "" + testMap.get("addr_detail");
						Date order_dt = (Date) testMap.get("order_dt");
						String order_sq = "" + testMap.get("order_sq");
						int origin_price = Integer.parseInt(""
								+ testMap.get("origin_price"));
						int cnt = Integer.parseInt("" + testMap.get("cnt"));

						orderDto.setOrder_sq(order_sq);
						orderDto.setUser_id(user_id);
						orderDto.setOrigin_price(orderDto.getOrigin_price()
								+ origin_price * cnt);
						orderDto.setDc_price(orderDto.getDc_price()
								+ origin_price * cnt / 10);
						orderDto.setPay_method(pay_method);
						orderDto.setUse_point(use_point);
						if (orderDto.getOrigin_price() >= 30000) {
							orderDto.setDelivery_fee(0);
						} else {
							orderDto.setDelivery_fee(3000);
						}
						orderDto.setAddr(addr);
						orderDto.setAddr_detail(addr_detail);
						orderDto.setOrder_cd("O1");
						orderDto.setOrder_dt(order_dt);
								+ orderDto.getOrigin_price());
								+ orderDto.getDelivery_fee());
					}
					result2 = od.khOrderReInsert(list[i], orderDto);
				}
			}
			request.setAttribute("result", result2);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		request.setAttribute("pageSet", "/mall/orderUserCanclePro.jsp");
		return "/mall/cheapmall.jsp";
	}
}
