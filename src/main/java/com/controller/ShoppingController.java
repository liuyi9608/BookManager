package com.controller;

import com.entity.*;
import com.service.BookService;
import com.service.OrderItemService;
import com.service.OrderService;
import com.util.IDUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.LinkedList;
import java.util.List;



@Controller
@RequestMapping("/shopping")
public class ShoppingController {

    @Resource
    private BookService bookService;

    @Resource
    private OrderService orderService;

    @Resource
    private OrderItemService orderItemService;

    @RequestMapping("/cart")
    @ResponseBody
    public String addShoppingCartItem(@RequestParam("bookid") int bookid,
                                      HttpSession session,
                                      HttpServletResponse response) throws Exception {
        Book book = bookService.findById(bookid);

        ShoppingCart shoppingCart = (ShoppingCart) session.getAttribute("shoppingCart");
        if (shoppingCart == null) {
            shoppingCart = new ShoppingCart();
            User currentUser = (User) session.getAttribute("currentUser");
            shoppingCart.setUserid(currentUser.getId());
        }

        List<ShoppingCartItem> shoppingCartItemList = shoppingCart.getShoppingCartItems();

        boolean flag = true;
        for (ShoppingCartItem shoppingCartItem : shoppingCartItemList) {
            if (shoppingCartItem.getBook().getId() == book.getId()) {
                shoppingCartItem.setCount(shoppingCartItem.getCount() + 1);
                flag = false;
                break;
            }
        }

        ShoppingCartItem shoppingCartItem = new ShoppingCartItem();

        if (flag) {
            shoppingCartItem.setBook(book);
            shoppingCartItem.setCount(1);
            shoppingCartItemList.add(shoppingCartItem);
        }

        session.setAttribute("shoppingCart", shoppingCart);
        session.setAttribute("shoppingCartItemList", shoppingCartItemList);
        String result = "success";
        return result;
    }

    @RequestMapping("/list")
    public ModelAndView list() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("cart");
        return modelAndView;
    }

    @RequestMapping("/updateShoppingCartItem")
    @ResponseBody
    public String updateShoppingCartItem(@RequestParam("bookId") int bookId,
                                         @RequestParam("count") int count,
                                         HttpSession session) throws Exception {
        Book book = bookService.findById(bookId);
        ShoppingCart shoppingCart = (ShoppingCart) session.getAttribute("shoppingCart");
        List<ShoppingCartItem> shoppingCartItemList = shoppingCart.getShoppingCartItems();
        for (ShoppingCartItem scI : shoppingCartItemList) {
            if (scI.getBook().getId() == book.getId()) {
                scI.setCount(count);
                break;
            }
        }

        session.setAttribute("shoppingCart", shoppingCart);

        String result = "success";
        return result;
    }

    @RequestMapping("/removeShoppingCartItem")
    @ResponseBody
    public String removeShoppingCartItem(@RequestParam("bookId") int bookId,
                                         HttpSession session) throws Exception {
        ShoppingCart shoppingCart = (ShoppingCart) session.getAttribute("shoppingCart");
        List<ShoppingCartItem> shoppingCartItemList = shoppingCart.getShoppingCartItems();
        for (int i = 0; i < shoppingCartItemList.size(); i++) {
            if (bookId == shoppingCartItemList.get(i).getBook().getId()) {
                shoppingCartItemList.remove(i);
                break;
            }
        }
        shoppingCart.setShoppingCartItems(shoppingCartItemList);
        session.setAttribute("shoppingCart", shoppingCart);
        String result = "success";
        return result;

    }

    @RequestMapping("/buy")
    public ModelAndView buy(HttpSession session, @RequestParam("receiverAddress") String receiverAddress,
                            @RequestParam("receiverName") String receiverName,
                            @RequestParam("receiverPhone") String receiverPhone) {
        ModelAndView modelAndView = new ModelAndView();
        Order order = new Order();
        User currentUser = (User) session.getAttribute("currentUser");
        order.setUser(currentUser);
        order.setOrderNo(String.valueOf(IDUtils.genItemId()));
        order.setOrderstatus("待发货");
        if (receiverAddress != null && receiverAddress!="") {
            order.setReceiverAddress(receiverAddress);
        } else {
            order.setReceiverAddress(currentUser.getAddress());
        }
        if (receiverName != null && receiverName!="") {

            order.setReceiverName(receiverName);
        } else {
            order.setReceiverName(currentUser.getUsername());
        }
        if (receiverPhone != null && receiverPhone!="") {
            order.setReceiverPhone(receiverPhone);
        } else {
            order.setReceiverPhone(currentUser.getTel());
        }
        orderService.save(order);
        ShoppingCart shoppingCart = (ShoppingCart) session.getAttribute("shoppingCart");
        List<ShoppingCartItem> shoppingCartItemList = shoppingCart.getShoppingCartItems();

        double cost = 0.0;
        List<OrderItem> orderItemList = new LinkedList<OrderItem>();
        for (ShoppingCartItem shoppingCartItem : shoppingCartItemList) {
            Book book = shoppingCartItem.getBook();
            OrderItem orderItem = new OrderItem();
            orderItem.setBuynum(shoppingCartItem.getCount());
            orderItem.setOrder(order);
            orderItem.setBook(book);
            orderItemService.saveOrderItem(orderItem);
            cost += book.getPrice() * shoppingCartItem.getCount();
            orderItemList.add(orderItem);
        }
        order.setTotalprices(cost);

        orderService.updateOrder(order);
        modelAndView.setViewName("success");
        session.removeAttribute("shoppingCart");
        session.removeAttribute("shoppingCartItemList");
        return modelAndView;
    }

}
