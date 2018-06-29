package com.controller.admin;

import com.entity.Book;
import com.service.BookService;
import com.util.*;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.*;



@Controller
@RequestMapping("/admin/book")
public class BookAdminController {

    @Resource
    private BookService bookService;

    /**
     * 图书列表
     *
     * @param page
     * @param rows
     * @param s_book
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/list")
    public String list(@RequestParam(value = "page", required = false) String page,
                       @RequestParam(value = "rows", required = false) String rows,
                       Book s_book,
                       HttpServletResponse response) throws Exception {
        PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("bookname", StringUtil.formatLike(s_book.getBookname()));
        map.put("start", pageBean.getStart());
        map.put("size", pageBean.getPageSize());
        List<Book> bookList = bookService.list(map);
        Long total = bookService.getTotal(map);
        JSONObject result = new JSONObject();
        JsonConfig jsonConfig = new JsonConfig();
        jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
        JSONArray jsonArray = JSONArray.fromObject(bookList, jsonConfig);
        result.put("rows", jsonArray);
        result.put("total", total);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 删除图书信息
     *
     * @param ids
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/delete")
    public String delete(@RequestParam(value = "ids", required = false) String ids, HttpServletResponse response) throws Exception {
        String[] id = ids.split(",");
        for (int i = 0; i < id.length; i++) {
            bookService.delete(Integer.parseInt(id[i]));
        }
        org.json.JSONObject result = new org.json.JSONObject();
        result.put("success", true);
        ResponseUtil.write(response, result);
        return null;

    }

    /**
     * 保存或更新图书信息
     *
     * @param book
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/save")
    public String save(Book book, HttpServletResponse response, MultipartFile uploadFile, HttpSession session) throws Exception {
        String imageName = uploadFile.getOriginalFilename();
        if(imageName!="") {
            ServletContext sc = session.getServletContext();
            String bookDir = sc.getRealPath("/static/bookImages");

            String prefix = imageName.substring(imageName.lastIndexOf("."));
            String newImageName = IDUtils.genImageName() + prefix;

            System.out.println(bookDir);

            File file = new File(bookDir + "\\" + newImageName);
            uploadFile.transferTo(file);
            book.setImage(newImageName);
        }

        int resultTotal = 0;
        System.out.println(book.getImage());
        org.json.JSONObject result = new org.json.JSONObject();
        if (book.getId() == null) {
            resultTotal = bookService.save(book);
        } else {
            if (imageName==null){
                book.setImage(book.getImage());
            }
            resultTotal = bookService.update(book);
        }
        if (resultTotal > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
        }
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 通过id查询图书信息
     *
     * @param id
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/findById")
    public String findById(@RequestParam(value = "id") String id, HttpServletResponse response) throws Exception {
        Book book = bookService.findById(Integer.parseInt(id));
        JSONObject result = JSONObject.fromObject(book);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 信息导出
     * @param map
     * @return
     * @throws Exception
     */
    @RequestMapping("/export")
    public ModelAndView export(ModelMap map) throws Exception{
        List<Map<String,String>> list = bookService.selectAllBookInfo();
        String[] titles={"编号","书名","作者","单价","类型","创建时间"};
        ViewExcel excel=new ViewExcel(titles);
        map.put("excelList", list);
        return new ModelAndView(excel,map);
    }

}
