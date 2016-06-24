<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<c:forEach items="${workOrderReportDetailList}" var="workOrder"
           varStatus="w">
    <div class="well">
        <div class="form-group">
            <label class="control-label col-md-1">跟踪号：</label>

            <div class="col-md-1">
                <p class="form-control-static"
                   data-display="email">${workOrder.orderLineNo}</p>
            </div>
            <label class="control-label col-md-1">设备名称：</label>

            <div class="col-md-1">
                <p class="form-control-static"
                   data-display="email">${workOrder.equipments.description}</p>
            </div>

            <label class="control-label col-md-1">设备位置：</label>

            <div class="col-md-1">
                <p class="form-control-static"
                   data-display="email">${workOrder.locations.description}</p>
            </div>
            <label class="control-label col-md-1">设备故障：</label>

            <div class="col-md-1">
                <p class="form-control-static"
                   data-display="email">${workOrder.orderDesc}</p>
            </div>

            <label class="control-label col-md-1">维修单位：</label>

            <div class="col-md-1">
                <p class="form-control-static"
                   data-display="email">${workOrder.unit.description}</p>
            </div>
        </div>

    </div>
</c:forEach>

