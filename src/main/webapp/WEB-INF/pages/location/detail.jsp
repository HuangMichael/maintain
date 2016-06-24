<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="box border blue">
    <div class="box-body">
        <%@include file="form.jsp" %>
    </div>
</div>
<div class="box border blue">
    <div class="box-body">
        <div class="box-body">
            <ul class="nav nav-tabs" id="myTab">
                <li class="active"><a data-toggle="tab" href="#tab_1_1">设备信息
                    <span class="badge badge-red">${equipmentsList.size()}</span>
                </a></li>
                <li><a data-toggle="tab" href="#tab_1_2">已报修工单

                    <span class="badge badge-red">${workOrderList0.size()}</span>

                </a></li>
                <li><a data-toggle="tab" href="#tab_1_3">维修中工单

                    <span class="badge badge-green">${workOrderList1.size()}</span>

                </a></li>
                <li><a data-toggle="tab" href="#tab_1_4">已完成工单

                    <span class="badge badge-sucess">${workOrderList2.size()}</span>

                </a></li>
                <li><a data-toggle="tab" href="#tab_1_5">已挂起工单

                    <span class="badge badge-error">${workOrderList4.size()}</span>

                </a></li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane active " id="tab_1_1">
                    <table id="eqtables" cellpadding="0" cellspacing="0" border="0"
                           class=" table table-striped table-bordered table-hover">
                        <thead>
                        <tr>
                            <th data-column-id="index">序号</th>
                            <th data-column-id="id" data-visible="false">序号</th>
                            <th data-column-id="eqCode">设备编号</th>
                            <th data-column-id="description">设备名称</th>
                            <th data-column-id="location">设备位置</th>
                            <th data-column-id="status">设备状态</th>
                            <th data-column-id="report" data-formatter="report">设备报修</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${equipmentsList}" var="equipment" varStatus="s">
                            <tr class="gradeX" data-rowId="${equipment.id}" id="tr${equipment.id}">
                                <td>${s.index+1}</td>
                                <td>${equipment.id}</td>
                                <td>
                                        ${equipment.eqCode}
                                </td>
                                <td>
                                        ${equipment.description}
                                </td>
                                <td>
                                        ${equipment.locations.description}
                                </td>
                                <td>
                                    <c:if test="${equipment.status==1}">
                                        <span class="badge badge-green"> 正常</span>
                                    </c:if>
                                    <c:if test="${equipment.status==0}">
                                        <span class="badge badge-error">故障</span>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                        <tfoot>
                        </tfoot>
                    </table>
                </div>
                <div class="tab-pane " id="tab_1_2">
                    <table class="table table-striped table-bordered table-responsive table-condensed" id="1table">
                        <thead>
                        <tr>
                            </th>
                            <th data-column-id="check">序号</th>
                            <th data-column-id="orderNo" class="hidden-xs hidden-sm">工单编号</th>
                            <th data-column-id="line" class="hidden-xs hidden-sm">线路</th>
                            <th data-column-id="station" class="hidden-xs hidden-sm">车站</th>
                            <th data-column-id="locations">位置</th>
                            <th data-column-id="orderDesc">工单描述</th>
                            <th data-column-id="reporter">报修人</th>
                            <th data-column-id="reportTelephone">报修人电话</th>
                            <th data-column-id="reportTime">报修时间</th>

                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${workOrderList0}" var="workOrder" varStatus="w">
                            <tr id="list0-${workOrder.id}">
                                <td>${w.index+1}</td>
                                <td class="hidden-xs hidden-sm">${workOrder.orderNo}</td>
                                <td class="hidden-xs hidden-sm">${workOrder.locations.line.description}</td>
                                <td class="hidden-xs hidden-sm">${workOrder.locations.station.description}</td>
                                <td>${workOrder.locations.description}</td>
                                <td>${workOrder.orderDesc}</td>
                                <td>${workOrder.reporter}</td>
                                <td>${workOrder.reportTelephone}</td>
                                <td><fmt:formatDate value="${workOrder.reportTime}"
                                                    pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="tab-pane " id="tab_1_3">
                    <table class="table table-striped table-bordered table-responsive table-condensed"
                           id="2table">
                        <thead>
                        <tr>
                            <th data-column-id="id">序号</th>
                            <th data-column-id="orderNo" class="hidden-xs hidden-sm">工单编号</th>
                            <th data-column-id="line" class="hidden-xs hidden-sm">线路</th>
                            <th data-column-id="station" class="hidden-xs hidden-sm">车站</th>
                            <th data-column-id="locations">位置</th>
                            <th data-column-id="orderDesc">工单描述</th>
                            <th data-column-id="unit">维修单位</th>
                            <th data-column-id="limited">时限</th>
                            <th data-column-id="beginTime">维修时间</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${workOrderList1}" var="workOrder" varStatus="w">
                            <tr id="list1-${workOrder.id}">
                                <td>${w.index+1}</td>
                                <td class="hidden-xs hidden-sm">${workOrder.orderNo}</td>
                                <td class="hidden-xs hidden-sm">${workOrder.locations.line.description}</td>
                                <td class="hidden-xs hidden-sm">${workOrder.locations.station.description}</td>
                                <td>${workOrder.locations.description}</td>
                                <td>${workOrder.orderDesc}</td>
                                <td>${workOrder.workOrderMaintenance.outsourcingUnit.description}</td>
                                <td>${workOrder.workOrderMaintenance.limitedHours}</td>
                                <td><fmt:formatDate value="${workOrder.workOrderMaintenance.beginTime}"
                                                    pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="tab-pane " id="tab_1_4">
                    <table class="table table-striped table-bordered table-responsive table-condensed"
                           id="3table">
                        <thead>
                        <tr>
                            <th data-column-id="id">序号</th>
                            <th data-column-id="orderNo" class="hidden-xs hidden-sm">工单编号</th>
                            <th data-column-id="line" class="hidden-xs hidden-sm">线路</th>
                            <th data-column-id="station" class="hidden-xs hidden-sm">车站</th>
                            <th data-column-id="locations">位置</th>
                            <th data-column-id="orderDesc">工单描述</th>
                            <th data-column-id="unit" class="hidden-xs hidden-sm">维修单位</th>
                            <th data-column-id="limitedHours">时限</th>
                            <th data-column-id="endTime">完成时间</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${workOrderList2}" var="workOrder" varStatus="w">
                            <tr id="list2-${workOrder.id}">
                                <td>${w.index+1}</td>
                                <td class="hidden-xs hidden-sm">${workOrder.orderNo}</td>
                                <td class="hidden-xs hidden-sm">${workOrder.locations.line.description}</td>
                                <td class="hidden-xs hidden-sm">${workOrder.locations.station.description}</td>
                                <td>${workOrder.locations.description}</td>
                                <td>${workOrder.orderDesc}</td>
                                <td class="hidden-xs hidden-sm">${workOrder.workOrderMaintenance.outsourcingUnit.description}</td>
                                <td>${workOrder.workOrderMaintenance.limitedHours}</td>
                                <td><fmt:formatDate value="${workOrder.workOrderMaintenance.endTime}"
                                                    pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="tab-pane " id="tab_1_5">
                    <table class="table table-striped table-bordered table-responsive table-condensed"
                           id="4table">
                        <thead>
                        <tr>
                            <th data-column-id="id">序号</th>
                            <th data-column-id="orderNo" class="hidden-xs hidden-sm">工单编号</th>
                            <th data-column-id="line" class="hidden-xs hidden-sm">线路</th>
                            <th data-column-id="station" class="hidden-xs hidden-sm">车站</th>
                            <th data-column-id="locations">位置</th>
                            <th data-column-id="orderDesc">工单描述</th>
                            <th data-column-id="unit" class="hidden-xs hidden-sm">维修单位</th>
                            <th data-column-id="limitedHours">时限</th>
                            <th data-column-id="endTime">挂起时间</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${workOrderList4}" var="workOrder" varStatus="w">
                            <tr id="list2-${workOrder.id}">
                                <td>${w.index+1}</td>
                                <td class="hidden-xs hidden-sm">${workOrder.orderNo}</td>
                                <td class="hidden-xs hidden-sm">${workOrder.locations.line.description}</td>
                                <td class="hidden-xs hidden-sm">${workOrder.locations.station.description}</td>
                                <td>${workOrder.locations.description}</td>
                                <td>${workOrder.orderDesc}</td>
                                <td class="hidden-xs hidden-sm">${workOrder.workOrderMaintenance.outsourcingUnit.description}</td>
                                <td>${workOrder.workOrderMaintenance.limitedHours}</td>
                                <td><fmt:formatDate value="${workOrder.workOrderMaintenance.endTime}"
                                                    pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="modal fade " id="show_eq_modal" tabindex="-1" back-drop="false"
     role="dialog" aria-labelledby="fix_work_order">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="fix_work_order">该设备已报修还未完工,要继续报修该设备么?</h4>
            </div>
            <div class="modal-body">
                <%@include file="reportedEqList.jsp" %>
            </div>
        </div>
    </div>
