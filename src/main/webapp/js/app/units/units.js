/**
 * Created by Administrator on 2016/6/20 0020.
 */
jQuery(document).ready(function () {
    $("#datatable1").bootgrid({
        selection: true,
        multiSelect: false,
        rowSelect: true,
        keepSelection: false
    }).on("selected.rs.jquery.bootgrid", function (e, rows) {
        for (var i = 0; i < rows.length; i++) {
            selectedId.push(rows[i].id);
        }
    }).on("deselected.rs.jquery.bootgrid", function (e, rows) {
        for (var i = 0; i < rows.length; i++) {
            selectedId.remove(rows[i].id);
        }
    });
});
/**
 * 创建记录  弹出框之前清空内容
 */
function create() {
    $("#unit_modal input").val("");
    $("#unit_modal").modal("show");
}
function saveUnit() {
    var objStr = getFormJsonData("unitForm");
    var outsourcingUnit = JSON.parse(objStr);
    console.log(JSON.stringify(outsourcingUnit));
    var url = "/outsourcingUnit/save";
    $.ajax({
        type: "post",
        url: url,
        data: outsourcingUnit,
        dataType: "json",
        success: function (data) {
            $("#unit_modal").modal("hide");
            if (unit.id) {
                showMessageBox("info", "外委单位信息更新成功");
            } else {
                showMessageBox("info", "外委单位信息添加成功");
            }
        }, error: function (data) {
            if (unit.id) {
                showMessageBox("danger", "外委单位信息更新失败");
            } else {
                showMessageBox("info", "外委单位信息添加失败");
            }
        }
    });
}

var selectedId = [];
$("#myTab a").on("click", function (e) {
    e.preventDefault();
    if (!selectedId) {
        selectedId = getAllCheckboxID("datatables1")[0];
    }
    var tabId = $(this).children(0).attr("id");
    console.log("selectedId---------"+tabId);
    if (tabId == ("unitDetail")) {
        fillDetailByUid(selectedId, "#unitForm");
    } else if (tabId == ("contract")) {
        loadPageByUrl("table_1_2", selectedId, "table_1_2");
    }
    $(this).tab('show');
})


/**
 * 根据对应的外委单位id查询对应的明细信息
 * @param id  外委单位id
 * @param formId form detail
 */
function fillDetailByUid(id, formId) {
    var url = "/outsourcingUnit/findById/" + id;
    $.getJSON(url, function (data) {
        fillForm(data, formId);
        $("#status").find("option[value='" + data.status + "']").attr("selected", true);
        ;
    });
}

/**
 * 根据外委单位id查询对应的合同文本信息
 * @param id  外委单位id
 * @param formId form detail
 */
function loadPageByUrl(pageUrl, uid, tableId) {
    var url = "/outsourcingUnit/loadPageByUrl/" + pageUrl + "/" + uid;
    $("#" + tableId).empty();
    $("#" + tableId).load(url, function () {

    });
}

/**
 * 根据外委单位id查询对应的合同文本信息
 * @param id  外委单位id
 * @param formId form detail
 */
function loadSafety(id, formId) {
    var url = "/outsourcingUnit/findById/" + id;
    $.getJSON(url, function (data) {
        fillForm(data, formId);
    });
}
/**
 * 根据外委单位id查询对应的合同文本信息
 * @param id  外委单位id
 * @param formId form detail
 */
function loadService(id, formId) {
    var url = "/outsourcingUnit/findById/" + id;
    $.getJSON(url, function (data) {
        fillForm(data, formId);
    });
}
/**
 * 根据外委单位id查询对应的设备信息
 * @param id  外委单位id
 * @param formId form detail
 */
function loadEquipments(id, formId) {
    var url = "/outsourcingUnit/findById/" + id;
    $.getJSON(url, function (data) {
        fillForm(data, formId);
    });
}
/**
 *
 * @param id 加载明细信息
 */
function detail(id) {

    $("#detail").load("/outsourcingUnit/detail/" + id);
}
/**
 *
 * @param id 编辑信息
 */
function edit(id) {
    //根据id查询出外委单位信息
    var url = "/outsourcingUnit/findById/" + id;
    $.getJSON(url, function (data) {
        fillForm(data, "#unitForm");
    });
    $("#unit_modal").modal("show");
}
/**
 * 根据对应的设备id获取设备的信息  并且填充所有的设备明细信息
 * @param id  设备id
 * @param formId form detail
 */
function fillDetailById(id, formId) {
    var url = "/outsourcingUnit/findById/" + id;
    $.getJSON(url, function (data) {
        $("#unitNo").val(data.unitNo);
        $("#description").val(data.description);
        $("#linkman").val(data.linkman);
        $("#telephone").val(data.telephone);
        $("#status").val(data.status);
    });
}


var currentIndex = 0;//默认当前选中为第1条
/**
 * 下一条
 */
function toNext() {
    var allEqIds = getAllTableIdsByTableId("datatable1");
    var allIds = $("#datatable1").bootgrid("getTotalRowCount");
    if (currentIndex == allIds - 1) {
        showMessageBox("info", "已经是最后一条记录了");
    } else {
        console.log("当前是第" + (currentIndex + 1) + "/" + allIds + "条记录");
        currentIndex++;
        fillDetailById(allEqIds[currentIndex], "editForm");
    }


}
/**
 * 上一条
 */
function toPrevious() {
    var allEqIds = getAllTableIdsByTableId("datatable1");
    if (currentIndex == 0) {
        showMessageBox("info", "已经是第一条记录了");
    } else {
        currentIndex--;
        fillDetailById(allEqIds[currentIndex], "editForm");
    }
}