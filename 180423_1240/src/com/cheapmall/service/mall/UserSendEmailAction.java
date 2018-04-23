package com.cheapmall.service.mall;

import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.service.CommandProcess;
import com.cheapmall.service.SendEmail;

public class UserSendEmailAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String email = request.getParameter("email").toString();
			String certKey = randomKey();
			
			SendEmail sendEmail = new SendEmail();
			sendEmail.send(certKey, email);
			
			request.setAttribute("certKey", certKey);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "userSendEmail.jsp";
	}
	
	public String randomKey() {
		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();
		String[] str = {"!","@","#","$","%","^","&","*","?"};
		for (int i = 0; i < 10; i++) {
		    int rIndex = rnd.nextInt(4);
		    switch (rIndex) {
		    case 0:
		        temp.append((char) ((int) (rnd.nextInt(26)) + 97));
		        break;
		    case 1:
		        temp.append((char) ((int) (rnd.nextInt(26)) + 65));
		        break;
		    case 2:
		        temp.append((rnd.nextInt(10)));
		        break;
		    case 3:
		    	temp.append(str[(rnd.nextInt(9))]);
		    	break;
		    }
		}
		return temp.toString();
	}
}
