package utils;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import model.Movie;

public class SendMail {
	public static void shareMovie(Movie m, String emailCC) {
		String username = "locphan0508@gmail.com";
		String password = "Loc0935071434";
		String to = emailCC;

		String subject = "Một bộ phim đã được chia sẻ với bạn!!";
		String content = m.getTitle() + " thuộc thể loại " + m.getCategory().getNameCategory() +
				" với những nội dung xoay quanh hấp dẫn. \n"+"Link phim: " + m.getLinkEmbed();
		 Properties prop = new Properties();
         prop.put("mail.smtp.host", "smtp.gmail.com");
         prop.put("mail.smtp.port", "587");
         prop.put("mail.smtp.auth", "true");
         prop.put("mail.smtp.starttls.enable", "true"); //TLS

         Session session = Session.getInstance(prop,
                 new javax.mail.Authenticator() {
                     protected PasswordAuthentication getPasswordAuthentication() {
                         return new PasswordAuthentication(username, password);
                     }
                 });
         try {
             Message message = new MimeMessage(session);
             message.setFrom(new InternetAddress(username));
             message.setRecipients(
                     Message.RecipientType.CC,
                     InternetAddress.parse(to)
             );
             message.setSubject(subject);
             message.setText(content);
             Transport.send(message);	
             System.out.println("Success");
		} catch (Exception e) {
			e.printStackTrace();
		}
		}
}
