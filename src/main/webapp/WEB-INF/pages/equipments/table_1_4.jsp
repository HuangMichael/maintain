<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table id="reportHistory" class=" table table-striped table-bordered table-hover table-responsive">
    <thead>
    <tr>
        <th width="5%" style="overflow: hidden">序号</th>
        <th width="25%" style="overflow: hidden">操作时间</th>
        <th width="10%" style="overflow: hidden"> 状态</th>
        <th width="30%" style="overflow: hidden">故障描述</th>
        <th width="30%" style="overflow: hidden">维修描述</th>
    </tr>
    </thead>
    <tbody id="history">
    <c:forEach items="${fixHistoryList}" var="h" varStatus="s">
        <tr >
            <td style="overflow: hidden">${s.index+1}</td>
            <td style="overflow: hidden">${h[0]}</td>
            <td style="overflow: hidden">

                <c:if test="${h[1]==0}">报修车</c:if>
                <c:if test="${h[1]==1}">已报修</c:if>
                <c:if test="${h[1]==2}">已分配</c:if>
                <c:if test="${h[1]==3}">已暂停</c:if>
                <c:if test="${h[1]==4}">已完工</c:if>
            </td>
            <td style="overflow: hidden" title="${h[2]}">${h[2]}</td>
            <td style="overflow: hidden" title="${h[3]}">${h[3]}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>

