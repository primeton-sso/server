

<%
	System.out.println(request.getQueryString());
	response.sendRedirect(response.encodeUrl(request.getContextPath() + "/login" + "?" + request.getQueryString()));
%>