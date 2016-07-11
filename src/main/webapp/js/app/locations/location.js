var zTree;
var demoIframe;
var reportModel = null;
var eqClasses = [];
var setting = {
    check: {enable: false},
    view: {dblClickExpand: false, showLine: true, selectedMulti: false},
    data: {simpleData: {enable: true, idKey: "id", pIdKey: "pId", rootPId: ""}},
    callback: {
        onClick: function (event, treeId, treeNode, clickFlag) {
            fillForm1(treeNode);
            var url = "/location/detail/" + treeNode.id;
            $("#contentDiv").load(url, function (data) {
                fillForm1(treeNode, data)
            });
            return true
        }
    }
};
var zNodes = [];
var locationSel = [];
$(document).ready(function () {
    var url = "/location/findTree";
    var pid = 0;
    $.ajaxSettings.async = false;
    $.getJSON(url, function (data) {
        for (var x = 0; x < data.length; x++) {
            zNodes[x] = {
                id: data[x][0],
                location: data[x][1],
                name: data[x][2],
                superior: data[x][3],
                pId: (data[x][4]) ? (data[x][4]) : 0,
                open: false,
                isParent: pid
            };
            locationSel[x] = {id: data[x][0], text: data[x][1], desc: data[x][1]}
            firstLoad(data);
        }
        var t = $("#tree");
        t = $.fn.zTree.init(t, setting, zNodes);
        demoIframe = $("#testIframe");
        demoIframe.bind("load", loadReady);
        zTree = $.fn.zTree.getZTreeObj("tree");
        zTree.selectNode(zTree.getNodeByParam("id", zNodes[0]));
    });
    function loadReady() {
        var bodyH = demoIframe.contents().find("body").get(0).scrollHeight, htmlH = demoIframe.contents().find("html").get(0).scrollHeight, maxH = Math.max(bodyH, htmlH), minH = Math.min(bodyH, htmlH), h = demoIframe.height() >= maxH ? minH : maxH;
        if (h < 530) {
            h = 530
        }
        demoIframe.height(h)
    }


    $('select').select2({theme: "bootstrap"});
});
var flag = false;
function loadCreateForm() {
    var tree = $.fn.zTree.getZTreeObj("tree");
    var selectedNode = zTree.getSelectedNodes()[0];
    var id = selectedNode.id;
    if (!id) {
        id = 0
    }
    var url = "/location/create/" + id;
    $("#contentDiv").load(url, function () {
        $("#line_id").val(selectedNode.line);
        $("#parent_id").val(id);
        $("#station_id").val(selectedNode.station);
        flag = true
    })
}
/**
 * 保存位置信息
 */
function save() {
    var objStr = getFormJsonData("form");
    var locations = JSON.parse(objStr);
    var url = "/location/save";
    $.ajax({
        type: "POST", url: url, data: locations, dataType: "JSON", success: function (obj) {
            var parent = $("#parent_id").val();
            //构造一个子节点
            var childZNode = {
                id: obj.id,
                pId: parent,//如果重新选择了上级  以选择后的位置为准
                name: obj.description,
                location: obj.location,
                superior: obj.superior,
                isParent: obj["hasChild"]
            };
            if (locations.id) {
                updateNode(null, childZNode);
                showMessageBox("info", "位置信息更新成功")
            } else {
                addNodeAfterChangeOperation(null, childZNode, parent);
                showMessageBox("info", "位置信息添加成功")
            }
        }, error: function (msg) {
            if (locations.id) {
                showMessageBox("danger", "位置信息更新失败")
            } else {
                showMessageBox("danger", "位置信息添加失败")
            }
        }
    })
}
/**
 *  删除位置信息
 */
