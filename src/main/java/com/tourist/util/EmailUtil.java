package com.tourist.util;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.*;
import java.io.*;

public class EmailUtil {

    public static void sendEmailWithAttachment(String toEmail, String touristName, String subject, File pdfAttachment)
            throws MessagingException, IOException {

        final String fromEmail = "abdulazeez55265@gmail.com"; // ✅ Your email
        final String password = "rugusvjevrdkwphn";           // ✅ App password

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(fromEmail, "Saad Travels"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(subject);

        // Email Body (HTML)
        String htmlMessage = "<h3>Dear " + touristName + ",</h3>"
                + "<p>Thank you for booking with <strong>Saad Travels</strong>! Your trip details are confirmed.</p>"
                + "<p>Attached is your official booking receipt in PDF format.</p>"
                + "<br><p>We wish you a wonderful journey!</p>"
                + "<br><p>Warm regards,<br><strong>Team Saad Travels</strong></p>";

        // Text Part
        MimeBodyPart textPart = new MimeBodyPart();
        textPart.setContent(htmlMessage, "text/html; charset=utf-8");

        // Attachment Part
        MimeBodyPart attachmentPart = new MimeBodyPart();
        attachmentPart.attachFile(pdfAttachment);

        // Multipart
        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(textPart);
        multipart.addBodyPart(attachmentPart);

        message.setContent(multipart);

        Transport.send(message);
    }
}
