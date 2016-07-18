<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<c:forEach items="${workOrderReportDetailList}" var="workOrder" varStatus="w">
    <div class="well">
        <div class="form-group">
            <div class="col-md-2">

                <div class="form-control-static"><label class="control-label">跟踪号：</label>${workOrder.orderLineNo}</div>
            </div>


            <div class="col-md-2">

                <div class="form-control-static"><label
                        class="control-label">设备名称：</label>${workOrder.equipments.description}</div>
            </div>

            <div class="col-md-2">


                <div class="form-control-static"><label
                        class="control-label">设备位置：</label>${workOrder.locations.description}</div>
            </div>


            <div class="col-md-2">


                <div class="form-control-static"><label class="control-label">设备故障：</label>${workOrder.orderDesc}</div>
            </div>


            <div class="col-md-2">
                <div class="form-control-static"><label class="control-label">维修单位：</label>${workOrder.unit.description}
                </div>
            </div>
        </div>
    </div>
</c:forEach>

