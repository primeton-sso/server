<%@ page session="false" %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<cas:serviceResponse xmlns:cas='http://www.yale.edu/tp/cas'>
	<cas:authenticationSuccess>
		<cas:user>${fn:escapeXml(assertion.chainedAuthentications[fn:length(assertion.chainedAuthentications)-1].principal.id)}</cas:user>
		<c:if test="${not empty pgtIou}">
			<cas:proxyGrantingTicket>${pgtIou}</cas:proxyGrantingTicket>
		</c:if>
		<c:if test="${fn:length(assertion.chainedAuthentications) > 1}">
			<cas:proxies>
				<c:forEach var="proxy" items="${assertion.chainedAuthentications}"
					varStatus="loopStatus" begin="0"
					end="${fn:length(assertion.chainedAuthentications)-2}" step="1">
					<cas:proxy>${fn:escapeXml(proxy.principal.id)}</cas:proxy>
				</c:forEach>
			</cas:proxies>
		</c:if>
		<!-- 在server验证成功后，这个页面负责生成与客户端交互的xml信息，在默认的casServiceValidationSuccess.jsp中，只包括用户名，并不提供其他的属性信息，因此需要对页面进行扩展 -->
		<c:if
			test="${fn:length(assertion.chainedAuthentications[fn:length(assertion.chainedAuthentications)-1].principal.attributes) > 0}">
			<cas:attributes>
				<c:forEach var="attr"
					items="${assertion.chainedAuthentications[fn:length(assertion.chainedAuthentications)-1].principal.attributes}">
					<cas:${fn:escapeXml(attr.key)}>${fn:escapeXml(attr.value)}</cas:${fn:escapeXml(attr.key)}>
				</c:forEach>
			</cas:attributes>
		</c:if>
	</cas:authenticationSuccess>
</cas:serviceResponse>