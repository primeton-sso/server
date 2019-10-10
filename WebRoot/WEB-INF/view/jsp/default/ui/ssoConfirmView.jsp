<div class="info">
    <p>
        <spring:message code="screen.confirmation.message" arguments="${param.service}${fn:indexOf(param.service, '?') eq -1 ? '?' : '&'}ticket=${serviceTicketId}" />
    </p>
</div>
