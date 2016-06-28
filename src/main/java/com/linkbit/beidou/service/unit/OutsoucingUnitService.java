package com.linkbit.beidou.service.unit;

import com.linkbit.beidou.dao.equipments.EquipmentsClassificationRepository;
import com.linkbit.beidou.dao.outsourcingUnit.OutsourcingUnitRepository;
import com.linkbit.beidou.domain.equipments.Equipments;
import com.linkbit.beidou.domain.equipments.EquipmentsClassification;
import com.linkbit.beidou.domain.outsourcingUnit.OutsourcingUnit;
import com.linkbit.beidou.service.app.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * 外委单位业务类
 */
@Service
public class OutsoucingUnitService extends BaseService {


    //根据设备分类查询对应外委单位
    @Autowired
    OutsourcingUnitRepository outsourcingUnitRepository;


    @Autowired
    EquipmentsClassificationRepository equipmentsClassificationRepository;

    /**
     * @return 查询所有外委单位信息
     */
    public List<OutsourcingUnit> findAll() {
        return outsourcingUnitRepository.findAll();
    }

    /**
     * @return 根据状态查询所有外委单位信息
     */
    public List<OutsourcingUnit> findByStatus(String status) {
        return outsourcingUnitRepository.findByStatus(status);
    }


    /**
     * @param eqClassId
     * @return 根据设备分类的ID查询对应的外委单位信息
     */
    public List<Object> findUnitListByEqClassIdEq(Long eqClassId) {

        return outsourcingUnitRepository.findUnitListByEqClassIdEq(eqClassId);
    }

    /**
     * @param eqClassId
     * @return 根据设备分类查询非该分类对应的外委单位信息 id 描述
     */
    public List<Object> findUnitListByEqClassIdNotEq(Long eqClassId) {
        return outsourcingUnitRepository.findUnitListByEqClassIdNotEq(eqClassId);
    }


    /**
     * @param cid 设备种类id
     * @param ids 外委单位id集合字符串
     * @return 加入外委单位 返回种类本身
     */
    public EquipmentsClassification addUnits(Long cid, String ids) {
        EquipmentsClassification equipmentsClassification = equipmentsClassificationRepository.findById(cid);
        List<OutsourcingUnit> outsourcingUnitSet = new ArrayList<OutsourcingUnit>();
        if (equipmentsClassification != null && ids != null) {
            String idArray[] = ids.split(",");
            for (String id : idArray) {
                outsourcingUnitSet.add(outsourcingUnitRepository.findById(Long.parseLong(id)));
            }
            equipmentsClassification.setUnitSet(outsourcingUnitSet);
            equipmentsClassification = equipmentsClassificationRepository.save(equipmentsClassification);
        }
        return equipmentsClassification;
    }



    /**
     * @param unitCode
     * @return 查询维修历史信息
     */
    public Boolean unitNoExists(String unitCode) {
        List<OutsourcingUnit> equipmentsList = new ArrayList<OutsourcingUnit>();
        if (unitCode != null && !unitCode.equals("")) {
            equipmentsList = outsourcingUnitRepository.findByUnitNo(unitCode);
        }
        return !equipmentsList.isEmpty();
    }
}