function deleteObject() {
    if (!confirm("确定要删除该信息么？")) {
        return
    }
    var zTree = $.fn.zTree.getZTreeObj("tree");
    var selectedNode = zTree.getSelectedNodes()[0];
    var id = selectedNode.id;
    var url = "/location/delete/" + id;
    $.getJSON(url, function (data) {
        console.log(JSON.parse(data));
        if (data) {
            var zTree = $.fn.zTree.getZTreeObj("tree");
            zTree.removeNode(zTree.getSelectedNodes()[0]);
            zTree.selectNode(zTree.getNodeByParam("id", 1));
            showMessageBox("info", "设备位置信息删除成功")
        } else {
            showMessageBox("danger", "设备位置信息删除失败")
        }
    })
}
function fillForm1(treeNode) {
    if (!treeNode.pId) {
        $("#parent_id").attr("readonly", "readonly")
    } else {
        $("#parent_id").removeAttr("readonly")
    }
    $("#lid").val(treeNode.id);
    $("#location").val(treeNode.location);
    $("#description").val(treeNode.name);
    $("#superior").val(treeNode.superior);
    $("#parent_id").val(treeNode.pId)
}
function changeLine(stationId) {
    var lineId = $("#line_id").val();
    $("#station_id").html("");
    var url = "/station/findStationByLine/" + lineId;
    $.getJSON(url, function (data) {
        for (var x in data) {
            var s = data[x]["description"];
            var sid = data[x]["id"];
            if (s && sid != stationId) {
                $("#station_id").append("<option value='" + data[x].id + "'>" + s + "</option>")
            }
            if (s && sid == stationId) {
                $("#station_id").append("<option value='" + data[x].id + "' selected>" + s + "</option>")
            }
        }
    })
}
function reportByLocation() {
    var location = getSelectedNode().location;
    var locationId = getSelectedNode().id;
    var status = "0";
    var path = "/location/findById/" + locationId;
    $.getJSON(path, function (data) {
        status = data["status"]
    });
    if (!location) {
        showMessageBox("danger", "请先选中位置再进行报修操作!");
        return
    }


    var url = "/commonData/findEqClass";
    $.getJSON(url, function (data) {
        eqClasses = data;
        console.log("eqClasses-----------" + eqClasses.length);
        reportModel.$data.eqClasses = data;
    });


    console.log("eqClasses-------------" + eqClasses.length);
    //新建一个数据模型
    //初始化请求设备分类
    reportModel = new Vue({
        el: "#locReportForm",
        data: {
            eqClasses: eqClasses

        }
    });

    console.log("report status-----------" + status);
    if (status == "2") {
        var curl = "/workOrderReportCart/loadReportedLocPage/" + location;
        $("#locList").load(curl, function (data) {
            $("#show_loc_modal").modal("show")
        })
    } else {
        if (status == "1") {
            $("#rptLoc").val(getSelectedNode().name);
            $("#loc_modal").modal("show")
        }
    }
}
/**
 *  已经报修提示重复报修 选择继续
 */
function continueLocReport() {


    var url = "/commonData/findEqClass";
    $.getJSON(url, function (data) {
        eqClasses = data;
        console.log("eqClasses-----------" + eqClasses.length);
        reportModel.$data.eqClasses = data;
    });


    $("#show_loc_modal").modal("hide");
    $("#rptLoc").val(getSelectedNode().name);
    $("#loc_modal").modal("show");
}
function add2LocCart() {
    var nodeId = getSelectedNodeId();
    var url = "/workOrderReportCart/add2LocCart";
    var orderDesc = $("#orderDesc").val();
    var reporter = $("#reporter").val();
    var creator = $("#creator").val();
    var eqClassId = $("#equipmentsClassification_id").val();

    if (!orderDesc) {
        showMessageBox("danger", "位置报修描述不能为空!");
        $("#orderDesc").focus();
        return
    }
    if (!reporter) {
        showMessageBox("danger", "报修人不能为空!");
        $("#reporter").focus();
        return
    }


    var obj = {locationId: nodeId, orderDesc: orderDesc, reporter: reporter, creator: creator, eqClassId: eqClassId};
    $.post(url, obj, function (data) {
        $("#loc_modal").modal("hide");
        var size = $("#reportOrderSize").html();
        if (!size) {
            size = 0
        }
        $("#reportOrderSize").html(parseInt(size) + 1);
        showMessageBox("info", "已将位置报修加入到维修车!")
    })
};


/**
 *
 * @param data
 * 首次加载函数 在form中显示第一条记录内容
 */
function firstLoad(data) {
    if (data.length > 0) {
        $("#location").val(data[0][1]);
        $("#description").val(data[0][2]);
        $("#superior").val(data[0][3]);
        $("#parent_id").val(null).attr("readonly", "readonly");
    }
}