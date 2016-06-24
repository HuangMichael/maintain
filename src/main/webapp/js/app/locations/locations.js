var zTree;
var demoIframe;

var sssid = null;
var setting = {
    check: {
        enable: false
    },
    view: {
        dblClickExpand: false,
        showLine: true,
        selectedMulti: false
    },
    data: {
        simpleData: {
            enable: true,
            idKey: "id",
            pIdKey: "pId",
            rootPId: ""
        }
    },
    callback: {
        onClick: function (event, treeId, treeNode, clickFlag) {
            var url = "/locations/detail/" + treeNode.id;
            $("#contentDiv").load(url);
            return true;
        }
    }
};
var zNodes = [];
$(document).ready(function () {
    var url = "/locations/findAll";
    var pid = 0;
    var obj = null;
    $.getJSON(url, function (data) {
        for (var x = 0; x < data.length; x++) {
            if (data) {
                obj = data[x];
                pid = (!obj["parent"]) ? 0 : obj["parent"].id;
                zNodes[x] = {id: obj.id, pId: pid, name: obj.description, open: !pid, isParent: obj["hasChild"]};
            } else {
                alert("信息加载出错");
            }
        }
        var t = $("#tree");
        t = $.fn.zTree.init(t, setting, zNodes);
        demoIframe = $("#testIframe");
        demoIframe.bind("load", loadReady);
        var zTree = $.fn.zTree.getZTreeObj("tree");
        zTree.selectNode(zTree.getNodeByParam("id", 1));

    });
    function loadReady() {
        var bodyH = demoIframe.contents().find("body").get(0).scrollHeight,
            htmlH = demoIframe.contents().find("html").get(0).scrollHeight,
            maxH = Math.max(bodyH, htmlH), minH = Math.min(bodyH, htmlH),
            h = demoIframe.height() >= maxH ? minH : maxH;
        if (h < 530) h = 530;
        demoIframe.height(h);
    }
});



function getAllID(){
    var treeObj = $.fn.zTree.getZTreeObj("tree");
    var sNodes = treeObj.getSelectedNodes();
    if (sNodes.length > 0) {
        var tId = sNodes[0].tId;
        alert(tId);
    } alert(sNodes);
}




var flag = false;
/**
 *加载创建form
 *
 * */
function loadCreateForm(id) {


    getAllID();
   /* var zTree = $.fn.zTree.getZTreeObj("tree");
    var selectedNode = zTree.getSelectedNodes()[0];
    var pid = selectedNode.id;

    console.log(" the selected tree node pid---"+pid);
    console.log(" the selected tree node---"+id);
    var url = "/locations/create/" + pid;
    $("#contentDiv").load(url, function () {
        flag = true;
    });*/
}

/**
 *保存信息
 * */
function save() {
    var array = $("#form").serializeArray();
    var objStr = '{';
    for (var x in array) {
        if (array[x]["name"] && array[x]["value"]) {
            objStr += '"' + array[x]["name"] + '"';
            objStr += ":";
            objStr += '"' + array[x]["value"] + '",';
        }
    }
    objStr = objStr.substring(0, objStr.length - 1);
    objStr += '}';
    var locations = JSON.parse(objStr);
    var url = "/locations/save";
    $.ajax({
        type: "POST",
        url: url,
        data: locations,
        dataType: "JSON",
        success: function (msg) {

            var childZNode = {
                id: msg.id,
                pId: msg.parent.id,
                name: msg.description,
                open: msg.parent.id,
                isParent: msg["hasChild"]
            };

            if (locations.id) {
                showMessageBox("info", "位置信息更新成功");
            } else {
                addNodeAfterOperation(null, childZNode);
                showMessageBox("info", "位置信息添加成功");

            }
        },
        error: function (msg) {
            if (locations.id) {
                showMessageBox("danger", "位置信息更新失败");
            } else {
                showMessageBox("danger", "位置信息添加失败");

            }
        }
    });
}


/**
 *删除信息
 * */


function deleteObject() {
    if (!confirm("确定要删除该信息么？")) {
        return;
    }
    var zTree = $.fn.zTree.getZTreeObj("tree");
    var selectedNode = zTree.getSelectedNodes()[0];
    var id = selectedNode.id;
    var url = "/locations/delete/" + id;
    $.getJSON(url, function (data) {
        zTree.removeNode(selectedNode);
        $.bootstrapGrowl("位置信息删除成功！", {
            type: 'info',
            align: 'right',
            stackup_spacing: 30
        });
        //部门
        zTree.selectNode(zTree.getNodeByParam("id", 1));
    })
}


function saveWorkOrder() {

    var sortNo = $("#sortNo").val();
    var orderDesc = $("#orderDesc").val();
    var orderNo = $("#orderNo").val();
    var reporter = $("#reporter").val();
    var reportTime = $("#reportTime").val();
    var reportTelephone = $("#reportTelephone").val();
    var equip_class_id = $("#equip_class_id").val();
    var url = "/workOrder/save";
    var pid = $("#parentId").val();
    $.ajax({
        type: "POST",
        url: url,
        data: {
            orderDesc: orderDesc,
            sortNo: sortNo,
            reporter: reporter,
            reportTime: reportTime,
            reportTelephone: reportTelephone,
            equip_class_id: equip_class_id,
            status: "1",
            pid: pid
        },
        dataType: "json",
        success: function (msg) {
            //  $("#wo_modal").css("display", "none");

            $(this).attr("disabled", true);
            $.bootstrapGrowl("工单信息添加成功！", {
                type: 'info',
                align: 'right',
                stackup_spacing: 30
            });

            // $("#list0-" + workOrderId).hide("fast");

        },
        error: function () {
            $.bootstrapGrowl("工单信息添加失败！", {
                type: 'danger',
                align: 'right',
                stackup_spacing: 30
            });
        }
    });
}
;

