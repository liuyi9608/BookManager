package com.controller;

import com.entity.Book;
import com.service.BookService;
import com.util.PageBean;
import com.util.PageUtil;
import com.util.StringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/book")
public class BookController {

    @Resource
    private BookService bookService;

    @RequestMapping("/list")
    public ModelAndView list(@RequestParam(value = "page", required = false) String page,
                              Book s_book,
                              @RequestParam(value = "categoryid",required = false) String categoryid,
                              HttpServletRequest request) throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        if (StringUtil.isEmpty(page)) {
            page = "1";
        }
        if(StringUtil.isEmpty(categoryid)){
            categoryid = null;
        }

        PageBean pageBean = new PageBean(Integer.parseInt(page), 12);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("start", pageBean.getStart());
        map.put("size", pageBean.getPageSize());
        map.put("bookname", StringUtil.formatLike(s_book.getBookname()));
        map.put("category_id", categoryid);
        List<Book> bookList = bookService.list(map);

        modelAndView.addObject("bookList", bookList);
        StringBuffer param = new StringBuffer();
        if(StringUtil.isNotEmpty(categoryid)){
            param.append("categoryid="+categoryid+"&");
        }
        if(StringUtil.isNotEmpty(s_book.getBookname())){
            param.append("bookname="+s_book.getBookname());
        }
        modelAndView.addObject("pageCode", PageUtil.genPagination(request.getContextPath() + "/book/list.html", bookService.getTotal(map), Integer.parseInt(page), 12, param.toString()));
        modelAndView.addObject("bookTotal", bookService.getTotal(map));
        modelAndView.setViewName("booklist");
        return modelAndView;
    }

    @RequestMapping("/detail")
    public ModelAndView bookDetail(@RequestParam("bookid") Integer bookid, HttpServletRequest request) throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        Book currentBook = bookService.findById(bookid);
        Map<String, Object> map = new HashMap<String, Object>();
        modelAndView.addObject("currentBook", currentBook);
        modelAndView.setViewName("bookDetail");
        return modelAndView;
    }



}
