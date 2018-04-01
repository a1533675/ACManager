package com.zzkun.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.time.LocalDateTime;

/**
 * Created by kun on 2016/8/9.
 */
@Entity
@Table(name = "bc_user_info")
public class BCUserInfo {

    @Id
    private String bcname;

    private Integer rating;

    private LocalDateTime updateTime;

    public BCUserInfo() {
    }

    public BCUserInfo(String bcname, Integer rating) {
        this.bcname = bcname;
        this.rating = rating;
        updateTime = LocalDateTime.now();
    }

    public String getBcname() {
        return bcname;
    }

    public void setBcname(String bcname) {
        this.bcname = bcname;
    }

    public Integer getRating() {
        return rating;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
        updateTime = LocalDateTime.now();
    }

    @Override
    public String toString() {
        return "BCUserInfo{" +
                "bcname='" + bcname + '\'' +
                ", rating=" + rating +
                ", updateTime=" + updateTime +
                '}';
    }
}
