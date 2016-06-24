package com.linkbit.beidou.domain.workOrder;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.linkbit.beidou.domain.equipments.Equipments;
import com.linkbit.beidou.domain.equipments.EquipmentsClassification;
import com.linkbit.beidou.domain.line.Line;
import com.linkbit.beidou.domain.line.Station;
import com.linkbit.beidou.domain.locations.Locations;
import lombok.*;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "T_WORK_ORDER")
@Data
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
/**
 * 工单信息
 * */
public class WorkOrder {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
    @Column(length = 20, unique = true, nullable = false)
    private String orderNo; //工单编号
    @Column(length = 200)
    private String orderDesc; //工单描述
    @Column(length = 20)
    private String reporter; //报告人
    @Temporal(TemporalType.TIMESTAMP)
    private Date reportTime; //报告时间
    @Column(length = 15)
    private long sortNo;

    @Column(length='1')
    private String status;
    @Column(length = 20)
    private String location; //加入location字段方便统计
    @JsonManagedReference
    @ManyToOne(optional = true, fetch = FetchType.LAZY)
    @JoinColumn(name = "locations_id", referencedColumnName = "id")
    Locations locations;
    @Column(length = 15)
    private String reportTelephone; //报修电话
    @OneToOne
    @JoinColumn(name = "equip_class_id")
    private EquipmentsClassification equipmentsClassification; //设备分类

    @OneToOne
    @JoinColumn(name = "workOrderMaintenance_id")
    private WorkOrderMaintenance workOrderMaintenance; //设备分类


    @OneToOne
    @JoinColumn(name = "equipments_id")
    private Equipments equipment; //设备编号


    @ManyToOne(optional = true, fetch = FetchType.LAZY)
    @JoinColumn(name = "line_id", referencedColumnName = "id")
    Line line; //线路

    @ManyToOne(optional = true, fetch = FetchType.LAZY)
    @JoinColumn(name = "station_id", referencedColumnName = "id")
    Station station; //车站


}
