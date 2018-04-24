package com.cheapmall.service.mall;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.awt.image.renderable.ParameterBlock;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.BoardDao;
import com.cheapmall.dto.ReviewDto;
import com.cheapmall.service.CommandProcess;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class UserWriteReviewProAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		try {
			HttpSession session = request.getSession();
			String id = session.getAttribute("id") == null ? null : session.getAttribute("id").toString();
			
			if(id == null) {
				return "reviewNotPro.jsp";
			}
			// String id = null;
			String goods_sq = null;
			String ip = null;
			String content = null;
			String path = null;
			String goods_cd = null;
			String dSq = "";
			int star = 0;
			if(request.getParameter("method").equals("simple")) {
				// id = request.getParameter("id");
				goods_sq = request.getParameter("goods_sq");
				ip = request.getParameter("ip");
				content = request.getParameter("content");
				goods_cd = request.getParameter("goods_cd");
				star = Integer.parseInt(request.getParameter("star"));
				dSq = request.getParameter("dSq");
				path = "";
			} else if(request.getParameter("method").equals("photo")) {
				
				FileInputStream fis = null;
				FileOutputStream fos = null;
				byte[] buf = new byte[1024];
				int read = 0;
				
				int maxSize = 5 * 1024 * 1024;
				String folderPath = "/images/review/origin/";
				String savePath = request.getSession().getServletContext().getRealPath(folderPath);
				MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "utf-8", new DefaultFileRenamePolicy());
				
				// session id get
				// id = multi.getParameter("id");
				goods_sq = multi.getParameter("goods_sq");
				ip = multi.getParameter("ip");
				content = multi.getParameter("content");
				goods_cd = multi.getParameter("goods_cd");
				star = Integer.parseInt(multi.getParameter("star"));
				dSq = multi.getParameter("dSq");
				
				String uploadName = multi.getFile("pic").getName() == null ? "" : multi.getFile("pic").getName();
				String realName = goods_sq;
				
				File oldFile = new File(savePath+uploadName);
				File newFile = new File(savePath + realName +".png");
				if(!newFile.exists()) {
				    newFile.createNewFile();
				} 
				if(uploadName == null || uploadName.equals("")) {
					System.out.println("not uploading file");
				} else {
					if(!oldFile.renameTo(newFile)){
			            // rename이 되지 않을경우 강제로 파일을 복사하고 기존파일은 삭제
			            buf = new byte[1024];
			            fis = new FileInputStream(oldFile);
			            fos = new FileOutputStream(newFile);
			            read = 0;
			            while((read=fis.read(buf,0,buf.length))!=-1){
			                fos.write(buf, 0, read);
			            }
			             
			            fis.close();
			            fos.close();
			            oldFile.delete();
			            
					}
					ParameterBlock pb = new ParameterBlock();
					pb.add(savePath+realName+".png");
					RenderedOp rOp = JAI.create("fileload", pb);
					BufferedImage bi = rOp.getAsBufferedImage();
					BufferedImage thumb = new BufferedImage(100, 100, BufferedImage.TYPE_INT_BGR);
					Graphics2D g = thumb.createGraphics();
					g.drawImage(bi, 0, 0, 100, 100, null);
					
					String thumbPath = request.getSession().getServletContext().getRealPath("/images/review/thumb/");
					File file = new File(thumbPath+"sm_"+realName+".png");
					ImageIO.write(thumb, "png", file);
				}
				path = goods_sq;
			}
			ReviewDto reviewDto = new ReviewDto();
			
			reviewDto.setUser_id(id);
			reviewDto.setContent(content);
			reviewDto.setGoods_cd(goods_cd);
			reviewDto.setContent(content);
			reviewDto.setStar(star);
			reviewDto.setPath(path);
			reviewDto.setIp(ip);

			
			BoardDao boardDao = BoardDao.getInstance();
			int result = boardDao.writeReview(reviewDto, dSq);
			request.setAttribute("result", 2);
			
//			if(result == 1) {
//				System.out.println("@@@@@@@@@@@@@@@@###SSSCUSUCSUCUSCUSUCSUCUS");
//			} else {
//				System.out.println("fail#####################################################");
//			}
			
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("UserWriteReviewProAction Error");
			e.printStackTrace();
		}
		return "reviewNotPro.jsp";
	}
}
