<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="sidebar" class="sidebar">
    <div class="sidebar-menu nav-collapse">
        <div class="divide-20"></div>
        <ul>
            <%--  <li class="has-sub">
                  <a data-url="javascript:;" class="">
                      <i class="fa fa-tachometer fa-fw"></i> <span class="menu-text">主页信息</span>
                      <span class="arrow"></span>
                  </a>
                  <ul class="sub">
                      <li><a class="" data-url="/portal/list"><span class="sub-menu-text">我的门户</span></a></li>
                  </ul>
              </li>--%>
            <li class="has-sub">
                <a data-url="javascript:;" class="">
                    <i class="fa fa-bookmark-o fa-fw"></i> <span class="menu-text">用户管理</span>
                    <span class="arrow"></span>
                </a>
                <ul class="sub">
                    <li><a class="" data-url="/user/list"><span class="sub-menu-text">用户信息</span></a></li>
                    <li><a class="" data-url="/person/list"><span class="sub-menu-text">人员信息</span></a></li>
                    <%-- <li><a class="" data-url="/groups/list"><span class="sub-menu-text">用户组信息</span></a></li>

                     <li><a class="" data-url="/role/list"><span class="sub-menu-text">角色信息</span></a></li>
                     <li><a class="" data-url="/authority/list"><span class="sub-menu-text">角色授权</span></a>
                     </li>--%>
                </ul>
            </li>
            <li class="has-sub">
                <a data-url="javascript:;" class="">
                    <i class="fa fa-file-text fa-fw"></i> <span class="menu-text">设备管理</span>
                    <span class="arrow"></span>
                </a>
                <ul class="sub">
                    <li><a class="" data-url="/location/list"><span class="sub-menu-text">位置信息</span></a>
                    </li>
                    <li><a class="" data-url="/equipment/list"><span class="sub-menu-text">设备信息</span></a></li>

                </ul>
            </li>

            <li class="has-sub">
                <a data-url="javascript:;" class="">
                    <i class="fa fa-table fa-fw"></i> <span class="menu-text">维修管理</span>
                    <span class="arrow"></span>
                </a>
                <ul class="sub">
                    <li><a class="" data-url="/workOrderReportCart/list"><span class="sub-menu-text">报修车信息</span></a></li>
                    <li><a class="" data-url="/workOrderReport/list"><span class="sub-menu-text">报修单查询</span></a></li>
                    <li><a class="" data-url="/workOrderDispatch/list"><span class="sub-menu-text">调度台信息</span></a></li>
                    <li><a class="" data-url="/workOrderFix/list"><span class="sub-menu-text">维修单查询</span></a></li>
                </ul>
            </li>
            <li class="has-sub">
                <a data-url="javascript:;" class="">
                    <i class="fa fa-briefcase fa-fw"></i> <span class="menu-text">系统管理</span>
                    <span class="arrow"></span>
                </a>
                <ul class="sub">
                    <li><a class="" data-url="/equipmentsClassification/list"><span class="sub-menu-text">设备分类管理</span></a>
                    </li>
                    <li><a class="" data-url="/outsourcingUnit/list"><span class="sub-menu-text">外委单位管理</span></a>
                    </li>
                    <li><a class="" data-url="/line/list"><span class="sub-menu-text">线路管理</span></a>
                    </li>
                    <li><a class="" data-url="/station/list"><span class="sub-menu-text">车站管理</span></a>
                    </li>

                </ul>
            </li>
        </ul>
        <!-- /SIDEBAR MENU -->
    </div>
</div>
<script type="text/javascript" src="http://cdn.bootcss.com/jquery/2.1.4/jquery.min.js"></script>
<script type="text/javascript">
    $(function () {
        $(".sub-menu-text").parent().on("click", function () {
            $(this).css("cursor", "hand");
            var url = $(this).data("url");
            if (url) {
                $("#main-content").load(url, function () {
                    $(this).removeData("url");
                });
            }
        });
    })
</script>