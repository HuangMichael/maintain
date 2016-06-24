<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<table id="fillTable"
       class="table table-responsive table-condensed table-striped  table-hover">
    <thead>
    <tr id="trr2">
        <th>序号</th>
        <th>设备名称</th>
        <th>设备位置</th>
        <th>设备分类</th>
        <th>故障描述
        </th>
    </tr>
    </thead>
    <tbody id="tbody2">
    <c:forEach items="${workOrderReportCartList}" var="workOrder" varStatus="w">
        <tr id="tr-${w.index+1}">
            <td>${w.index+1}</td>
            <td>${workOrder.equipments.description}</td>
            <td>${workOrder.locations.description}</td>
            <td>${workOrder.equipmentsClassification.description}</td>
            <td><input type="text" id="orderDesc${workOrder.id}"
                       class="form-control" style="height:28px" value="${workOrder.orderDesc}"/>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>


