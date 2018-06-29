package com.service;

import com.entity.OrderItem;

public interface OrderItemService {

    /**
     * 保存订单项
     * @param orderItem
     */
    void saveOrderItem(OrderItem orderItem);
}
