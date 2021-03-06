// Generated via dto.ftl
package com.example.server.dto;

import lombok.Data;

@Data
public class TeacherDto {
    /**
     * id
     */
    private String id;
    /**
     * 姓名
     */
    private String name;
    /**
     * 昵称
     */
    private String nickname;
    /**
     * 头像
     */
    private String image;
    /**
     * 职位
     */
    private String position;
    /**
     * 座右铭
     */
    private String motto;
    /**
     * 简介
     */
    private String intro;
}