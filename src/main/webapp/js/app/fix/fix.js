/**
 * Created by Administrator on 2016/7/22.
 */
$(document).ready(function () {
    $('#fixListTable').bootgrid({
        formatters: {

            /*     "fixDesc": function (column, row) {
             return '<input id="fixDesc' + row.id + '" type="text" style="height: 25px">'
             },*/
            "opMenus": function (column, row) {
                return '<a class="btn btn-default btn-xs"  onclick="pause(' + row.id + ')" title="暂停" ><i class="glyphicon glyphicon-pause"></i></a>' +
                    '<a class="btn btn-default btn-xs"  onclick="abort(' + row.id + ')" title="取消" ><i class="glyphicon glyphicon glyphicon-remove-circle"></i></a>' +
                    '<a class="btn btn-default btn-xs"  onclick="finish(' + row.id + ')" title="完工" ><i class="glyphicon glyphicon glyphicon-ok"></i></a>'
            }
        }
    });

    $('#fixDescForm')
        .bootstrapValidator({
            message: '该值无效 ',
            fields: {
                "fixDesc": {
                    message: '维修描述无效',
                    validators: {
                        notEmpty: {
                            message: '维修描述不能为空!'
                        },
                        stringLength: {
                            min: 1,
                            max: 200,
                            message: '维修描述为1到200个字符'
                        }
                    }
                }
            }
        }).on('success.form.bv', function (e) {
        // Prevent form submission
        e.preventDefault();
        // Get the form instance
        finishDetail();

    });


    $("#myTab a").on("click", function (e) {
        e.preventDefault();
        preview(1);
        $(this).tab('show');
    })
});

function dealResult() {
    $("#fix_desc_modal").modal("show");
}
/**
 *
 * @param id 完工
 */
function finish(id) {
    $("#fix_desc_modal").modal("show");
    detailID = id;
}


var detailID = null;
function finishDetail() {
    var operationType = "finishDetail";
    var operationDesc = "完工";
    updateOrderStatus(detailID, operationType, operationDesc);
}


function updateOrderStatus(id, operationType, operationDesc,modalId) {
    var fixDesc = $("#fixDesc").val();
    var url = "/workOrderFix/" + operationType;
    $.post(url, {fixId: id, fixDesc: fixDesc}, function (data) {
        $("#statusFlag").html("已" + operationDesc);
        $("#"+modalId).modal("show");
        (data.result) ? showMessageBox("info", data.resultDesc) : showMessageBox("danger", data.resultDesc);
    });
}
/**
 *
 * @param id 暂停
 */
function pause(id) {
    var operationType = "pauseDetail";
    var operationDesc = "暂停";
    updateOrderStatus(id, operationType, operationDesc);
}
/**
 *
 * @param id 取消
 */
function abort(id) {
    var operationType = "abortDetail";
    var operationDesc = "取消";
    updateOrderStatus(id, operationType, operationDesc);
}

/**
 *
 * @param id 预览
 */
function preview(id) {
    PDFObject.embed("/report/fixReport.pdf", "#pdf_view",
        {
            width: "100%",
            height: "750px"
        }
    );
}
