package com.cheapmall.service.mall;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.service.CommandProcess;

public class UserLoginProAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
			try {
				String id = request.getParameter("id");
				String pw = request.getParameter("pw");
				
				String gender = request.getParameter("gender") == null ? "" : request.getParameter("gender");
				String top_category = request.getParameter("top_category") == null ? "" : request.getParameter("top_category");
				String middle_category = request.getParameter("middle_category") == null ? "" : request.getParameter("middle_category");
				
				request.setAttribute("gender", gender);
				request.setAttribute("top_category", top_category);
				request.setAttribute("middle_category", middle_category);
				
				MemberDao memberDao = MemberDao.getInstance();
				int result = memberDao.userLoginCheck(id, pw);
				if(result == 1) {
					// 로그인 성공 시, session에 id를 저장한다.
					HttpSession session = request.getSession();
					session.setAttribute("id", id);
					
					String email = memberDao.checkGrade(id);	// 2018-04-13 최우일 : 회원등급 체크 후 null이면 미인증 사용자로 판단, 이메일인증 유도
					if (email != null) {
						request.setAttribute("email", email);
						session.setAttribute("id", id);
						request.setAttribute("pageSet", "/mall/userLoginAuthEmailForm.jsp");
						return "/mall/cheapmall.jsp";
					}
					
					int pwDate = memberDao.checkPwDt(id);	// 2018-04-18 최우일 : 비밀번호 변경일 검사
					if (pwDate == 1) {
						session.setAttribute("id", id);
						request.setAttribute("pageSet", "userChangePwDtForm.jsp");
						return "/mall/cheapmall.jsp";
					}
					
					//List 화면에서 로그인 시
					if(!gender.equals("") && !top_category.equals("") && !middle_category.equals("")) {
						request.setAttribute("returnPage", "list");
					}
					
					
				} else {
					request.setAttribute("result", result);
					request.setAttribute("pageSet", "/mall/userLoginPro.jsp");
					return "/mall/cheapmall.jsp";
				}
				
				Date report = memberDao.checkReport(id);	//	2018-04-22 최우일 : 정지회원 검사
				if (report != null) {
					request.setAttribute("report", report);
					request.setAttribute("pageSet", "/mall/userLoginPro.jsp");
					return "/mall/cheapmall.jsp";
				}
				
				request.setAttribute("result", result);
				request.setAttribute("returnList", "main");
			} catch (Exception e) {
				// TODO: handle exception
				// SYSO
				System.out.println("UserLoginProAction Error");
				e.printStackTrace();
			}
			
			return "/mall/cheapmall.jsp";
	}
}