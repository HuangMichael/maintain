package com.linkbit.beidou.controller.portal;


import com.linkbit.beidou.service.workOrder.WorkOrderReportCartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

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
    WorkOrderReportCartService workOrderReportCartService;



    @RequestMapping(value = "/index")
    public String index(ModelMap modelMap) {

        return "/portal/index";
    }

    @RequestMapping(value = "/list")
    public String list(ModelMap modelMap) {

        return "/portal/list";
    }


    @RequestMapping(value = "/findTopEqClass/{n}", method = RequestMethod.GET)
    @ResponseBody
    public List<Object> findTopNReportCartByEqClass(@PathVariable("n") Long n) {
        return workOrderReportCartService.findTopNReportCartByEqClass(n);
    }

}

