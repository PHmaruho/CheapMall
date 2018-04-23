package com.cheapmall.service;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
public class SendEmail {
    public SendEmail(){}
    
    final String username="CheapMallMailService";
    final String password="CheapMallMailServicepass";
    
    public void send(String key, String email){
        Properties props = new Properties(); 
        props.put("mail.smtp.host", "smtp.gmail.com"); 
        props.put("mail.smtp.port", "25"); 
        props.put("mail.debug", "true"); 
        props.put("mail.smtp.auth", "true"); 
        props.put("mail.smtp.starttls.enable","true"); 
        props.put("mail.smtp.EnableSSL.enable","true");
        props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");   
        props.setProperty("mail.smtp.socketFactory.fallback", "false");   
        props.setProperty("mail.smtp.port", "465");   
        props.setProperty("mail.smtp.socketFactory.port", "465"); 
    
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
        	protected PasswordAuthentication getPasswordAuthentication() {
        		return new PasswordAuthentication(username, password); 
        	}});
        try{
            Message message = new MimeMessage(session); 
            message.setFrom(new InternetAddress("CheapMallMailService@gmail.com"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email)); 
            message.setSubject("Cheap Mall 인증 메일입니다.");
            message.setText(key);
            Transport.send(message); 
            
        } catch(Exception e){
            e.printStackTrace();
        }
    }    
}
