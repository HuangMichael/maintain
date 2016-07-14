<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table id="equipmentsDataTable" class=" table table-striped table-bordered table-hover iconRefresh">
    <thead>
    <tr>
        <th data-column-id="index" width="20px">序号</th>
        <th data-column-id="id" data-type="numeric" data-identifier="true" data-visible="false">ID</th>
        <th data-column-id="eqCode" width="20px">设备编号</th>
        <th data-column-id="description" style="width:15%">设备名称</th>
        <th data-column-id="equipClass" style="width:10%">设备分类</th>
        <th data-column-id="vlocation" style="width:15%">设备位置</th>
        <th data-column-id="status" data-formatter="status" data-sortable="false" style="width:5%">设备状态</th>
        <th data-column-id="running" data-formatter="running" data-sortable="false" style="width:5%">运行状态</th>
        <th data-column-id="report" data-formatter="report" data-sortable="false" style="width:5%">报修</th>
    </tr>
    </thead>
    <tbody>
    <tr class="gradeX" data-rowId="{{eq.id}}" id="tr{{eq.id}}" v-for="eq in eqs">
        <td>{{ $index+1 }}</td>
        <td>{{eq.id}}</td>
        <td>{{eq.eqCode}}</td>
        <td>{{eq.description}}</td>
        <td>{{eq.equipmentsClassification.description}}</td>
        <td>{{eq.vlocations.line+eq.vlocations.station+eq.vlocations.locName}}</td>
        <td>
            <div v-if="eq.status=='0'">
                停用
            </div>
            <div v-if="eq.status=='1'">
                投用
            </div>
            <div v-if="eq.status=='2'">
                报废
            </div>
        </td>
        <td>
            <div v-if="eq.running=='0'">
                停止
            </div>
            <div v-if="eq.running=='1'">
                运行
            </div>
        </td>
    </tr>
    </tbody>
    <tfoot>
    </tfoot>
</table>