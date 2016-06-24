package com.linkbit.beidou.controller.workOrder;


import com.linkbit.beidou.domain.user.User;
import com.linkbit.beidou.domain.workOrder.WorkOrderReport;
import com.linkbit.beidou.domain.workOrder.WorkOrderReportDetail;
import com.linkbit.beidou.service.workOrder.WorkOrderReportService;
import com.linkbit.beidou.utils.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by huangbin on 2015/12/23 0023.
 */
@Controller
@EnableAutoConfiguration
@RequestMapping("/workOrderReport")
public class WorkOrderReportController {


    @Autowired
    WorkOrderReportService workOrderReportService;

    /**
     * 保存工单信息
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(ModelMap modelMap, HttpSession session) {

        User user = SessionUtil.getCurrentUserBySession(session);

        String location = user.getLocation();
        List<WorkOrderReport> workOrderReportList = workOrderReportService.findByLocationStartingWithAndStatus(location, "0");
        modelMap.put("workOrderReportList", workOrderReportList);
        return "/workOrderReport/list";
    }


    /**
     * 批量更新设备故障描述
     */
    @RequestMapping(value = "/generateReport", method = RequestMethod.POST)
    @ResponseBody
    public WorkOrderReport generateReport(@RequestParam("ids") String ids, HttpSession session) {
        WorkOrderReport workOrderReport = null;
        User user = SessionUtil.getCurrentUserBySession(session);
        if (user != null && user.getLocation() != null && user.getPerson() != null) {
            String location = user.getLocation();
            String personName = user.getPerson().getPersonName();
            workOrderReport = workOrderReportService.generateReport(ids, personName, location);
        }
        return workOrderReport;

    }

    /**
     * @return 按照设备分类进行规约
     */
    @RequestMapping(value = "/mapByType", method = RequestMethod.POST)
    @ResponseBody
    public List mapByType(@RequestParam("ids") String ids, HttpSession session) {
        List list = workOrderReportService.mapByType(ids);
        User user = SessionUtil.getCurrentUserBySession(session);
        if (user != null && user.getPerson() != null && user.getLocation() != null)
            workOrderReportService.createReport(list, user.getPerson().getPersonName(), user.getLocation());
        return list;
    }


    /**
     * @return 按照设备分类进行规约
     */
    @RequestMapping(value = "/mapByUnitId", method = RequestMethod.POST)
    @ResponseBody
    public List mapByUnitId(@RequestParam("ids") String ids, HttpSession session) {
        List list = workOrderReportService.mapByUnitId(ids);
        User user = SessionUtil.getCurrentUserBySession(session);
        if (user != null && user.getPerson() != null && user.getLocation() != null)
            workOrderReportService.createReport(list, user.getPerson().getPersonName(), user.getLocation());
        return list;
    }


    @RequestMapping(value = "/findReportHistory/{equipmentId}", method = RequestMethod.GET)
    @ResponseBody
    public List<WorkOrderReportDetail> findReportHistory(@PathVariable("equipmentId") Long equipmentId) {
        List<WorkOrderReportDetail> workOrderReportDetailList = new ArrayList<WorkOrderReportDetail>();
        if (equipmentId != null && equipmentId != 0) {
            workOrderReportDetailList = workOrderReportService.findReportHistoryByEquipmentId(equipmentId);
        }
        return workOrderReportDetailList;
    }
}