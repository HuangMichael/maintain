<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table id="unitsDataTable" class=" table table-striped table-bordered table-hover">
    <thead>
    <tr>
        <th data-column-id="index">序号</th>
        <th data-column-id="id" data-type="numeric" data-identifier="true" data-visiable="false">ID</th>
        <th data-column-id="unitNo">单位编号</th>
        <th data-column-id="description">单位名称</th>
        <th data-column-id="linkman">联系人</th>
        <th data-column-id="telephone">电话</th>
        <th width="5%" data-column-id="status">使用状态</th>
    </tr>
    </thead>
    <tbody>
    <tr class="gradeX" v-for="unit in units">
        <td>{{$index+1}}</td>
        <td>
            {{unit.id}}
        </td>
        <td>
            {{unit.unitNo}}
        </td>
        <td>
            {{unit.description}}
        </td>
        <td>
            {{unit.linkman}}
        </td>
        <td>
            {{unit.telephone}}
        </td>
        <td>

            <div v-if="unit.status=='0'">
                禁用
            </div>
            <div v-if="unit.status=='1'">
                启用
            </div>
        </td>
    </tr>
    </tbody>
</table>