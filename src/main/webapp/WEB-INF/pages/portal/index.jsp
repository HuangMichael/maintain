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
            colors: ['#058DC7', '#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4']
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
                    text: '工单数量(个)'
                }
            },
            tooltip: {
                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
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
                name: '已报修',
                data: [1356, 1485, 2164, 1941]

            }, {
                name: '维修中',
                data: [836, 1043, 912, 835]

            }, {
                name: '已完工',
                data: [483, 590, 596, 524]

            }, {
                name: '已挂起',
                data: [424, 332, 345, 397]

            }
            ]
        })
        ;
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
                        enabled: false,
                        format: '{point.name}: {point.y:.1f}%'
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
                data: [{
                    name: '灯箱',
                    y: 56
                }, {
                    name: '闸机',
                    y: 44,
                    drilldown: '闸机'
                }, {
                    name: '屏蔽门',
                    y: 29,
                    drilldown: '屏蔽门'
                }, {
                    name: '点钞机',
                    y: 24,
                    drilldown: '点钞机'
                }, {
                    name: '电脑',
                    y: 19,
                    drilldown: '电脑'
                }]
            }]
        });


        var workOrderStatus = [
            {'name': '0', description: '报修数量'},
            {'name': '1', description: '完工数量'}
        ];
        var seriesOptions = [];
        var option;
        for (var x in workOrderStatus) {
            if (workOrderStatus[x].description) {
                option = {
                    "name": workOrderStatus[x].description,
                    "data": [Math.floor(Math.random() * 100), Math.floor(Math.random() * 100),Math.floor(Math.random() * 100)]
                }
                seriesOptions.push(option);
            }
        }


        var chart = $('#highcharts0').highcharts({
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
                text: '5,6,7 月'
            },
            plotOptions: {
                column: {
                    depth: 25
                }
            },
            xAxis: {
                categories:['5月','6月','7月']
            },
            yAxis: {
                title: {
                    text: null
                }
            }

            ,
            series: seriesOptions
        });






       /* function loadLines() {
            var lines = [];
            var url = "/line/findByStatus";
            $.getJSON(url, function (data) {
                for (var x in data) {
                    lines.push(data[x]["description"]);
                }
            });
            return lines;
        }*/
    });
</script>
</body>
</html>