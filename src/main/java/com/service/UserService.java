package com.service;

import com.entity.Order;
import com.entity.User;

import java.util.List;
import java.util.Map;


public interface UserService {

    /**
     * 根据用户名查询用户信息
     *
     * @param username
     * @return
     */
    User getByUserName(String username);

    /**
     * 添加用户
     *
     * @param user
     */
    int addUser(User user);

    /**
     * 更新用户
     * @param user
     * @return
     */
    int update(User user);

    /**
     * 查询用户的订单
     * @param map
     * @return
     */
    List<Order> userOrderlist(Map<String, Object> map);

    /**
     * 订单总记录数
     *
     * @param map
     * @return
     */
    Long getTotal(Map<String, Object> map);
}
