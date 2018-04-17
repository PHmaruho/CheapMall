package com.cheapmall.service.admin;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.cheapmall.dao.EtcDao;
import com.cheapmall.service.CommandProcess;import jdk.nashorn.internal.runtime.regexp.joni.exception.JOniException;

public class SearchManagerProAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			String select = request.getParameter("overlap");
			String keyword = request.getParameter("keyword");
			
			EtcDao etcDao = EtcDao.getInstance();
			
			JSONObject jsonObject = new JSONObject();
			
			//JSONArray jsonList = new JSONArray();
			if(select.equals("overlap")) {
				
				int result = etcDao.searchKeyword(keyword);
				
				if(result == 0) {
					jsonObject.put("result", "데이터가 없습니다");
					jsonObject.put("value", result);
					//jsonList.add(jsonObject);
				} else {
					jsonObject.put("result", "데이터가 중복됩니다.");
					jsonObject.put("value", result);
					//jsonList.add(jsonObject);
				}
			} else if(select.equals("search")){
				jsonObject = etcDao.searchTagGet(keyword);
				//jsonList.add(jsonObject);
			} else if(select.equals("regist")) {
				String transKeyword = request.getParameter("transKeyword");
				int result = etcDao.registKeyword(keyword, transKeyword);
				
				if(result == 1) {
					jsonObject.put("result", "등록되었습니다");
				} else {
					jsonObject.put("result", "등록이 안됬습니다.");
				}
				
			} else if(select.equals("modify")) {
				jsonObject = etcDao.getKeyword(keyword);
			} else if(select.equals("delete")) {
				String[] deleteList = request.getParameterValues("deleteArray[]");
		
				jsonObject = etcDao.deleteKeyword(deleteList);
			} else if(select.equals("trans")) {
				
				jsonObject = transKeywordAction(keyword);
			}
			
			jsonObject.put("overlap", select);
			
			request.setAttribute("jsonObject", jsonObject);
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("SearchManagerProAction Error");
			e.printStackTrace();
		}
		
		return "/admin/searchManagerPro.jsp";
	}
	
	private JSONObject transKeywordAction(String keyword) {
		JSONObject transkeyword = new JSONObject();
		try {
			String[] cho = {"ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"};
			String[] jun = {"ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"};
			String[] jon = {"", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"};
			
			int nCho = 0, nJun = 0, nJon = 0;
			int temp = 0;
			
			List<String> word = new ArrayList<>();
			for(int i=0 ; i<keyword.length() ; i++) {
				temp = keyword.codePointAt(i) - 0xAC00;
				
				// 한글 외의 글자가 오면 처리한다.
				if((int)keyword.charAt(i) < 255) {
					word.add(keyword.charAt(i) + "");
				}
				// 한글이 올 때, 처리한다.
				else if(keyword.codePointAt(i) > 0xAC00 || keyword.codePointAt(i) < 0xD7A3) {
					
					
					nJon = temp % 28;
					nJun = ((temp - nJon) / 28) % 21;
					nCho = (((temp - nJon) / 28) - nJun) / 21;
					// 자음만 입력됬을 때를 고려한다.
					if(0x3131 <= keyword.codePointAt(i) && 0x314e >= keyword.codePointAt(i)) {
						word.add(keyword);
						continue;
					}else {
						word.add(cho[nCho]);
						word.add(jun[nJun]);
						
						if(nJon != 0) {
							switch (nJon) {
								case 3: word.add("ㄱ"); word.add("ㅅ"); break;
								case 5: word.add("ㄴ"); word.add("ㅈ"); break;
								case 6: word.add("ㄴ"); word.add("ㅎ"); break;
								case 9: word.add("ㄹ"); word.add("ㄱ"); break;
								case 10: word.add("ㄹ"); word.add("ㅁ"); break;
								case 11: word.add("ㄹ"); word.add("ㅂ"); break;
								case 12: word.add("ㄹ"); word.add("ㅅ"); break;
								case 13: word.add("ㄹ"); word.add("ㅌ"); break;
								case 14: word.add("ㄹ"); word.add("ㅍ"); break;
								case 15: word.add("ㄹ"); word.add("ㅎ"); break;
								case 18: word.add("ㅂ"); word.add("ㅅ"); break;
								default: word.add(jon[nJon] ); break;
							}
						}
					}
				}
			}
			String str = "";
			for(int i=0 ; i<word.size() ; i++) {
				str += word.get(i);
			}
			transkeyword.put("result", str);
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("transKeywordAction Error");
			e.printStackTrace();
		}
		return transkeyword;
	}
}
