package com.linkbit.beidou.controller.common;


import com.linkbit.beidou.dao.locations.LocationsRepository;
import com.linkbit.beidou.domain.equipments.EquipmentsClassification;
import com.linkbit.beidou.domain.locations.Locations;
import com.linkbit.beidou.service.commonData.CommonDataService;
import com.linkbit.beidou.utils.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by huangbin on 2015/12/23 0023.
 * 创建通用数据的控制器 自动选择数据加载方式
 */
@Controller
@EnableAutoConfiguration
@RequestMapping("/commonData")
public class CommnDataController extends BaseController {
    @Autowired
    CommonDataService commonDataService;

    /**
     * @param httpSession 当前会话
     * @return
     */
    @RequestMapping(value = "/findMyLocation", method = RequestMethod.GET)
    @ResponseBody
    public List<Locations> findMyLocation(HttpSession httpSession) {
        String location = SessionUtil.getCurrentUserLocationBySession(httpSession);
        List<Locations> locationList = null;
        if (location != null && !location.equals("")) {
            locationList = commonDataService.findMyLocation(location, httpSession);
        }
        return locationList;
    }

    /**
     * @param httpSession 当前会话
     * @return 查询分类
     */
    @RequestMapping(value = "/findEqClass", method = RequestMethod.GET)
    @ResponseBody
    public List<EquipmentsClassification> findEquipmentsClassifications(HttpSession httpSession) {
        List<EquipmentsClassification> equipmentsClassificationList = null;
        if (httpSession != null) {
            equipmentsClassificationList = commonDataService.findEquipmentsClassification(httpSession);
        }
        return equipmentsClassificationList;
    }

}

