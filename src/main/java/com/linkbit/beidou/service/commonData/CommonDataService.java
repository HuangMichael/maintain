package com.linkbit.beidou.service.commonData;

import com.linkbit.beidou.dao.equipments.EquipmentsClassificationRepository;
import com.linkbit.beidou.dao.locations.LocationsRepository;
import com.linkbit.beidou.domain.equipments.EquipmentsClassification;
import com.linkbit.beidou.domain.locations.Locations;
import com.linkbit.beidou.service.app.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by huangbin on 2016/3/24.
 */
@Service
public class CommonDataService extends BaseService {

    @Autowired
    LocationsRepository locationsRepository;
    @Autowired
    EquipmentsClassificationRepository equipmentsClassificationRepository;

    /**
     * @param location 位置编号
     * @return 查询我的下属位置信息
     * 先从session中找  如果失败再做查询
     */
    public List<Locations> findMyLocation(String location, HttpSession httpSession) {
        List<Locations> locationsList = null;
        Object object = httpSession.getAttribute("locationsList");
        if (object != null) {
            locationsList = (ArrayList<Locations>) object;
            log.info(this.getClass().getCanonicalName() + "------------从缓存中查询位置信息");
        } else {
            if (location != null && !location.equals("")) {
                locationsList = locationsRepository.findByLocationStartingWith(location);
                log.info(this.getClass().getCanonicalName() + "------------从缓存中查询位置信息");
            }
        }
        return locationsList;
    }


    /**
     * @param httpSession
     * @return 查询设备种类信息
     */
    public List<EquipmentsClassification> findEquipmentsClassification(HttpSession httpSession) {
        List<EquipmentsClassification> equipmentsClassificationList = null;
        Object object = httpSession.getAttribute("equipmentsClassificationList");
        if (object != null) {
            equipmentsClassificationList = (ArrayList<EquipmentsClassification>) object;
            log.info(this.getClass().getCanonicalName() + "------------从缓存中查询设备种类");

        } else {
            equipmentsClassificationList = equipmentsClassificationRepository.findByStatus("1");
            log.info(this.getClass().getCanonicalName() + "------------从数据库中查询设备种类");
            httpSession.setAttribute("equipmentsClassificationList", equipmentsClassificationList);
            log.info(this.getClass().getCanonicalName() + "------------设备种类放入缓存");
        }
        return equipmentsClassificationList;


    }


}