$("#saveWorkOrder").on("click", function () {

    saveWorkOrder();
});

function shareWorkOrder() {
    if (!g_woid0) {
        $.bootstrapGrowl("请选择工单信息！", {
            type: 'danger',
            align: 'right',
            stackup_spacing: 30
        });
        return;
    }
    var limitedHours = $("#limitedHours").val();
    var serviceMan = $("#serviceMan").val();
    var serviceTelephone = $("#serviceTelephone").val();
    var serviceCompany = $("#serviceCompany").val();
    var unit_id = $("#unit_id").find("option:selected").val();
    var data = {
        limitedHours: limitedHours,
        serviceMan: "",
        serviceTelephone: "",
        serviceCompany: serviceCompany,
        workOrderIdArray: g_woid0 + ",",
        unit_id: unit_id
    };
    var url = "/workOrder/shareWorkOrderBatch";
    $.ajax({
        type: "POST",
        url: url,
        data: data,
        dataType: "json",
        success: function (msg) {


            $("#share_work_order_modal").modal("hide");


            $.bootstrapGrowl("工单信息分配成功！", {
                type: 'info',
                align: 'right',
                stackup_spacing: 30
            });
        },
        error: function () {
            $.bootstrapGrowl("工单信息分配失败！", {
                type: 'danger',
                align: 'right',
                stackup_spacing: 30
            });
        }
    });
}
;
$("#shareWorkOrder").on("click", function () {

    shareWorkOrder();
});


$("#finishWorkOrder").on("click", function () {

    finishWorkOrder();
});


function finishWorkOrder() {

    console.log("g_woid0-------" + g_woid0);

    if (!g_woid0) {
        $.bootstrapGrowl("请选择工单信息！", {
            type: 'danger',
            align: 'right',
            stackup_spacing: 30
        });
        return;
    }

    var url = "/workOrder/finishWorkOrderBatch";
    $.post(url, {workOrderIdArray: g_woid0 + ","}, function (data) {
        // assessWorkOrder(workOrderId);
        reload();
        $.bootstrapGrowl("工单维修已完成！", {
            type: 'info',
            align: 'right',
            stackup_spacing: 30
        });
    });
}

function suspendWorkOrder() {

    console.log("g_woid0-------" + g_woid0);

    if (!g_woid0) {
        $.bootstrapGrowl("请选择工单信息！", {
            type: 'danger',
            align: 'right',
            stackup_spacing: 30
        });
        return;
    }

    var url = "/workOrder/suspendWorkOrderBatch";
    $.post(url, {workOrderIdArray: g_woid0 + ","}, function (data) {
        reload();
        $.bootstrapGrowl("工单已挂起！", {
            type: 'info',
            align: 'right',
            stackup_spacing: 30
        });
    });
}


function reload() {
    var selectedId = getSelectedNodeId();
    $("#contentDiv").load("/locations/detail/" + selectedId);

}

var g_woid0 = "";
function setPid0(woid0) {
    g_woid0 = woid0;

}

var g_woid = null;
function setPid1(woid) {
    g_woid = woid;

}

var g_woid2 = null;
function setPid2(woid2) {
    g_woid2 = woid2;
    finishWorkOrder(g_woid2);
}


$("#assessWorkOrder").on("click", function () {
    assessWorkOrder(g_woid2);
});

function assessWorkOrder() {
    var assessLevel = $("#assessLevel option:selected").val();
    var url = "/workOrder/assessWorkOrderBatch";
    $.post(url, {workOrderIdArray: g_woid0 + ",", assessLevel: assessLevel}, function (data) {
        $.bootstrapGrowl("工单评价已完成,感谢您的参与！", {
            type: 'info',
            align: 'right',
            stackup_spacing: 30
        });
    });
}


function changeLine() {
    var lineId = $("#line_id option:selected").val();
    var lineText = $("#line_id option:selected").text();
    $("#station_id").html(""); //清空车站的option选项
    var elementHtml = "<optgroup label='" + lineText + "'>";
    var url = "/station/findStationByLine/" + lineId;
    $.getJSON(url, function (data) {
        for (var x in data) {
            elementHtml += "<option value='" + data[x].id + "'>" + data[x].description + "</option>";
        }
        elementHtml += "</optgroup>";
        $("#station_id").html(elementHtml);
    });
}


function checkAll(tableName, obj) {
    g_woid0 = "";
    $("#" + tableName + " input[type='checkbox']").prop('checked', $(obj).prop('checked'));
    $("#" + tableName + " input[type='checkbox']").each(function (i) {
        if ($(this).attr("data-woId")) {
            console.log($(this).attr("data-woId"));
            g_woid0 += $(this).attr("data-woId") + ",";
        }
    });
}

function checkOne(obj) {
    if ($(obj).prop("checked") == true) {
        if ($(obj).attr("data-woId")) {
            console.log($(obj).attr("data-woId"));
            g_woid0 += $(obj).attr("data-woId") + ",";
        }
    }
}




