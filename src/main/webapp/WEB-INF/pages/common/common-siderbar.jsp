<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="sidebar" class="sidebar">
    <div class="sidebar-menu nav-collapse">
        <div class="divide-20"></div>
        <ul>
             <li class="has-sub">
                 <a data-url="javascript:;" class="">
                     <i class="fa fa-tachometer fa-fw"></i> <span class="menu-text">主页信息</span>
                     <span class="arrow"></span>
                 </a>
                 <ul class="sub">
                     <li><a class="" data-url="/portal/list"><span class="sub-menu-text">我的门户</span></a></li>
                 </ul>
             </li>
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
            <%--  <li class="has-sub">
                  <a data-url="javascript:;" class="">
                      <i class="fa fa-briefcase fa-fw"></i> <span class="menu-text">权限管理</span>
                      <span class="arrow"></span>
                  </a>
                  <ul class="sub">
                      <li><a class="" data-url="/dataFilter/list"><span class="sub-menu-text">数据过滤</span></a>
                      </li>
                      <li><a class="" data-url="/resource/list"><span class="sub-menu-text">资源管理</span></a>
                      </li>
                  </ul>
              </li>--%>

            <%--   <li class="has-sub">
                   <a data-url="javascript:;" class="">
                       <i class="fa fa-table fa-fw"></i> <span class="menu-text">物资管理</span>
                       <span class="arrow"></span>
                   </a>
                   <ul class="sub">
                       <li><a class="" data-url="/consumables/list/1"><span class="sub-menu-text">易耗品信息</span></a></li>
                       <li><a class="" data-url="/consumables/list/2"><span class="sub-menu-text">设备配件信息</span></a></li>
                       &lt;%&ndash; <li><a class="" data-url="/equipment/list"><span class="sub-menu-text">设备信息</span></a></li>&ndash;%&gt;
                   </ul>
               </li>--%>
            <%-- <li class="has-sub">
                 <a data-url="javascript:;" class="">
                     <i class="fa fa-pencil-square-o fa-fw"></i> <span class="menu-text">终端管理</span>
                     <span class="arrow"></span>
                 </a>
                 <ul class="sub">
                     <li><a class="" data-url=""><span class="sub-menu-text">PDA信息</span></a></li>
                     <li><a class="" data-url=""><span
                             class="sub-menu-text">导航仪信息</span></a></li>
                     <li><a class="" data-url=""><span
                             class="sub-menu-text">指挥机信息</span></a></li>

                     <li><a class="" data-url=""><span
                             class="sub-menu-text">北斗卡信息</span></a></li>
                 </ul>
             </li>--%>
            <%--  <li class="has-sub">
                  <a data-url="javascript:;" class="">
                      <i class="fa fa-bar-chart-o fa-fw"></i> <span class="menu-text">围栏管理</span>
                      <span class="arrow"></span>
                  </a>
                  <ul class="sub">
                      <li><a class="" data-url="/fencing/list"><span class="sub-menu-text">围栏信息</span></a></li>
                      <li><a class="" data-url=""><span class="sub-menu-text">围栏设置</span></a></li>
                  </ul>
              </li>--%>
            <%--<li class="has-sub">
                <a data-url="javascript:;" class="">
                    <i class="fa fa-columns fa-fw"></i> <span class="menu-text">信息管理</span> <span class="arrow"></span>
                </a>
                <ul class="sub">
                    <li><a class="" data-url=""><span class="sub-menu-text">北斗信息</span></a></li>
                    <li><a class="" data-url=""><span class="sub-menu-text">GPS信息</span></a></li>
                </ul>
            </li>--%>
            <%-- <li class="has-sub">
                 <a data-url="javascript:;" class="">
                     <i class="fa fa-map-marker fa-fw"></i> <span class="menu-text">终端定位</span>
                     <span class="arrow"></span>
                 </a>
                 <ul class="sub">
                     <li><a class="" data-url="/terminal/list"><span class="sub-menu-text">儿童手表</span></a></li>
                     <li><a class="" data-url="/terminal/list"><span class="sub-menu-text">宠物项圈</span></a></li>
                 </ul>
             </li>--%>
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

                    <%-- --%>
                    <li><a class="" data-url="/workOrderReportCart/list"><span class="sub-menu-text">报修车信息</span></a>
                    </li>
                    <li><a class="" data-url="/workOrderReport/list"><span class="sub-menu-text">报修单信息</span></a></li>
                    <li><a class="" data-url="/workOrderDispatch/list"><span class="sub-menu-text">调度台信息</span></a></li>
                    <li><a class="" data-url="/workOrderFix/list"><span class="sub-menu-text">维修单信息</span></a></li>
                    <%--<li><a class="" data-url="/workOrderReport/list"><span class="sub-menu-text">设备报修</span></a></li>--%>
                    <%-- <li><a class="" data-url="/workOrder/distribute"><span class="sub-menu-text">分配工单</span></a></li>
                     <li><a class="" data-url="/finish/list"><span class="sub-menu-text">维修完工</span></a>
                     </li>--%>
                </ul>
            </li>

            <%--<li class="has-sub">
                <a data-url="javascript:;" class="">
                    <i class="fa fa-briefcase fa-fw"></i> <span class="menu-text">工单管理</span>
                    <span class="arrow"></span>
                </a>
                <ul class="sub">
                    <li><a class="" data-url="/workOrder/list"><span class="sub-menu-text">工单信息</span></a>
                    </li>
                </ul>
            </li>--%>
            <li class="has-sub">
                <a data-url="javascript:;" class="">
                    <i class="fa fa-briefcase fa-fw"></i> <span class="menu-text">系统管理</span>
                    <span class="arrow"></span>
                </a>
                <ul class="sub">
                    <%--  <li><a class="" data-url="/department/list"><span class="sub-menu-text">部门管理</span></a>
                      </li>--%>
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