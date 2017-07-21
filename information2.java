package WebTerm2JAVA;

import java.io.*;
import java.text.SimpleDateFormat;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.TimeUnit;

//import javax.lang.model.element.Element;

import javax.mail.Transport;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.internet.InternetAddress;
import javax.mail.Address;
import javax.mail.internet.MimeMessage;
import javax.mail.Session;
import javax.mail.Authenticator;
import java.util.Properties;


import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.impl.client.HttpClientBuilder;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.jsoup.nodes.Element;

public class information2{
	
	public static void doMain() throws Exception{
		Timer t = new Timer(true);  //타이머 객체 생성
		t.scheduleAtFixedRate(new Crawling2(), 1000, 60000);   //60초마다 주기적인 크롤링 실행
		Thread.currentThread().sleep(6000);
	}
	public static void main(String[] args) throws Exception{
		try{
			doMain();  //주기적인 크롤링을 위해 scheduleAtFixedRate()함수가 있는 domain메소드 실행
		}
		catch(IOException e){//예외 처리
			e.printStackTrace();
		}
	}
}

class SMTPAuthenticator2 extends javax.mail.Authenticator {
	public PasswordAuthentication getPasswordAuthentication() {

		return new PasswordAuthentication("oyoon33", "wlswn3709*");
	}
}

class Crawling2 extends TimerTask{    //크롤링을 실행하는 클래스
	int i = 0;
	static Document doc;
	information1 info = new information1();
	public void run(){
		try{
			FileReader prefr = new FileReader("C:\\Users\\권오윤\\workspace\\WebTermJSP\\WebContent\\information2.json");  //원래 있던 제이슨 파일을 읽어온다.
			BufferedReader prebr = new BufferedReader(prefr);  //원래 있던 제이슨 파일을 읽어온다.
			String filename = "C:\\Users\\권오윤\\workspace\\WebTermJSP\\WebContent\\information2.json"; //새로 생성할 제이슨 파일 이름 설정
			File file = new File(filename);  //파일 객체 생성
			FileOutputStream fos = new FileOutputStream(filename);  

			doc = Jsoup.connect("http://computer.cnu.ac.kr/index.php?mid=gnotice").get();  //Jsoup라이브러리의 connect함수를 이용해 크롤링한 내용을 doc에 저장

			String title = doc.title();  //웹페이지 타이틀을 저장
			System.out.println("크롤링한 페이지 : "+title);  //웹페이지 타이틀 출력
			System.out.println();

			Elements topic = doc.select("tbody>tr");   //공지들 한줄 한줄을 선택하여 Elements타입의 topic변수에 저장

			fos.write("[".getBytes());      //제이슨 파일을 FileOutputStream을 통해서 write하며 작성한다.
			for(Element topics : topic){

				System.out.println(topics.text()+"\n");

				if(i==topic.size()-2){   //마지막은 , 를 빼야 하므로 조건 설정
					fos.write(("{\"key\": \""+i+"\",").getBytes());
					fos.write((" \"value\": \""+topics.text()+"\"}").getBytes());
				}
				else if(i==topic.size()-1){   //공지 이외의 웹페이지 하단 부분의 불필요한 부분을 제외하기 위한 조건
					break;
				}
				else{    //그 외의 경우에는 정상 적으로 한줄 한줄 내용을 write
					fos.write(("{\"key\": \""+i+"\",").getBytes());
					fos.write((" \"value\": \""+topics.text()+"\"},").getBytes());
				}
				i++;   //value값을 하나씩 증가
			}
			fos.write("]".getBytes());   //제이슨 파일 작성 완료
			FileReader afterfr = new FileReader("C:\\Users\\권오윤\\workspace\\WebTermJSP\\WebContent\\information2.json");  //새로 완성된 제이슨 파일을 읽어온다.
			BufferedReader afterbr = new BufferedReader(afterfr);
			int j =0;    //이전 제이슨파일과 새로 완성된 제이슨 파일을 비교하기 위한 임의의 변수
			while(j<topic.size()){  //읽어온 공지들의 개수 만큼 반복
				if(prebr.readLine()!=afterbr.readLine()){  //제이슨 파일들이 같은지 다른지 비교, 같지 않으면 조건문 안으로 들어감
					mailsend();  //smtp메일을 보내는 mailsend()함수 호출
					break; //메일을 보낸 뒤 while문을 종료
				}
				j++;  //임의의 변수 1증가
			}
		}
		catch(IOException e){  //예외 처리
			e.printStackTrace();
		}

	}
	public void mailsend(){
		Properties p = new Properties();    //properties객체를 생성하고 메일을 보내기 위한 여러 정보들을 put함수를 통해 입력
		p.put("mail.smtp.user", "oyoon33@gmail.com");
		p.put("mail.smtp.host", "smtp.gmail.com");
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");
		//SMTP 서버에 접속하기 위한 정보들

		String content = "일반소식이 업데이트 되었습니다!! 확인하세요!!";         //메일 내용
		String from = "oyoon33@gmail.com";  //보내는 사람 메일
		String subject = "충남대학교 컴퓨터공학과 일반소식 업데이트!!";  //메일 제목
		String email = "oyoon33@gmail.com";  //받는 사람 메일
		try {
			Authenticator auth = new SMTPAuthenticator();
			Session ses = Session.getInstance(p, auth);
			
			//메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
			ses.setDebug(true);

			//메일의 내용을 담기 위한 객체
			MimeMessage msg = new MimeMessage(ses); 
			
			//제목 설정
			msg.setSubject(subject);

			//보내는 사람의 메일 주소
			Address fromAddr = new InternetAddress(from);
			msg.setFrom(fromAddr);

			//받는 사람의 메일 주소
			Address toAddr = new InternetAddress(email);
			msg.addRecipient(Message.RecipientType.TO, toAddr);
			
			//메세지 본문의 내용과 형식, 캐릭터 셋 설정
			msg.setContent(content, "text/html;charset=UTF-8"); // 내용과 인코딩
			
			//발송하기
			Transport.send(msg); 

		} catch (Exception mex) {
			mex.printStackTrace();
			System.out.println("메일 발송 실패");
			return;
		}
	}
}


