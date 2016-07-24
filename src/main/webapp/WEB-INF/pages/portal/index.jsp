<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<% response.setContentType("text/html;charset=UTF-8");%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<%@include file="../common/common-head.jsp" %>
<body>
<!-- HEADER -->
<%@include file="../common/common-navbar.jsp" %>
<!--/HEADER -->
<!-- PAGE -->
<section id="page">
    <!-- SIDEBAR -->
    <%@include file="../common/common-siderbar.jsp" %>
    <!-- /SIDEBAR -->
    <div id="main-content">

        <div class="container">
            <div class="row">
                <div id="content" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <%@include file="../common/common-breadcrumb.jsp" %>

                    <div class="row">
                        <div class="col-md-6">
                            <div id="highcharts2"></div>
                        </div>
                        <div class="col-md-6">
                            <div id="highcharts0"></div>
                        </div>
                        <div class="col-md-12">
                            <div id="highcharts1"></div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<%@include file="../common/common-foot.jsp" %>
<script type="text/javascript" src="js/Highcharts-4.2.4/js/highcharts.js"></script>
<script>
    $(document).ready(function () {
        App.setPage("inbox");  //Set current page
        App.init(); //Initialise plugins and elements
    });
</script>

<script type="text/javascript">
    $(function () {
        Highcharts.setOptions({
            colors: ['#50B432', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4', '#058DC7']
        });
        var url = "/line/findByStatus";
        var lines = [];
        $.ajaxSettings.async = false;
        $.getJSON(url, function (data) {
            for (var x in data) {
                if (data[x]['description'] && x < 7) {
                    lines[x] = data[x]['description'];
                }
            }
        });
        $('#highcharts1').highcharts({
            chart: {
                type: 'column'
            },
            title: {
                text: '报修单按线别统计'
            },
            subtitle: {
                text: '2016年6月'
            },
            xAxis: {
                categories: lines,
                crosshair: true
            },
            yAxis: {
                min: 0,
                title: {
                    text: '工单数量(单位:个)'
                }
            },
            tooltip: {
                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y}</b></td></tr>',
                footerFormat: '</table>',
                shared: true,
                useHTML: true
            },
            plotOptions: {
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0
                }
            },
            series: [{
                name: '报修',
                data: [1356, 1485, 2164, 1941]

            }, {
                name: '完工',
                data: [836, 1043, 912, 835]

            }, {
                name: '维修中',
                data: [483, 590, 596, 524]

            }, {
                name: '暂停',
                data: [424, 332, 345, 397]

            }
            ]
        });


        //ajax 请求当月设备分类前5
        var chart2Data = [];
        $.getJSON("/portal/findTopEqClass/5", function (data) {
            chart2Data = data;
        });


        $('#highcharts2').highcharts({
            chart: {
                type: 'pie'
            },
            title: {
                text: '报修单按报修前5设备种类统计'
            },
            subtitle: {
                text: '2016年6月'
            },
            plotOptions: {
                series: {
                    dataLabels: {
                        enabled: true,
                        format: '{point.name}: {point.y}'
                    }
                }
            },
            exporting: {
                enabled: false
            },


            tooltip: {
                headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
                pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y}</b>'
            },
            series: [{
                name: '报修数量',
                colorByPoint: true,
                data: chart2Data
            }]
        });


        var seriesOptions = [];
        var option0, option1, months;

        option0 = {
            "name": "报修数量",
            "data": get3MonthReportNum()
        }
        option1 = {
            "name": "完工数量",
            "data": get3MonthFinishNum()
        }
        seriesOptions.push(option0);
        seriesOptions.push(option1);
        $('#highcharts0').highcharts({
            chart: {
                type: 'column'
            },

            exporting: {
                enabled: false
            },
            title: {
                text: '最近3个月报修完成率统计'
            },
            subtitle: {
                text: get3MonthTitle()
            },
            plotOptions: {
                column: {
                    depth: 25
                }
            },
            xAxis: {
                categories: get3MonthTitle()
            },
            yAxis: {
                min: 0,
                title: {
                    text: '工单数量(单位:个)'
                }
            },
            series: seriesOptions
        });

    });

    function get3MonthTitle() {
        $.ajaxSettings.async = false;
        var url = "/portal/getLastNMonth/3";
        var title = [];
        $.getJSON(url, function (data) {
            for (var x in data) {
                title[2 - x] = data[x];
            }
        });
        return title;
    }


    function get3MonthReportNum() {
        $.ajaxSettings.async = false;
        var url = "/workOrderReport/sel3mRptNum";
        var reportNums = [];
        $.getJSON(url, function (data) {
            for (var x in data) {
                if (data[x]["reportNum"]) {
                    reportNums[x] = data[x]["reportNum"];
                }
            }
        });
        return reportNums;
    }

    function get3MonthFinishNum() {
        $.ajaxSettings.async = false;
        var url = "/workOrderReport/sel3mFinishNum";
        var finishNums = [];
        $.getJSON(url, function (data) {
            for (var x in data) {
                if (data[x]["finishNum"]) {
                    finishNums[x] = data[x]["finishNum"];
                }
            }
        });
        console.log("完工从头再来-------------" + JSON.stringify(finishNums));
        return finishNums;
    }
</script>
</body>
</html>