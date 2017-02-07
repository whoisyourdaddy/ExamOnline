package com.xurui.util;


import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

/**
 * 
 * 操作邮件的工具类，该工具类初始化需提供了发送者邮箱地址等信息 发送支持多个收件人，附件 html 及文本
 * 
 * @author sunny.sun
 * @version 1.0
 *
 */
public class MailUtil {

	// 定义发件人别名
	private String displayName;

	// 邮件发送者
	private String from;

	// 邮件服务器
	private String smtpServer;

	// 用户名
	private String username;

	// 密码
	private String password;

	// 字符集
	private String charset = "utf-8";

	/**
	 * 初始化SMTP服务器地址
	 * 
	 * @param smtpServer
	 *            服务器地址
	 * @param from
	 *            发送者
	 * @param displayName
	 *            别名
	 * @param username
	 *            用户名
	 * @param password
	 *            密码
	 */
	public MailUtil(String smtpServer, String from, String displayName,
			String username, String password) {
		this.smtpServer = smtpServer;
		this.from = from;
		this.displayName = displayName;
		this.username = username;
		this.password = password;
	}

	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String getSmtpServer() {
		return smtpServer;
	}

	public void setSmtpServer(String smtpServer) {
		this.smtpServer = smtpServer;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getCharset() {
		return charset;
	}

	public void setCharset(String charset) {
		this.charset = charset;
	}

	/**
	 * @param to
	 *            发送地址
	 * @param isAuth
	 *            是否需要认证
	 * @param subject
	 *            主题
	 * @param content
	 *            内容
	 * @param isHtml
	 *            是否是html
	 * @param files
	 *            附件
	 * @return
	 * @throws MessagingException
	 * @throws UnsupportedEncodingException
	 */
	public void send(String[] tos, boolean isAuth, String subject,
			String content, boolean isHtml, File[] files)
			throws MessagingException, UnsupportedEncodingException {
		Session session = null;
		Properties props = System.getProperties();
		props.put("mail.smtp.host", smtpServer);
		if (isAuth) { // 服务器需要身份认证
			props.put("mail.smtp.auth", "true");
			// 生成认证的Authenticator
			Authenticator authenticator = new Authenticator() {
				protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
					return new javax.mail.PasswordAuthentication(username,
							password);
				}
			};
			session = Session.getDefaultInstance(props, authenticator);
		} else {
			props.put("mail.smtp.auth", "false");
			session = Session.getDefaultInstance(props, null);
		}
		// 是否debug
		session.setDebug(false);
		Transport trans = session.getTransport("smtp");

		// 多个接收人
		InternetAddress[] address = new InternetAddress[tos.length];
		for (int i = 0; i < address.length; i++) {
			address[i] = new InternetAddress(tos[i]);
		}

		// 连接服务器
		trans.connect(smtpServer, username, password);

		// 生成发送的消息
		Message msg = new MimeMessage(session);

		// 邮件的地址及别名
		Address from_address = new InternetAddress(from, displayName);

		// 设置
		msg.setFrom(from_address);

		// 设置接收人地址
		msg.setRecipients(Message.RecipientType.TO, address);

		// 设置发送主题
		msg.setSubject(subject);

		// 部件
		Multipart mp = new MimeMultipart();

		// body部件
		MimeBodyPart mbp = new MimeBodyPart();

		// 判断发送的是否是html格式
		if (isHtml) {// 如果是html格式
			mbp.setContent(content, "text/html;charset=" + charset);
		} else {
			mbp.setText(content);
		}
		// 将该正文部件加入到整体部件
		mp.addBodyPart(mbp);

		if (files != null && files.length > 0) {// 判断是佛有附件
			// 存在附件就将附件全部加入到BodyPart
			for (File file : files) {
				mbp = new MimeBodyPart();
				FileDataSource fds = new FileDataSource(file); // 得到数据源
				mbp.setDataHandler(new DataHandler(fds)); // 得到附件本身并至入BodyPart
				mbp.setFileName(fds.getName()); // 得到文件名同样至入BodyPart
				mp.addBodyPart(mbp);
			}
		}
		// Multipart加入到信件
		msg.setContent(mp);

		// 设置信件头的发送日期
		msg.setSentDate(new Date());

		// 发送信件
		msg.saveChanges();

		// 发送
		trans.sendMessage(msg, msg.getAllRecipients());

		// 结束
		trans.close();

	}

	public static void main(String[] args) throws UnsupportedEncodingException,
			MessagingException {
		MailUtil mailUtil = new MailUtil("smtp.163.com",
				"testjdcjsendemail@163.com", "测试邮件发送", "testjdcjsendemail@163.com",
				"testjdcj123");
		mailUtil.send(
				new String[] {  "657012724@qq.com" },
				true,
				"测试发送",
				"<html><head></head><body><a href='http://localhost:8080/ExamOnline/Record/showTest.jsp?Uid=13338875863&name=冀晓峰&course=java&test_time=2017/01/06'>试卷详情</a></body></html>",
				true,
				new File[] {
						//new File("F:/ace/blank.html"),
						 });
	}
}
