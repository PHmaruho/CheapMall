package com.cheapmall.service.admin;

import java.io.File;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;


import com.cheapmall.dao.GoodsDao;
import com.cheapmall.service.CommandProcess;

public class ExcelProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String select = request.getParameter("select");
			GoodsDao gd = GoodsDao.getInstance();

			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet();
			HSSFRow row = null;
			HSSFCell cell = null;
			ArrayList<HashMap<String, String>> list = gd.khExcelList();
			if (select.equals("cj")) {
				row = sheet.createRow(0);
				cell = row.createCell(0);
				cell.setCellValue("번호");
				cell = row.createCell(1);
				cell.setCellValue("수령인");
				cell = row.createCell(2);
				cell.setCellValue("전화번호");
				cell = row.createCell(3);
				cell.setCellValue("주소");
				cell = row.createCell(4);
				cell.setCellValue("상품명");
				for (int i = 1; i < list.size() + 1; i++) {
					row = sheet.createRow(i);
					HashMap<String, String> test = list.get(i - 1);
					for (int j = 0; j < 5; j++) {
						cell = row.createCell(j);
						if (j == 0) {
							cell.setCellValue(i);
						} else if (j == 1) {
							cell.setCellValue(test.get("user_nm"));
						} else if (j == 2) {
							cell.setCellValue(test.get("tel"));
						} else if (j == 3) {
							cell.setCellValue(test.get("addr")
									+ test.get("addr_detail"));
						} else if (j == 4) {
							cell.setCellValue(test.get("goods_nm"));
						}
					}
				}
			} else if (select.equals("lozen")) {
				row = sheet.createRow(0);
				cell = row.createCell(0);
				cell.setCellValue("상품명");
				cell = row.createCell(1);
				cell.setCellValue("주소");
				cell = row.createCell(2);
				cell.setCellValue("수령인");
				cell = row.createCell(3);
				cell.setCellValue("전화번호");
				for (int i = 1; i < list.size() + 1; i++) {
					row = sheet.createRow(i);
					HashMap<String, String> test = list.get(i - 1);
					for (int j = 0; j < 4; j++) {
						cell = row.createCell(j);
						if (j == 0) {
							cell.setCellValue(test.get("goods_nm"));
						} else if (j == 1) {
							cell.setCellValue(test.get("addr")
									+ test.get("addr_detail"));
						} else if (j == 2) {
							cell.setCellValue(test.get("user_nm"));
						} else if (j == 3) {
							cell.setCellValue(test.get("tel"));
						}
					}
				}
			} else if (select.equals("post")) {
				row = sheet.createRow(0);
				cell = row.createCell(0);
				cell.setCellValue("주소");
				cell = row.createCell(1);
				cell.setCellValue("수령인");
				cell = row.createCell(2);
				cell.setCellValue("전화번호");
				cell = row.createCell(3);
				cell.setCellValue("상품명");
				for (int i = 1; i < list.size() + 1; i++) {
					row = sheet.createRow(i);
					HashMap<String, String> test = list.get(i - 1);
					for (int j = 0; j < 4; j++) {
						cell = row.createCell(j);
						if (j == 0) {
							cell.setCellValue(test.get("addr")
									+ test.get("addr_detail"));
						} else if (j == 1) {
							cell.setCellValue(test.get("goods_nm"));
						} else if (j == 2) {
							cell.setCellValue(test.get("tel"));
						} else if (j == 3) {
							cell.setCellValue(test.get("user_nm"));
						}
					}
				}
			}

			String fileName = select;
			try {

				for (int i = 0; i < 10000; i++) {
					File file = new File("c:/" + fileName + i + ".xls");
					if (file.exists()) {
						System.out.println("있는파일입니다");
					} else {
						file = new File("c:/" + fileName + i + ".xls");
						file.createNewFile();
						wb.write(file);
						String path = file.getAbsolutePath();
						System.out.println(path);
						request.setAttribute("path", path);
						break;
					}

				}
				// file을 생성할 폴더가 없으면 생성합니다
				/*
				 * FileOutputStream fileOutputStream = new FileOutputStream(file
				 * + File.separator + "ab.xls");
				 */
				// 생성한 엑셀파일을 outputStream 해줍니다.
				/* fileOutputStream.close(); */
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				wb.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "excelPro.jsp";
	}
}