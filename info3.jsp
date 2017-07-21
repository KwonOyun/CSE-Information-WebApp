<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style>
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
#header{
	padding-top: 10px;
	background-color: white;
	opacity:0.8;
    border-bottom-right-radius: 50px 30px;
    border-top-left-radius: 50px 30px;
    border-top-right-radius: 50px 30px;
    box-shadow:50px 50px 50px black;
}
#backbutton{
	padding-top: 10px;
	background-color: white;
	opacity:0.8;
    box-shadow:10px 10px 10px black;
}
</style>
</head>
<body id="output">
<input type="button" id="backbutton" value="HOME" style="width:100px;" onclick="location.href='Main.jsp'">
<video id="videobcg" preload="auto" autoplay="true" loop="loop" muted="muted">
    <source src="http://localhost:8181/WebTermJSP/universe.mp4" type="video/mp4">
    <source src="http://localhost:8181/WebTermJSP/universe.webm" type="video/webm">
</video>
<script>
$.getJSON('information3.json', function(data){
	var table = '<table id="header" style="margin: auto; border: 1px solid black;"><tr><td style="font-weight: bold; text-align: center; font-size:30px;">사업단 소식</td><tr>';
	$(data).each(function(index, item){
	
		table += '<tr>';
    table += '<td style="font-weight: bold; border:1px solid black;">' + item.value + '</td>';
    table += '</tr>'
	});
		table += '</table>';
		$('#output').append(table);
	});

</script>
</body>
</html>