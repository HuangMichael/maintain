package com.linkbit.beidou.dao.workOrder;

import com.linkbit.beidou.domain.locations.Locations;
import com.linkbit.beidou.domain.workOrder.WorkOrderReportCart;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * Created by huangbin on 2016/5/20.
 */
public interface WorkOrderReportCartRepository extends CrudRepository<WorkOrderReportCart, Long> {


    String SQL0 = "       SELECT  c.equipments_id,c.order_desc, DATE_FORMAT(c.report_time,'%Y-%m-%d %H:%m:%s '),c.status,'报修车' FROM  t_work_order_report_cart   c";
    String SQL0WHERE = " where c.equipments_id=:equipmentId and c.status <>:status  ";
    String SQL1 = " UNION SELECT  d.equipments_id,d.order_desc, DATE_FORMAT(d.report_time,'%Y-%m-%d %H:%m:%s '),d.status,'报修单' FROM  t_work_order_report_detail d ";
    String SQL1WHERE = " where d.equipments_id=:equipmentId and d.status <>:status ";
    String SQL2 = " UNION SELECT  e.equipments_id,e.order_desc, DATE_FORMAT(e.report_time,'%Y-%m-%d %H:%m:%s '),e.status,'维修单' FROM  t_work_order_fix_detail    e ";
    String SQL2WHERE = " where e.equipments_id=:equipmentId and e.status <>:status ";
    //String ORDERBY = " order by e.equipments_id=:equipmentId and e.status <>:status ";


    String SQL0L = "       SELECT  c.location,c.order_desc, DATE_FORMAT(c.report_time,'%Y-%m-%d %H:%m:%s '),c.status,'报修车' FROM  t_work_order_report_cart   c";
    String SQL0WHEREL = " where c.location like :location and c.status <>:status  ";
    String SQL1L = " UNION SELECT  d.location,d.order_desc, DATE_FORMAT(d.report_time,'%Y-%m-%d %H:%m:%s '),d.status,'报修单' FROM  t_work_order_report_detail d ";
    String SQL1WHEREL = " where d.location like :location and d.status <>:status ";
    String SQL2L = " UNION SELECT  e.location,e.order_desc, DATE_FORMAT(e.report_time,'%Y-%m-%d %H:%m:%s '),e.status,'维修单' FROM  t_work_order_fix_detail    e ";
    String SQL2WHEREL = " where e.location like :location and e.status <>:status ";


    WorkOrderReportCart save(WorkOrderReportCart workOrderReportCart);


    List<WorkOrderReportCart> findAll();


    List<WorkOrderReportCart> findByStatus(String status);

    /**
     * @param id
     * @return 根据id查询
     */
    WorkOrderReportCart findById(Long id);


    /**
     * @param personName
     * @return 查询我的报修车
     */
    @Query("select c from  WorkOrderReportCart c where c.status =1 and c.reporter =:personName")
    List<WorkOrderReportCart> findMyCart(@Param("personName") String personName);


    /**
     * @param locationId
     * @param status     完工状态
     * @return 查询我的报修车
     */
    @Query("select c  from WorkOrderReportCart c where c.locations.id = :locationId and c.equipments.id is null  and c.status <>:status ")
    List<WorkOrderReportCart> findByNocompletedLocations(@Param("locationId") Long locationId, @Param("status") String status);


    /**
     * @param equipmentId 设备id
     * @param status      完工状态
     * @return 查询我的
     */

    @Query("select c  from WorkOrderReportCart c where c.equipments.id = :equipmentId and c.status <>:status ")
    List<WorkOrderReportCart> findByNocompletedEquipments(@Param("equipmentId") Long equipmentId, @Param("status") String status);


    /**
     * @param equipmentId 设备id
     * @param status      完工状态
     * @return 查询已报修未完工的设备信息
     */
    @Query(nativeQuery = true, value = SQL0 + SQL0WHERE + SQL1 + SQL1WHERE + SQL2 + SQL2WHERE)
    List<Object> findReportedEquipments(@Param("equipmentId") Long equipmentId, @Param("status") String status);


    /**
     * @param location 位置编号
     * @param status   完工状态
     * @return 查询已报修未完工的位置信息
     */
    @Query(nativeQuery = true, value = SQL0L + SQL0WHEREL + SQL1L + SQL1WHEREL + SQL2L + SQL2WHEREL)
    List<Object> findReportedLocations(@Param("location") String location, @Param("status") String status);


    /**
     * @param locations 位置信息
     * @param status    状态信息
     * @return
     */
    List<WorkOrderReportCart> findByLocationsAndStatus(Locations locations, String status);


    /**
     * @param location 位置信息
     * @param status   状态信息
     * @return
     */
    List<WorkOrderReportCart> findByLocationStartingWithAndStatus(String location, String status);


}
