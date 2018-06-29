/*
package com.lym.controller.admin;

import User;
import UserService;
import CryptographyUtil;
import ResponseUtil;
import net.sf.json.JSONObject;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

*/
/**
 * <p>Title AdminController</p>
 *
 * @author YiMing Liu
 * @date 2018/6/22 17:40
 * <p>Description:</p>
 *//*

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Resource
    private UserService userService;


    */
/**
     * 登录
     *
     * @param user
     * @param request
     * @return
     *//*

    @RequestMapping("/login")
    public String login(User user, HttpServletRequest request) {
        User currentUser = userService.getByUserName(user.getUsername());
        if (currentUser != null) {
            if (currentUser.getUserstatus() != 1) {
                request.setAttribute("errorInfo", "用户权限不够不能登陆");
                return "admin/login";
            }
        }
        Subject subject = SecurityUtils.getSubject(); //询当前执行用户
        UsernamePasswordToken token = new UsernamePasswordToken(user.getUsername(), CryptographyUtil.md5(user.getPassword(), "lym123"));
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



    */
/**
     * 判断用户是否存在
     *
     * @param user
     * @return
     *//*

    @RequestMapping(value = "/isExist", produces = "application/json", method = RequestMethod.POST)
    @ResponseBody
    public String isExist(User user) {
        User currentUser = userService.getByUserName(user.getUsername());
        if (currentUser == null) {
            return "success";
        }
        return "false";

    }

    */
/**
     * 修改密码
     *
     * @param newPassword
     * @param response
     * @return
     * @throws Exception
     *//*

    @RequestMapping("/modifyPassword")
    public String modifyPassword(String newPassword, HttpServletResponse response) throws Exception {
        User user = new User();
        user.setPassword(CryptographyUtil.md5(newPassword, "lym123"));
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

    */
/**
     * 退出
     *
     * @return
     * @throws Exception
     *//*

    @RequestMapping("/logout")
    public String logout() throws Exception {
        SecurityUtils.getSubject().logout();
        return "redirect:/admin/login.jsp";
    }
}*/
