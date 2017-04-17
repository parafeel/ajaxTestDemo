<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js" charset="utf-8"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
	#mydiv {
		positon:absolute;
		left:100%;
		top:100%;
		width:500px;
		margin-left: 380px;
		margin-top: 250px;
	}
	
	.mouseOver {
		background: #708090;
		color: #FFFAFA;
	}
	.mouseOut{
		background: #FFFAFA;
		color: #000000;
	}
	.mouseClick{
		background: red;
		color: red;
	}
	</style>
	<script type="text/javascript">
		var xmlHttp;
		//获的用户输入的内容的函数
		function getMoreContents() {

			var content = document.getElementById("keyword");
			if(content.value == "") {
				clearContent();
				return;
			}
			//要给服务器发送用户输入的内容，利用ajax，使用XmlHttp对象
			xmlHttp = createXMLHttp();
			var url="search?keyword=" + escape(content.value);
			xmlHttp.open("GET",url,true);
			//xmlHtto回调函数
			xmlHttp.onreadystatechange = callback;
			xmlHttp.send(null);
		}
		
		//获的Hxmlhttp对象
		function createXMLHttp() {
			var XMLHTTP;
			if(window.XMLHttpRequest) {
				XMLHTTP = new XMLHttpRequest();
			}
			if(window.ActiveXObject) {
				XMLHTTP = new ActiveXObject("Microsoft.XMLHTTP");
				if(!XMLHTTP) {
					XMLHTTP = new ActiveXObject("Msxml2.XMLHTTP");
				}
			}
			return XMLHTTP;
		}
		
		function callback() {
			if(xmlHttp.readyState == 4) {
				//200代表服务器相应成功，404代表资源未找到。。。
				if(xmlHttp.status == 200 ){
					//交互成功，获的相应的数据，是文本格式(json)
					var result = xmlHttp.responseText;
					//解析获得的数据
					var json = eval( '(' + result + ')' );//java离得json到JS里的json要加括号
					//获的数据后，就可以动态显示数据了，显示在输入框下面
					setContent(json);
				}
			}
		}
		
		//设置关联数据的展示
		function setContent(contents) {
			clearContent();
			setLocation();
			var size = contents.length;
			for(var i=0;i<size;i++) {
				var nextNode = contents[i];
				var tr=document.createElement("tr");
				var td=document.createElement("td");
				td.setAttribute("border", "0");
				td.setAttribute("bgcolor", "#FFFAFA");
				
				td.onmousemove = function() {
					this.className='mouseOver';
					
				};
				td.onmouseout = function() {
					this.className='mouseOut';
				};
				
				td.onmousedown = function() {
					var keywordcontent = document.getElementById("keyword");
					keywordcontent.value = this.innerText;
				};
              	/**
               	td.mousemove(function() {
                   
                   
               	});
               	**/
				var text = document.createTextNode(nextNode);
				td.appendChild(text);
				tr.appendChild(td);
				document.getElementById("content_table_body").appendChild(tr);
			}
		}
		
		//清空之前的数据
		function clearContent() {
			var contentTableBody = document.getElementById("content_table_body");
			var size = contentTableBody.childNodes.length;
			for(var i=size-1 ; i >=0 ; i--) {
				contentTableBody.removeChild(contentTableBody.childNodes[i]);
			}
			document.getElementById("popDiv").style.border = "none";
		}
		
		function keywordBlur() {
			clearContent();
		}
		function keywordFocus() {
			getMoreContents();
		}
		
		function setLocation() {
			var content = document.getElementById("keyword");
			var width = content.offsetWidth;
			var left = content["offsetLeft"];
			var top = content["offsetTop"] + content.offsetHeight;
			
			var popDiv = document.getElementById("popDiv");
			popDiv.style.border = "black 0.5px solid";
			popDiv.style.left = left + "px";
			popDiv.style.top = top + "px";
			popDiv.style.width = width + "px";
			document.getElementById("content_table").style.width = width + "px";
		}
	</script>
	
	
  </head>
  
  <body>
    <div id="mydiv">
   		<!-- 输入框 -->
    	<input type="text" size="50" id="keyword" onkeyup="getMoreContents()" 
    	onblur="keywordBlur()" onfocus="keywordFocus()"/>
    	<input type="button" value="搜索一下" width="50px"/>
    	
    	<!-- 内容的展示区域 -->
    	<div id="popDiv"> 
    		<table id="content_table" bgcolor="#FFAFA" border="0" cellspacing="0"
    		cellpadding="0">
    			<tbody id="content_table_body">
    			
    			</tbody>
    		</table>
    	</div>
    </div>
  </body>
</html>
