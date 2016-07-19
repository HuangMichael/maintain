<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="js/jquery-treegrid/css/jquery.treegrid.css">
<link rel="stylesheet" href="http://yandex.st/highlightjs/7.3/styles/default.min.css">
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
                            <h4><i class="fa fa-table"></i>报修单查询</h4>
                        </div>
                        <div class="box-body">
                            <div id="contentDiv">
                                <div class="box-body">
                                    <div class="tabbable">
                                        <ul class="nav nav-tabs" id="myTab">
                                            <li class="active"><a href="#tab_1_0" data-toggle="tab">
                                                <i class="fa fa-home" id="eq"></i>报修单查询</a>
                                            </li>

                                            <li><a href="#pdf_view" data-toggle="tab">
                                                <i class="fa fa-flag" id="pdf-preview"></i>报修单预览</a>
                                            </li>
                                        </ul>
                                        <div class="tab-content">
                                            <div class="tab-pane fade in active" id="tab_1_0">

                                                <form class="navbar-form navbar-right" role="search">
                                                    <div class="form-group" id="searchView">
                                                        <input type="text" class="form-control" placeholder="搜索"
                                                               v-model="keywords" @change="change()">
                                                    </div>
                                                </form>
                                                <table class=" table tree  table-bordered">
                                                    <thead>
                                                    <tr>
                                                        <th width="5%">跟踪号</th>
                                                        <th width="10%">设备编号</th>
                                                        <th width="10%">设备名称</th>
                                                        <th width="10%">维修行号</th>
                                                        <th width="20%">故障描述</th>
                                                        <th width="10%">报修时间</th>
                                                        <%-- <th width="10%">设备位置</th>--%>
                                                        <th width="10%">设备分类</th>
                                                        <th width="5%">设备状态</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody id="reportView">
                                                    <tr v-for="r in reports|filterBy keywords">
                                                        <td>{{$index+1}}</td>
                                                        <td>{{r[1]}}</td>
                                                        <td>{{r[2]}}</td>
                                                        <td>{{r[3]}}</td>
                                                        <td>{{r[4]}}</td>
                                                        <td>{{r[5]}}</td>
                                                        <td>{{r[6]}}</td>
                                                        <td v-if="r[7]=='0'">未提交</td>
                                                        <td v-if="r[7]=='1'">已提交</td>
                                                    </tr>
                                                    </tbody>
                                                </table>
                                                <div id="app">
                                                    <vue-nav :cur.sync="cur" :all.sync="all"
                                                             v-on:btn-click="listen"></vue-nav>
                                                </div>
                                            </div>
                                            <div class="tab-pane fade" id="pdf_view">
                                            </div>
                                        </div>
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


<div class="modal fade " id="fix_modal" tabindex="-1"
     role="dialog" aria-labelledby="myModalLabel2">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel2">报修车明细信息</h4>
            </div>
            <div class="modal-body" id="modal_div">
                <%@include file="form.jsp" %>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript" src="js/jquery-treegrid/js/jquery.treegrid.js"></script>
<script type="text/javascript" src="js/jquery-treegrid/js/jquery.treegrid.bootstrap3.js"></script>
<script type="text/javascript">
    $(document).ready(function () {

        //建立模型加入到表格中


        $('.tree').treegrid();

        $("#myTab a").on("click", function (e) {
            e.preventDefault();
            preview(1);
            $(this).tab('show');
        })

        var listModel = new Vue({
            el: "#reportView",
            data: {
                reports: getRecortsByPage(6, 0),
                keywords: ""
            }
        });


        var app = new Vue({
            el: '#app',
            data: {
                cur: 1,
                pageCount: 6,
                all: Math.ceil(findNewDetails().length / 6)
            },
            components: {
                'vue-nav': Vnav
            },
            methods: {
                listen: function (data) {
                    listModel.reports = getRecortsByPage(this.pageCount, this.cur - 1);
                }
            }
        });

        var searchModel = new Vue({
            el: "#searchView",
            data: {
                keywords: ""
            },
            methods: {

                change: function () {

                    alert("正在开发中 ");
                }

            }
        });


    });


    function finish(id) {
        var fixDesc = $("#fixDesc" + id).val();
        if (!fixDesc) {
            showMessageBox("danger", "请输入维修描述!");
            $("#fixDesc" + id).focus();
            return;
        }
        var url = "/workOrderFix/finishDetail";
        $.post(url, {fixId: id, fixDesc: fixDesc}, function (data) {
            (data.result) ? showMessageBox("info", data.resultDesc) : showMessageBox("danger", data.resultDesc);
        });

    }


    function pause(id) {
        var fixDesc = $("#fixDesc" + id).val();
        if (!fixDesc) {
            showMessageBox("danger", "请输入维修描述!");
            $("#fixDesc" + id).focus();
            return;
        }
        var url = "/workOrderFix/pauseDetail";
        $.post(url, {fixId: id, fixDesc: fixDesc}, function (data) {
            (data.result) ? showMessageBox("info", data.resultDesc) : showMessageBox("danger", data.resultDesc);
        });

    }


    /**
     * 全选 全不选
     * @param obj
     */
    function checkAll(obj) {
        var checkName = $(obj).attr("name");
        $("input[name^='" + checkName + "']").prop('checked', $(obj).prop('checked'));
    }


    /**
     * 生成维修单
     */
    function generateFixRpt() {
        var orderReportList = new Array();
        $("input[name^='check']").each(function () {
            var value = $(this).val();
            if ($(this).is(":checked") && !isNaN(value)) {
                orderReportList.push(value);
            } else {
                orderReportList.push(null);
            }

        });
        var ids = orderReportList.join(",");
        var url = "/workOrderReport/mapByType";

        console.log("ids------------------" + ids);
        $.post(url, {ids: ids}, function (data) {
            if (data) {
                showMessageBox("info", "维修报告单已生成!");
            }
        });
    }


    /**
     *
     * @param id 预览
     */
    function preview(id) {
        PDFObject.embed("/report/report.pdf", "#pdf_view",
                {
                    width: "100%",
                    height: "750px"
                }
        )
        ;
    }


    /**
     * 查询未提交的维修单信息
     * @returns {Array}
     */
    function findNew() {
        var reports = [];
        var url = "/workOrderReport/findNew";
        $.getJSON(url, function (data) {
            reports = data;
            console.log("data--------------" + data.length);
        });
        return reports;
    }

    /**
     * 查询未提交的维修单明细信息
     * @returns {Array}
     */
    function findNewDetails() {
        var reports = [];
        var url = "/workOrderReport/findNewDetails";
        $.getJSON(url, function (data) {
            reports = data;
            console.log("data--------------" + data.length);
        });
        return reports;
    }
    /**
     *
     * @param perPageCount 每页条数
     * @param currentPageIndex 当前页是第几页
     */
    function getRecortsByPage(perPageCount, currentPageIndex) {
        var reports = [];
        var url = "/workOrderReport/getRecortsByPage/" + perPageCount + "/" + currentPageIndex;
        $.getJSON(url, function (data) {
            reports = data;
        });
        return reports;
    }
</script>
