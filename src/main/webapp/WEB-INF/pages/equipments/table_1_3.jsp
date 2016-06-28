<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table id="reportHistory" class=" table table-striped table-bordered table-hover">
    <thead>
    <tr>
        <th>序号</th>
        <th>报修行号</th>
        <th>报修描述</th>
        <th>报修时间</th>
        <th>状态</th>
        <th>报修时间</th>
    </tr>
    </thead>
    <tbody id="reportHistory_list" style="height: 100px;overflow: scroll">

    <tr v-for="h in historyList">
        <td>{{ $index+1 }}</td>
        <td>{{h.orderLineNo}}</td>
        <td>{{h.orderDesc}}</td>
        <td>{{h.reportTime}}</td>
        <td>
            {{h.status}}
        </td>
        <td></td>
    </tr>
    </tbody>
</table>