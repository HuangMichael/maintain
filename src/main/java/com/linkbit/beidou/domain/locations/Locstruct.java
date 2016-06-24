package com.linkbit.beidou.domain.locations;


import lombok.*;

import javax.persistence.*;

/**
 * Created by huangbin on 2016/03/17 0023.
 * 位置技术规范表
 */
@Entity
@Table(name = "T_LOC_STRUCT")
@Data
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class Locstruct implements java.io.Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @Column(length = 1)
    private String addChild; //标示是否将子集也同时添加到所选系统
    @Column(length =36)
    private String classId;//位置分类
    @Column(length =18)
    private String craft;//专业
    @Column(length =18)
    private String deptNum;//所属部门
    @Column(length =100)
    private String description;//位置描述
    @Column(length =18,nullable = false)
    private String hasChild;//类型
    @Column(length =18,nullable = false)
    private String location;//位置编码
    @Column(length =22)
    private Long orderBy;//排序
    @Column(length =18)
    private String parent;//父级位置
    @Column(length =18,nullable = false)
    private String systemId;//所属系统ID
    @Column(length =18)
    private String type;//类型

}