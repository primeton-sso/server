<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="<%=request.getContextPath() %>/js/jquery-1.11.2.min.js"></script>
<script src="<%=request.getContextPath() %>/js/layer/layer.js"></script>
</head>
<body>
<% 
String service = request.getAttribute("appService")==null?null:request.getAttribute("appService").toString();
String appId = request.getAttribute("appId")==null?null:request.getAttribute("appId").toString();
String method = request.getAttribute("method")==null?null:request.getAttribute("method").toString();
String msg = request.getAttribute("msg")==null?null:request.getAttribute("msg").toString();
if(method!=null && method.equals("reset") && service!=null && service.length()>0 && appId!=null && appId.length()>0) {
%>
    <script>
    layer.alert('<%=msg%>', {
    	  skin: 'layui-layer-lan' //样式类名
    	  ,closeBtn: 0,
      	  title:'系统提示'
    	}, function(){
    		document.location.replace("login?service=<%=java.net.URLEncoder.encode(service,"utf-8")%>&appId=<%=java.net.URLEncoder.encode(appId,"utf-8")%>&sessionId=<%=request.getSession().getId()%>"); 
    		event.returnValue=false;
    });
	</script>
</body>
</html>
<%
}else if(service!=null && service.length()>0 && appId!=null && appId.length()>0) {
%>
	<script>
	layer.alert('已退出', {
  	  skin: 'layui-layer-lan' //样式类名
  	  ,closeBtn: 0,
  	  title:'系统提示'
  	}, function(){
  		document.location.replace("login?service=<%=java.net.URLEncoder.encode(service,"utf-8")%>&appId=<%=java.net.URLEncoder.encode(appId,"utf-8")%>&sessionId=<%=request.getSession().getId()%>"); 
  		event.returnValue=false;
  });
	
	</script>

<%}else { %>
	<script>
	layer.alert('已退出', {
  	  skin: 'layui-layer-lan' //样式类名
  	  ,closeBtn: 0,
  	  title:'系统提示'
  	}, function(){
  		window.opener=null;
  		window.close();
  });
	
	</script>

<%}%>
</body>
</html>