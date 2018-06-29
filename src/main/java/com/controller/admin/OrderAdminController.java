package com.controller.admin;

import com.entity.Book;
import com.entity.Order;
import com.entity.OrderItem;
import com.service.OrderService;
import com.util.DateJsonValueProcessor;
import com.util.PageBean;
import com.util.ResponseUtil;
import com.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/admin/order")
public class OrderAdminController {

    @Resource
    private OrderService orderService;

    /**
     * 订单列表显示
     * @param page
     * @param rows
     * @param s_order
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/list")
    public String list(@RequestParam(value = "page", required = false) String page,
                       @RequestParam(value = "rows", required = false) String rows,
                       Order s_order,
                       HttpServletResponse response) throws Exception {
        PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("start", pageBean.getStart());
        map.put("size", pageBean.getPageSize());
        map.put("orderNo", StringUtil.formatLike(s_order.getOrderNo()));
        List<Order> orderList = orderService.list(map);
        Long total = orderService.getTotal(map);
        JSONObject result = new JSONObject();
        JsonConfig jsonConfig = new JsonConfig();
        jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
        JSONArray jsonArray = JSONArray.fromObject(orderList, jsonConfig);
        result.put("rows", jsonArray);
        result.put("total", total);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 删除订单
     * @param ids
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/delete")
    public String delete(@RequestParam(value = "ids", required = false) String ids, HttpServletResponse response) throws Exception {
        String[] idsStr = ids.split(",");
        JSONObject result = new JSONObject();

        for (int i = 0; i < idsStr.length; i++) {
            Integer flag = orderService.delete(Integer.parseInt(idsStr[i]));
            if (flag == null) {
                result.put("exist", "订单未完成或者失效，不能删除！");
            }
        }
        result.put("success", true);
        ResponseUtil.write(response, result);
        return null;
    }

    @RequestMapping("/findOrderById")
    public String findOrderById(@RequestParam(value = "id") String id, HttpServletResponse response) throws Exception{
        if(StringUtil.isEmpty(id)){
            return null;
        }
        Order order=orderService.findById(Integer.parseInt(id));
        List<OrderItem> orderItemList = order.getOrderItemList();
        JSONObject result=new JSONObject();
        JSONArray rows=new JSONArray();
        for(OrderItem orderItem:orderItemList){
            Book book = orderItem.getBook();
            JSONObject jsonObject=new JSONObject();
            jsonObject.put("bookname", book.getBookname());
            jsonObject.put("image", book.getImage());
            jsonObject.put("price", book.getPrice());
            jsonObject.put("num", orderItem.getBuynum());
            rows.add(jsonObject);
        }
        result.put("rows", rows);
        result.put("total", rows.size());
        ResponseUtil.write(response, result);
        return null;
    }

}
