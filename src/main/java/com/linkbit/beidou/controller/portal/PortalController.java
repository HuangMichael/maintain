package com.linkbit.beidou.controller.portal;


import com.linkbit.beidou.dao.workOrder.WorkOrderRepository;
import com.linkbit.beidou.domain.workOrder.WorkOrder;
import com.linkbit.beidou.service.workOrder.WorkOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by huangbin on 2015/12/23 0023.
 */
@Controller
@EnableAutoConfiguration
@RequestMapping("/portal")
@SessionAttributes("menuList")
public class PortalController {

    @Autowired
    WorkOrderService workOrderService;
    @Autowired
    WorkOrderRepository workOrderRepository;

    List<WorkOrder> workOrderList0 = new ArrayList<WorkOrder>();
    List<WorkOrder> workOrderList2 = new ArrayList<WorkOrder>();


    @RequestMapping(value = "/index")
    public String index(ModelMap modelMap) {
        workOrderList0 = workOrderRepository.findByStatus("0");//新报修的工单;
        workOrderList2 = workOrderRepository.findByStatus("2");//完成的工单
        modelMap.put("workOrderList0", workOrderList0);
        modelMap.put("workOrderList2", workOrderList2);
        return "/portal/index";
    }

    @RequestMapping(value = "/list")
    public String list(ModelMap modelMap) {
        workOrderList0 = workOrderRepository.findByStatus("0");//新报修的工单;
        workOrderList2 = workOrderRepository.findByStatus("2");//完成的工单
        modelMap.put("workOrderList0", workOrderList0);
        modelMap.put("workOrderList2", workOrderList2);
        return "/portal/list";
    }
}

