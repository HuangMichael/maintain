jQuery(document).ready(function () {
    DisPatchFormWizard.init()
});
var selectedId = [];
function generateReport() {
    var ids = selectedId.join(",");
    if (!ids) {
        showMessageBoxCenter("danger", "center", "请选择要操作的记录!");
        return
    }
    $("#modal_div").load("/workOrderReportCart/loadDetailList");
    $("#cart_modal").modal("show")
}
function confirmGenerate() {
    $("#cart_modal").modal("hide");
    var ids = selectedId.join(",");
    var url = "/workOrderReport/generateReport";
    $.post(url, {ids: ids}, function (data) {
        showMessageBox("info", "报修单已生成")
    })
}
function save() {
    var orderReportList = new Array();
    $("input[id^='orderDesc']").each(function () {
        var name = $(this).attr("id");
        var id = name.substring(9, name.length);
        var orderDesc = $(this).val();
        var obj = {id: id, orderDesc: orderDesc};
        if (id && orderDesc) {
            orderReportList.push(obj)
        } else {
            orderReportList.push(null)
        }
    });
    var result = true;
    for (var x in orderReportList) {
        var obj = orderReportList[x];
        var url = "/workOrderReport/saveOrderDesc";
        if (!obj) {
            showMessageBoxCenter("danger", "center", "设备故障描述不能为空!");
            result = false;
            break
        }
        $.post(url, {id: obj.id, orderDesc: obj.orderDesc}, function (data) {
        })
    }
    if (result) {
        $("#resultListDiv").load("/workOrderReport/showUpdated");
        showMessageBox("info", "")
    }
}
function delCart(id) {
    var confirm = window.confirm("确认将该报修信息移出报修车么？");
    if (confirm) {
        var url = "/workOrderReportCart/delCart";
        $.post(url, {id: id}, function (data) {
            $("#tr" + id).remove();
            showMessageBox("info", "已将报修信息移出报修车")
        })
    }
}
function checkAll(obj) {
    $("#account input[type='checkbox']").prop("checked", $(obj).prop("checked"))
};


$("input[name^='selUnit']").on("click", function () {

    alert($(this).attr("name"));
});


function selectUnit(name) {
    var unitId = $("#" + name).val();
    var detailId = name.substring(7);
    //获取当前设备分类对应的所有维修单位
    updateDetailUnit(detailId, unitId);
}


/**
 *
 * @param select 查询所有的外委单位
 * @param orderId
 */
function loadUnit(select) {
    var url = "/outsourcingUnit/findByStatus/1";
    $.getJSON(url, function (data) {
        $("#" + select).empty();
        var html = "";
        for (var x in data) {
            html += "<option value='" + data[x].id + "'>" + data[x].description + "</option>"
        }
        $("#" + select).html(html);
    });
}


/**
 *
 * @param detailId 明细ID
 * @param unitId 维修单位ID
 */
function updateDetailUnit(detailId, unitId) {

    var url = "/workOrderDispatch/updateDetailUnit";

    if (detailId && unitId) {
        $.post(url, {detailId: detailId, unitId: unitId}, function (data) {
            showMessageBox("info", "维修单位设置成功");
        })
    } else {


    }


}
