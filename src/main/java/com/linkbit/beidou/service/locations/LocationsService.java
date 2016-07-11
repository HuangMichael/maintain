package com.linkbit.beidou.service.locations;

import com.linkbit.beidou.dao.locations.LocationsRepository;
import com.linkbit.beidou.dao.locations.VlocationsRepository;
import com.linkbit.beidou.domain.locations.Locations;
import com.linkbit.beidou.domain.locations.Vlocations;
import com.linkbit.beidou.service.app.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by huangbin on 2016/3/24.
 */
@Service
public class LocationsService extends BaseService {


    @Autowired
    LocationsRepository locationsRepository;

    @Autowired
    VlocationsRepository vlocationsRepository;


    /**
     * 设置位置编码
     */
    public String getLocationsNo(Locations locations) {
        List<Locations> locationsList = locationsRepository.findByParent(locations.getId());
        String locationNo = String.format("%02d", locationsList.size() + 1);
        if (locations.getLocation() != null) {
            locationNo = locations.getLocation() + locationNo;
        }
        return locationNo;
    }

    /**
     * @param locations 保存位置信息
     * @return
     */
    public Locations save(Locations locations) {
        Locations newLocation = locationsRepository.save(locations);
        return newLocation;
    }

    public List<Locations> findAll() {
        return locationsRepository.findAll();
    }


    /**
     * @param location 位置编号
     * @return 当前用户分配的所有位置节点
     */
    public List<Object> findTree(String location) {
        List<Object> objectList = null;

        if (location != null && !location.equals("")) {
            objectList = locationsRepository.findTree(location);
        }
        return objectList;
    }


    /**
     * @param locLevel 节点级别
     * @return 查询节点级别小于locLevel的记录
     */
    public List<Locations> findByLocLevelLessThan(Long locLevel) {
        return locationsRepository.findByLocLevelLessThan(locLevel);
    }

    /**
     * @param id 根据ID查询位置
     * @return
     */
    public Locations findById(Long id) {
        return locationsRepository.findById(id);
    }

    /**
     * @param location
     * @return
     */
    public List<Locations> findByLocation(String location) {
        return locationsRepository.findByLocation(location);
    }


    /**
     * @param id 根据ID查询位置
     * @return
     */
    public List<Locations> findByParentId(Long id) {
        Locations locations = locationsRepository.findById(id);
        return locationsRepository.findByParent(id);
    }

    /**
     * @param
     * @return
     */
    public Boolean delete(Locations locations) {
        boolean hasChild = !locationsRepository.findByParent(locations.getId()).isEmpty();
        if (hasChild) {
            return false;
        } else {
            locationsRepository.delete(locations);
            return true;
        }
    }


    /**
     * 新建位置
     *
     * @param parentId 上级位置
     * @return 如果有上级根据上级生成对象  如果没有将其当做根节点
     */
    public Locations create(Long parentId) {
        log.info("根据父节点创建新节点------------------" + parentId);
        Locations newObj = new Locations();
        if (parentId != null) {
            Locations parent = locationsRepository.findById(parentId);
            newObj.setLocation(getLocationsNo(parent));  //编号不自动生成
            newObj.setLine(parent.getLine());
            newObj.setStation(parent.getStation());
            newObj.setParent(parent.getId());
            Long level = 0l;
            if (parent.getLocLevel() != null) {
                level = parent.getLocLevel();
            }
            newObj.setLocLevel(level + 1);
        } else {
            newObj.setLocation("01");
        }
        return newObj;

    }


    /**
     * @param location
     * @return 根据位置编码模糊查询
     */
    public List<Locations> findByLocationStartingWithAndStatus(String location, String status) {

        return locationsRepository.findByLocationStartingWithAndStatus(location, status);
    }


    /**
     * @param location
     * @return 根据位置编码模糊查询
     */
    public List<Vlocations> findByLocationStartingWithAndStatus(String location) {

        return vlocationsRepository.findByLocationStartingWith(location);
    }
}

