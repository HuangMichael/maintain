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
        var url = "/station/findStationByLine/4";
        var stations = [];
        $.ajaxSettings.async = false;
        $.getJSON(url, function (data) {
            for (var x in data) {
                if (data[x]['description'] && x < 7) {
                    stations[x] = data[x]['description'];
                }
            }
        });
        $('#highcharts1').highcharts({
            chart: {
                type: 'column'
            },
            title: {
                text: '报修单按设备种类统计'
            },
            subtitle: {
                text: '2016年6月'
            },
            xAxis: {
                categories: stations,
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
                data: [1356, 1485, 2164, 1941, 956, 544]

            }, {
                name: '维修中',
                data: [836, 1043, 912, 835, 1066, 923]

            }, {
                name: '已完工',
                data: [483, 590, 596, 524, 652, 593]

            }, {
                name: '已挂起',
                data: [424, 332, 345, 397, 391, 468]

            }, {
                name: '评价',
                data: [590, 596, 524, 652, 593, 512]

            }
            ]
        })
        ;
        $('#highcharts2').highcharts({
            chart: {
                type: 'pie'
            },
            title: {
                text: '设备维修统计'
            },
            subtitle: {
                text: '虚拟数据'
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
                pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}%</b>'
            },
            series: [{
                name: '完工率',
                colorByPoint: true,
                data: [{
                    name: '西直门',
                    y: 56.33,
                    drilldown: '西直门'
                }, {
                    name: '大钟寺',
                    y: 24.03,
                    drilldown: '大钟寺'
                }, {
                    name: '知春路',
                    y: 10.38,
                    drilldown: '知春路'
                }, {
                    name: '上地',
                    y: 4.77,
                    drilldown: '上地'
                }, {
                    name: '西二旗',
                    y: 0.91,
                    drilldown: '西二旗'
                }]
            }],
            drilldown: {
                series: [{
                    name: '西直门',
                    id: '西直门',
                    data: [
                        ['v11.0', 24.13],
                        ['v8.0', 17.2],
                        ['v9.0', 8.11],
                        ['v10.0', 5.33],
                        ['v6.0', 1.06],
                        ['v7.0', 0.5]
                    ]
                }, {
                    name: '大钟寺',
                    id: '大钟寺',
                    data: [
                        ['v40.0', 5],
                        ['v41.0', 4.32],
                        ['v42.0', 3.68],
                        ['v39.0', 2.96],
                        ['v36.0', 2.53],
                        ['v43.0', 1.45],
                        ['v31.0', 1.24],
                        ['v35.0', 0.85],
                        ['v38.0', 0.6],
                        ['v32.0', 0.55],
                        ['v37.0', 0.38],
                        ['v33.0', 0.19],
                        ['v34.0', 0.14],
                        ['v30.0', 0.14]
                    ]
                }, {
                    name: '知春路',
                    id: '知春路',
                    data: [
                        ['v35', 2.76],
                        ['v36', 2.32],
                        ['v37', 2.31],
                        ['v34', 1.27],
                        ['v38', 1.02],
                        ['v31', 0.33],
                        ['v33', 0.22],
                        ['v32', 0.15]
                    ]
                }, {
                    name: '上地',
                    id: '上地',
                    data: [
                        ['v8.0', 2.56],
                        ['v7.1', 0.77],
                        ['v5.1', 0.42],
                        ['v5.0', 0.3],
                        ['v6.1', 0.29],
                        ['v7.0', 0.26],
                        ['v6.2', 0.17]
                    ]
                }, {
                    name: '西二旗',
                    id: '西二旗',
                    data: [
                        ['v12.x', 0.34],
                        ['v28', 0.24],
                        ['v27', 0.17],
                        ['v29', 0.16]
                    ]
                }]
            }
        });


        var workOrderStatus = [
            {'name': '0', description: '已报修'},
            {'name': '1', description: '维修中'},
            {'name': '2', description: '已完工'},
            {'name': '3', description: '已挂起'},
            {'name': '4', description: '已评价'}
        ];
        var seriesOptions = [];
        var option;
        for (var x in workOrderStatus) {
            if (workOrderStatus[x].description) {
                option = {
                    "name": workOrderStatus[x].description,
                    "data": [Math.floor(Math.random() * 100), Math.floor(Math.random() * 100), Math.floor(Math.random() * 100), Math.floor(Math.random() * 100)]
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
                text: '设备维修统计分析'
            },
            subtitle: {
                text: '虚拟数据'
            },
            plotOptions: {
                column: {
                    depth: 25
                }
            },
            xAxis: {
                categories: loadStations()
            },
            yAxis: {
                title: {
                    text: null
                }
            }

            ,
            series: seriesOptions
        });


        function loadStations() {
            var lines = [];
            var url = "/line/findByStatus";
            $.getJSON(url, function (data) {
                for (var x in data) {
                    lines.push(data[x]["description"]);
                }
            });
            return lines;
        }
    });
</script>