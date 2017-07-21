<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>CSE Information WebApp</title>
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<style>
	
* {
        margin: 0;
        padding: 0;
}
html {
	height:100%;
}
body {
	font-family: 'Lato', Calibri, Arial, sans-serif;
	font-weight: 300;
	font-size: 14px; 
	font-size: 1.4rem;
	color: #aaa;
	-webkit-font-smoothing: antialiased;
	overflow-y: scroll;
	overflow-x: hidden;
}
#start{
	margin-top: 10px;
	background-color: #7D7C75;
	color: #fff;
	font-weight: bold;
	font-family: "Museo";
	text-transform: uppercase;
	text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff, 0 0 40px #ff00de, 0 0 70px #ff00de, 0 0 80px #ff00de, 0 0 100px #ff00de, 0 0 150px #ff00de;
}
#titlename{
	text-align: center;
	margin: auto;
	font-family: "Museo";
	font-size: 50px; 
	text-transform: uppercase;
	color: #fff;
	text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff, 0 0 40px #ff00de, 0 0 70px #ff00de, 0 0 80px #ff00de, 0 0 100px #ff00de, 0 0 150px #ff00de;
}
#info {
	position: absolute;
	left:0;
	top:0;
}
a:active, a:link, a:visited {
	text-decoration: none;
	color:#333;
}
.wrapper {	
	
	width:200px;
	margin:30px auto;
}
ul.card-container {
	position:relative;
	width:200px;
	height:310px;
	margin:0 auto;
	list-style: none;
}
ul.card-container li {
	width: 100%;
	height: 100%;
	margin: 0;
	
	position: absolute;
	top: 0;
	left: 0;
	
	cursor: pointer;
	background: #7D7C75;
	border-radius: 10px;
	padding: 5px;
    box-shadow:10px 10px 10px black;
	
	-webkit-transition:transform 0.3s ease;
	-webkit-transform-origin: 100% 200%;
}
ul.card-container li h4 {
	text-align: center;
	color: #fff;
	font-size: 14px;
	padding: 8px 10px 5px;
	margin: 20px 3px 5px;
	border-bottom: 1px solid #504F4A;
	font-family: "Museo";
	text-transform: uppercase;
	text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff, 0 0 40px #ff00de, 0 0 70px #ff00de, 0 0 80px #ff00de, 0 0 100px #ff00de, 0 0 150px #ff00de;
}
ul.card-container li p {
	font-size: 12px;
	font-weight: 700;
	padding: 0 10px;
	margin: 10px 3px 0;
}
ul.card-container li img {
	display: block;
	margin: 0 auto;
	width: 100%;
	border-radius: 10px 10px 0 0;
	-webkit-animation: titMove 1.0s;	
}
#videobcg{
	position: absolute;
	top: 0px;
	left: 0px;
	min-height: 100%;
	min-width: 100%;
	width: auto;
	height: auto;
	z-index: -1000;
	overflow: hidden;
}
</style>
</head>
<body style="background-color: #D9DAD8">
<video id="videobcg" preload="auto" autoplay="true" loop="loop" muted="muted">
    <source src="http://localhost:8181/WebTermJSP/universe.mp4" type="video/mp4">
    <source src="http://localhost:8181/WebTermJSP/universe.webm" type="video/webm">
</video>
<h1 id="titlename">CSE Information WebApp</h1>
 <center><button id="start">SHOW</button></center>
<div class="wrapper">
            <ul id="cardList" class="card-container">
                <li><a href="http://localhost:8181/WebTermJSP/info1.jsp"><img src="http://localhost:8181/WebTermJSP/computer1.PNG" alt="image1" onclick='news1()'><h4>학사공지</h4></a><p></p></li>
                <li><a href="http://localhost:8181/WebTermJSP/info2.jsp"><img src="http://localhost:8181/WebTermJSP/computer2.PNG" alt="image2" onclick="news2()"><h4>일반소식</h4></a><p></p></li>
                <li><a href="http://localhost:8181/WebTermJSP/info3.jsp"><img src="http://localhost:8181/WebTermJSP/computer3.PNG" alt="image3" onclick="news3()"><h4>사업단소식</h4></a><p></p></li>
                <li><a href="http://localhost:8181/WebTermJSP/info4.jsp"><img src="http://localhost:8181/WebTermJSP/computer4.PNG" alt="image4" onclick="news4()"><h4>취업정보</h4></a><p></p></li>
                <li><a href="http://localhost:8181/WebTermJSP/info5.jsp"><img src="http://localhost:8181/WebTermJSP/computer5.PNG" alt="image5" width="160px" height="120px" onclick="news5()"><h4>CSE News</h4></a><p></p></li>
             </ul>
            
        </div>
        <script>//자바스크립트 부분
        var $imgs =null;  
        $(document).ready(function(){
            init();
            initEvent();
        })
        
        // 요소 초기화 
        function init(){
           $imgs = $("li");
            
            $imgs.each(function(index){
                $(this).css({
                    zIndex:$imgs.length-index
                })
            })
        }
        
        // 이벤트 처리
        function initEvent(){
            $("#start").click(function(){
                
                // 시작 각도 값
                var angle = 100;
                
                // 90~-90 사이에 배열하기 위해 이미지가 가져야할 각도 구하기 
                //회전할 이미지 개수 만큼 나눔 
                var step = (165/($imgs.length-1));
                
                console.log(step);
                // 이미지 회전하기
                $imgs.each(function(index){
                   
                    $(this).css({
                        transform:"rotate("+angle+"deg)"
        
                    })
                   
                    angle-=step;
                })
            })
        }        
        </script>
</body>
</html>