<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<table cellpadding="0" cellspacing="0" border="0"
       class=" table tree  table-bordered table-hover">
    <thead>
    <tr>
        <th width="5%">序号</th>
        <th width="10%">设备名称</th>
        <th width="20%">故障描述</th>
        <th width="10%">设备位置</th>
        <th width="10%">设备分类</th>
       <%-- <th width="10%">报修人</th>
        <th width="10%">报修时间</th>--%>
        <th width="5%">设备状态</th>

    </tr>
    </thead>
    <tbody>
    <c:forEach items="${workOrderReportList}" var="w" varStatus="s">
        <tr class="treegrid treegrid-${s.index+1} treegrid-collapsed info">
            <td>${s.index+1}</td>
            <td colspan="2">报修单:${w.orderNo}</td>
            <td colspan="2" class="hidden-xs hidden-sm">下单时间:<fmt:formatDate
                    value="${w.reportTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td><c:if test="${w.status=='0'}">
                <span class="badge badge-info">已分配</span>
            </c:if>
                <c:if test="${w.status=='1'}">
                    <span class="badge badge-success">已完工</span>
                </c:if>
                <c:if test="${w.status=='2'}">
                    <span class="badge badge-important">已暂停</span>
                </c:if></td>
            <td colspan="7"></td>
        </tr>
        <c:forEach items="${w.workOrderReportDetailList}" var="d" varStatus="ds">
            <tr class="treegrid treegrid-${s.index+1}-${ds.index+1} treegrid-parent-${s.index+1} success">
                <td>${ds.index+1}</td>
                <td>${d.equipments.description}</td>
                <td class="hidden-xs hidden-sm">${d.orderDesc}</td>
                <td>${d.locations.description}</td>
                <td>${d.equipmentsClassification.description}</td>
                <%--<td class="hidden-xs hidden-sm">${d.reporter}</td>
                <td class="hidden-xs hidden-sm">${d.reportTime}</td>--%>
                <td>
                    <c:if test="${d.status=='0'}">
                        <span class="badge badge-info">已分配</span>
                    </c:if>
                    <c:if test="${d.status=='1'}">
                        <span class="badge badge-success">已完工</span>
                    </c:if>
                    <c:if test="${d.status=='2'}">
                        <span class="badge badge-important">  已暂停</span>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </c:forEach>
    </tbody>
</table>

