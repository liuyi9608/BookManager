package com.dao;

import com.entity.OrderItem;

public interface OrderItemDao {

    /**
     * 保存订单项
     * @param orderItem
     */
    void saveOrderItem(OrderItem orderItem);

}
