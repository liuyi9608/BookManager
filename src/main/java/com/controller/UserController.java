package com.controller;


import com.entity.Order;
import com.entity.User;
import com.service.UserService;
import com.util.*;
import net.sf.json.JSONObject;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("user")
public class UserController {

    @Resource
    private UserService userService;
    /**
     * 登录
     *
     * @param user
     * @param request
     * @return
     */
    @RequestMapping("/admin/login")
    public String adminLogin(User user, HttpServletRequest request) {
        User currentUser = userService.getByUserName(user.getUsername());
        if (currentUser != null) {
            if (currentUser.getUserstatus() != 1) {
                request.setAttribute("errorInfo", "用户权限不够不能登陆");
                return "admin/login";
            }
        }
        Subject subject = SecurityUtils.getSubject(); //询当前执行用户
        UsernamePasswordToken token = new UsernamePasswordToken(user.getUsername(), CryptographyUtil.md5(user.getPassword(), "hou123"));
        try {
            subject.login(token);
            return "redirect:/admin/main.jsp";
        } catch (AuthenticationException e) {
            e.printStackTrace();
            request.setAttribute("user", user);
            request.setAttribute("errorInfo", "用户名密码错误");
            return "admin/login";
        }
    }



    /**
     * 判断用户是否存在
     *
     * @param user
     * @return
     */
    @RequestMapping(value = "/isExist", produces = "application/json", method = RequestMethod.POST)
    @ResponseBody
    public String isExist(User user) {
        User currentUser = userService.getByUserName(user.getUsername());
        if (currentUser == null) {
            return "success";
        }
        return "false";

    }

    /**
     * 修改密码
     *
     * @param newPassword
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/modifyPassword")
    public String modifyPassword(String newPassword, HttpServletResponse response) throws Exception {
        User user = new User();
        user.setPassword(CryptographyUtil.md5(newPassword, "hou123"));
        int resultTotal = userService.update(user);
        JSONObject result = new JSONObject();
        if (resultTotal > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
        }
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 退出
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/logout")
    public String adminLogout() throws Exception {
        SecurityUtils.getSubject().logout();
        return "redirect:/admin/login.jsp";
    }

    @RequestMapping("/login")
    public ModelAndView userLogin(User user, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        User currentUser = userService.getByUserName(user.getUsername());
        if (currentUser != null) {
            if (currentUser.getPassword().equals(CryptographyUtil.md5(user.getPassword(), "hou123"))) {
                session.setAttribute("currentUser",currentUser);
                modelAndView.setViewName("index");
                return modelAndView;
            } else {
                session.setAttribute("errorInfo","用户名密码错误");
                modelAndView.setViewName("login");
                return modelAndView;
            }
        } else {
            session.setAttribute("errorInfo","用户名不存在");
            modelAndView.setViewName("login");
            return modelAndView;
        }

    }

    /**
     * 注册
     *
     * @param user
     * @param request
     * @return
     */
    @RequestMapping("/register")
    public String register(User user, HttpServletRequest request) {
        User currentUser = userService.getByUserName(user.getUsername());
        if (currentUser == null) {
            String password = CryptographyUtil.md5(user.getPassword(), "hou123");
            user.setPassword(password);
            int i = userService.addUser(user);
            if (i != 0) {
                return "login";
            }
        }
        request.setAttribute("errorInfo", "用户名重复！");
        return "register";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.removeAttribute("currentUser");
        return "redirect:/toIndex.html";

    }

    @RequestMapping("/usercenter")
    public ModelAndView usercenter(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("usercenter");
        return modelAndView;
    }

    @RequestMapping("/update")
    public String update(User user){
        userService.update(user);
        return "redirect:/usercenter.html";

    }

    @RequestMapping("/orderList")
    public ModelAndView orderList(@RequestParam(value = "page", required = false) String page,
                             HttpServletRequest request,
                                  HttpSession session) throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        if (StringUtil.isEmpty(page)) {
            page = "1";
        }
        User currentUser = (User) session.getAttribute("currentUser");
        PageBean pageBean = new PageBean(Integer.parseInt(page), 12);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("start", pageBean.getStart());
        map.put("size", pageBean.getPageSize());
        map.put("id", currentUser.getId());
        List<Order> orderList = userService.userOrderlist(map);

        modelAndView.addObject("orderList", orderList);
        StringBuffer param = new StringBuffer();
        if(StringUtil.isNotEmpty(String.valueOf(currentUser.getId()))){
            param.append("id="+currentUser.getId()+"&");
        }

        modelAndView.addObject("pageCode", PageUtil.genPagination(request.getContextPath() + "/user/orderList.html", userService.getTotal(map), Integer.parseInt(page), 12, param.toString()));

        modelAndView.setViewName("userorder");
        return modelAndView;
    }

}