</div>


<div class="modal fade " id="show_loc_modal" tabindex="-1" back-drop="false"
     role="dialog" aria-labelledby="fix_work_order">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="fix_work_order1">该位置已报修还未完工,要继续报修该设备么?</h4>
            </div>
            <div class="modal-body">
                <%@include file="reportedLocList.jsp" %>
            </div>
        </div>
    </div>
</div>


<div class="modal fade " id="pic_modal" tabindex="-1" back-drop="false"
     role="dialog" aria-labelledby="fix_work_order">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="pic_modal_location">位置图片</h4>
            </div>
            <div class="modal-body">
                <img src="${locations.imgUrl}" height="100%" width="100%"/>
            </div>
        </div>
    </div>
</div>


<div class="modal fade " id="pic_upload_modal" tabindex="-1" back-drop="false"
     role="dialog" aria-labelledby="fix_work_order">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="pic_upload_modal-1">上传图片</h4>
            </div>
            <div class="modal-body">
                <form id="uploadForm" enctype="multipart/form-data" method="post" action="/upload/upload">
                    <div class="form-group">
                        <input type="file" class="form-control" name="file" id="file"/>
                        <input type="hidden" class="form-control" name="name" id="name"/>
                        <input type="hidden" class="form-control" name="llid" id="llid" value="${locations.id}"/>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消
                        </button>
                        <button type="submit" id="uploadBtn" name="uploadBtn"
                                class="btn btn-primary">上传
                        </button>
                    </div>
                </form>


            </div>
        </div>
    </div>
</div>



<script type="text/javascript" src="/js/app/locations/location.detail.min.js"></script>
