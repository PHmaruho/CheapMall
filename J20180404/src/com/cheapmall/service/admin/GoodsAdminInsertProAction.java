package com.cheapmall.service.admin;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.awt.image.renderable.ParameterBlock;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;

import javax.imageio.ImageIO;
import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.GoodsDao;
import com.cheapmall.dto.GoodsDto;
import com.cheapmall.service.CommandProcess;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class GoodsAdminInsertProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			// --------------------------------------------------------------------------------------------------------
			String imagePath = request.getSession().getServletContext()
					.getRealPath("/images");
			System.out.println(imagePath);
			int image_size = 1024*1024*24;
			String filename = "";
			MultipartRequest multi = new MultipartRequest(request, imagePath,
					image_size, "utf-8", new DefaultFileRenamePolicy());
			// -------------------------------상품정보 db에
			// 입력------------------------------------------------------
			int result = 0;
			GoodsDao gd = GoodsDao.getInstance();
			GoodsDto gt = new GoodsDto();
			String gender = multi.getParameter("gender");
			String top_category = multi.getParameter("top_category");
			String middle_category = multi.getParameter("middle_category");
			String size = multi.getParameter("size");
			String cd = gd.createGoodsCode(gender, top_category,
					middle_category);
			String start_dt = multi.getParameter("start_dt");
			String end_dt = multi.getParameter("end_dt");
			Date start_date = new SimpleDateFormat("yyyy-MM-dd")
					.parse(start_dt);
			Date end_date = new SimpleDateFormat("yyyy-MM-dd").parse(end_dt);
			gt.setCd(cd);
			gt.setNm(multi.getParameter("nm"));
			gt.setStart_dt(start_date);
			gt.setEnd_dt(end_date);
			gt.setPrice(Integer.parseInt(multi.getParameter("price")));
			gt.setGender(gender);
			gt.setTop_category(top_category);
			gt.setMiddle_category(middle_category);
			gt.setColor(multi.getParameter("color"));
			gt.setGoods_size(size);
			gt.setStock(Integer.parseInt(multi.getParameter("stock")));
			gt.setDisplay(multi.getParameter("display"));
			result = gd.insertAdminGoods(gt);
			request.setAttribute("result", result);
			// -----------------------------------입력한 상품정보를 가지고 사진경로
			// 지정----------------------------------
			String imagePath_original = request
					.getSession()
					.getServletContext()
					.getRealPath(
							"/images/" + gender + "/" + top_category + "/"
									+ middle_category + "/original");
			String imagePath_thumbnail = request
					.getSession()
					.getServletContext()
					.getRealPath(
							"/images/" + gender + "/" + top_category + "/"
									+ middle_category + "/thumbnail");
			String sq = gd.goodsAdminGetSq();
			Enumeration files = multi.getFileNames();
			String file = (String) files.nextElement();
			filename = multi.getFilesystemName(file);

			int i = -1;
			i = filename.lastIndexOf("."); // 파일 확장자 위치
			String kind = filename.substring(i + 1, filename.length()); // 파일
																		// 확장자
			// -----------------------------------------------------
			// --------------------파일이동(image -> original)-------
			FileInputStream fis = new FileInputStream(imagePath + "/"
					+ filename);
			FileOutputStream fos = new FileOutputStream(imagePath_original
					+ "/" + sq + "." + "png");

			int data = 0;
			while ((data = fis.read()) != -1) {
				fos.write(data);
			}
			fis.close();
			fos.close();
			// --------------------------------------------------------------
			// ------------------처음 사진 삭제----------------------------------
			File deleteFile = new File(imagePath + "/" + filename);
			deleteFile.delete();
			// ---------------------------------------------------------------
			// -----------썸네일 만들기--------------------------
			ParameterBlock pb = new ParameterBlock();
			pb.add(imagePath_original + "/" + sq + "." + "png");
			RenderedOp rOp = JAI.create("fileload", pb);
			BufferedImage bi = rOp.getAsBufferedImage();
			BufferedImage thumb = new BufferedImage(100, 100,
					BufferedImage.TYPE_INT_RGB);
			Graphics2D g = thumb.createGraphics();
			g.drawImage(bi, 0, 0, 100, 100, null);
			File thumb_file = new File(imagePath_thumbnail + "/sm_" + sq + "."
					+ "png");
			ImageIO.write(thumb, "png", thumb_file);
			// ----------------------------------------------------

		} catch (Exception e) {
			System.out.println("GoodsAdminInsertProAction.java에서 에러");
			System.out.println(e.getMessage());
		}

		return "goodsAdminInsertPro.jsp";
	}
}