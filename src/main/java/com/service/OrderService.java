package com.service;

import com.entity.Order;

import java.util.List;
import java.util.Map;


public interface OrderService {
    /**
     * 查询所有订单信息
     *
     * @param map
     * @return
     */
    List<Order> list(Map<String, Object> map);


    /**
     * 订单总记录数
     *
     * @param map
     * @return
     */
    Long getTotal(Map<String, Object> map);

    /**
     * 根据id删除订单
     *
     * @param id
     * @return
     */
    Integer delete(Integer id);

    /**
     * 根据ID查询订单信息
     *
     * @param id
     * @return
     */
    Order findById(Integer id);

    /**
     * 保存订单
     * @param order
     */
    void save(Order order);

    /**
     * 更新订单
     * @param order
     */
    void updateOrder(Order order);
}
