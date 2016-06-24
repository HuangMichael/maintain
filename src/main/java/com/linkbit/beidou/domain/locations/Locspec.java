package com.linkbit.beidou.domain.locations;


import lombok.*;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by huangbin on 2016/03/17 0023.
 * 位置技术规范表
 */
@Entity
@Table(name = "T_LOC_SPEC")
@Data
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class Locspec implements java.io.Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @Column(length = 30, nullable = false)
    private String location;//位置
    @Column(length = 36)
    private String classId;//分类
    @Column(length = 36)
    private String classAttr; //属性
    @Column(length = 10)
    private Double numValue;//值
    @Column(length = 500)
    private String strValue; //字段
    @Column(length = 8)
    private String unitId; //单位
    @Temporal(TemporalType.DATE)
    private Date changeDate;//修改日期
    @Column(length = 36)
    private String changeBy;//修改人
    @Column(length = 36)
    private String isMustBe;//是否必需
    @Column(length = 200)
    private String remark;//备注

}