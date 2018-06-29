package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class PageController {


    @RequestMapping("toIndex")
    public String toIndex() {
        return "index";
    }

    @RequestMapping("booklist")
    public String booklist(){
        return "booklist";
    }

    @RequestMapping("toLogin")
    public String toLogin() {
        return "login";
    }

    @RequestMapping("toRegister")
    public String toRegister() {
        return "register";
    }
}
