<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container">
    <div class="row">
        <div id="content" class="col-lg-12">
            <!-- PAGE HEADER-->
            <%@include file="../common/common-breadcrumb.jsp" %>
            <div class="row">
                <div class="col-md-12">
                    <!-- BOX -->
                    <div class="box border blue">
                        <div class="box-title">
                            <h4><i class="fa fa-table"></i>人员信息</h4>
                        </div>
                        <div class="box-body" style="padding: 5px 20px 5px 5px">
                            <!-- Split button -->
                            <div class="btn-group">

                                <button type="button" class="btn btn-sm myNavBtn active"
                                        onclick="addNew()">
                                    <i class="glyphicon glyphicon-plus"></i>新建记录
                                </button>
                                <button type="button" class="btn btn-sm myNavBtn active" onclick="editEq()">
                                    <i class="glyphicon glyphicon-edit"></i>编辑记录
                                </button>

                                <button type="button" class="btn btn-sm myNavBtn active" onclick="saveEq()">
                                    <i class="glyphicon glyphicon-save"></i>保存记录
                                </button>

                                <button type="button" class="btn btn-sm myNavBtn active" onclick="deleteEq()">
                                    <i class="glyphicon glyphicon-remove"></i>删除记录
                                </button>

                                <button type="button" class="btn btn-sm myNavBtn active"
                                        onclick="backwards()"><i
                                        class="glyphicon glyphicon-glyphicon glyphicon-backward"></i>上一条
                                </button>
                                <button type="button" class="btn btn-sm myNavBtn active"
                                        onclick="forwards()"><i
                                        class="glyphicon glyphicon-glyphicon glyphicon-forward"></i>下一条
                                </button>
                            </div>
                        </div>
                        <div class="box-body">
                            <div class="tabbable">
                                <ul class="nav nav-tabs" id="myTab">
                                    <li class="active"><a href="#tab_1_0" data-toggle="tab"
                                                          style="font-family: 微软雅黑;font-weight: bold">
                                        <i class="fa fa-home" id="eq"></i>人员信息</a>
                                    </li>
                                    <li><a href="#tab_1_1" data-toggle="tab"
                                           style="font-family: 微软雅黑;font-weight: bold">
                                        <i class="fa fa-flag" id="eqDetail"></i>人员详细信息</a>
                                    </li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane fade in active" id="tab_1_0">
                                        <%@include file="personList.jsp" %>
                                    </div>
                                    <div class="tab-pane fade" id="tab_1_1" style="padding: 20px">
                                        <%@include file="form.jsp" %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /BOX -->


                </div>
            </div>
            <%@include file="../common/common-back2top.jsp" %>
        </div>
        <!-- /CONTENT-->
    </div>
</div>

<%@include file="../common/common-foot.jsp" %>
<script>

    var dataTableName = "#personListTable";
    var selectedIds = [];
    var personList = [];
    var pointer = 0;
    var listModel = null;
    var personDetail = null;
    $(function () {
        //ajax 请求personList集合
        var url = "/person/findAll";
        $.ajaxSettings.async = false;
        $.getJSON(url, function (data) {
            personList = data;
        });

        //新建一个listModel
        listModel = new Vue({
            el: dataTableName,
            data: {
                personList: personList
            }
        });
        //新建一个listModel
        personDetail = new Vue({
            el: "#detailForm",
            data: {
                person: personList[0]
            }
        });

        $(dataTableName).bootgrid({
            selection: true,
            multiSelect: true,
            rowSelect: true,
            keepSelection: true
        }).on("selected.rs.jquery.bootgrid", function (e, rows) {
            //如果默认全部选中
            if (selectedIds.length === personList.length) {
                selectedIds.clear();
            }
            for (var x in rows) {
                if (rows[x]["id"]) {
                    selectedIds.push(rows[x]["id"]);
                }
            }
        }).on("deselected.rs.jquery.bootgrid", function (e, rows) {
            for (var x in rows) {
                selectedIds.remove(rows[x]["id"]);
            }
        });

    });


    function backwards() {
        if (pointer <= 0) {
            showMessageBoxCenter("danger", "center", "当前记录是第一条");
            return;
        } else {
            pointer = pointer - 1;
            //判断当前指针位置
            var person = getPersonById(selectedIds[pointer]);
            personDetail.$set("person", person);
        }

    }
    function forwards() {
        if (pointer >= selectedIds.length - 1) {
            showMessageBoxCenter("danger", "center", "当前记录是最后一条");
            return;
        } else {
            pointer = pointer + 1;
            var person = getPersonById(selectedIds[pointer]);
            personDetail.$set("person", person);

        }
    }


    /**
     * 根据ID获取设备信息
     * @param eqs 设备信息集合
     * @param eid 设备ID
     */
    function getPersonById(pid) {
        var person = null;
        var url = "/person/findById/" + pid;
        $.getJSON(url, function (data) {
            person = data;
        });
        return person;
    }
</script>

