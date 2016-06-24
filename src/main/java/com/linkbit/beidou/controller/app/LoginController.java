package com.linkbit.beidou.controller.app;

import com.linkbit.beidou.dao.app.org.OrgRepository;
import com.linkbit.beidou.domain.app.org.Org;
import com.linkbit.beidou.domain.equipments.EquipmentsClassification;
import com.linkbit.beidou.domain.line.Line;
import com.linkbit.beidou.domain.line.Station;
import com.linkbit.beidou.domain.locations.Locations;
import com.linkbit.beidou.domain.user.User;
import com.linkbit.beidou.service.equipments.EquipmentAccountService;
import com.linkbit.beidou.service.equipmentsClassification.EquipmentsClassificationService;
import com.linkbit.beidou.service.line.LineService;
import com.linkbit.beidou.service.line.StationService;
import com.linkbit.beidou.service.locations.LocationsService;
import com.linkbit.beidou.service.user.UserService;
import com.linkbit.beidou.utils.CommonStatusType;
import com.linkbit.beidou.utils.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by Administrator on 2016/4/22.
 */
@Controller
@EnableAutoConfiguration
@RequestMapping("/")
public class LoginController {

    @Autowired
    UserService userService;

    @Autowired
    OrgRepository orgRepository;

    @Autowired
    LocationsService locationsService;

    @Autowired
    LineService lineService;

    @Autowired
    StationService stationService;

    @Autowired
    EquipmentsClassificationService equipmentsClassificationService;


    @RequestMapping("/")
    public String logout(HttpServletRequest request, ModelMap modelMap) {
        HttpSession session = request.getSession();
        Org org = orgRepository.findByStatus("1").get(0);

        if (session.getId() != null) {
            request.removeAttribute("currentUser");
            request.removeAttribute("locationsList");
            request.removeAttribute("equipmentsClassificationList");
            request.getSession().invalidate();
        }
        modelMap.put("sysName", org.getSysName());
        return "/index";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String authenticate(@RequestParam("userName") String userName, @RequestParam("password") String password, HttpSession session, ModelMap modelMap) {
        if (userName == null || userName.equals("")) {
            modelMap.put("error", "用户名不能为空！");
        }
        if (password == null || password.equals("")) {
            modelMap.put("error", "密码不能为空！");
        }
        String encryptPassword = MD5Util.md5(password);
        List<User> userList = userService.findByUserNameAndPasswordAndStatus(userName, encryptPassword, "1");
        if (!userList.isEmpty()) {
            User currentUser = userList.get(0);
            List<Line> lineList = lineService.findByStatus("1");
            List<Station> stationList = stationService.findByStatus("1");
            List<Locations> locationsList = locationsService.findByLocationStartingWithAndStatus(currentUser.getLocation(), CommonStatusType.STATUS_YES);
            List<EquipmentsClassification> equipmentsClassificationList = equipmentsClassificationService.findAll();
            session.setAttribute("currentUser", currentUser);
            session.setAttribute("personName", currentUser.getPerson().getPersonName());
            Org org = orgRepository.findByStatus("1").get(0);
            session.setAttribute("org", org);
            session.setAttribute("locationsList", locationsList);
            session.setAttribute("equipmentsClassificationList", equipmentsClassificationList);
            session.setAttribute("lineList", lineList);
            session.setAttribute("stationList", stationList);
            return "redirect:/portal/index";
        } else {
            return "/index";
        }
    }


}