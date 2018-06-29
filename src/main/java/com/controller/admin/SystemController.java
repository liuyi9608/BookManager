package com.controller.admin;

import com.entity.Book;
import com.entity.Category;
import com.service.BookService;
import com.service.CategoryService;
import com.service.OrderService;
import com.util.ResponseUtil;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.support.RequestContextUtils;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/admin/system")
public class SystemController {

    @Resource
    private BookService bookService;
    @Resource
    private CategoryService categoryService;
    @Resource
    private OrderService orderService;

    /**
     * 刷新缓存
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/refreshSystem")
    public String refreshSystem(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ServletContext application = RequestContextUtils.getWebApplicationContext(request).getServletContext();

        Map map = new HashMap();

        List<Book> bookList = bookService.list(map);
        application.setAttribute("bookList", bookList);

        List<Category> categoryList = categoryService.list(map); //
        application.setAttribute("categoryList", categoryList);


        JSONObject result = new JSONObject();
        result.put("success", true);
        ResponseUtil.write(response, result);
        return null;
    }
}
