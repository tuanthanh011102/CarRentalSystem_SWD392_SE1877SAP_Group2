/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.CarDAO;
import DAOs.OwnerDAO;
import DAOs.ReviewDAO;
import Entities.Car;
import Entities.Owner;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author tuanthanh
 */
@WebServlet(name = "HomepageController", urlPatterns = {"/homepage"})
public class HomepageController extends HttpServlet {

    private OwnerDAO ownerDao = new OwnerDAO();
    private CarDAO carDao = new CarDAO();
    private ReviewDAO reviewDao = new ReviewDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String message = "";
        List<Owner> oList = new ArrayList<>();
        List<Car> cList = new ArrayList<>();
        
        String pageParam = request.getParameter("page");
        int page = 1;
        int pageSize = 10;
        
        if (pageParam != null && !pageParam.trim().isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        String searchKey = request.getParameter("searchKey");
        String color = request.getParameter("color");
        String priceOrder = request.getParameter("priceOrder");
        
        if (searchKey != null) {
            searchKey = searchKey.trim();
            if (searchKey.isEmpty()) {
                searchKey = null;
            }
        }
        
        if (color != null) {
            color = color.trim();
            if (color.isEmpty()) {
                color = null;
            }
        }
        
        if (priceOrder != null) {
            priceOrder = priceOrder.trim().toUpperCase();
            if (!priceOrder.equals("ASC") && !priceOrder.equals("DESC")) {
                priceOrder = null;
            }
        }
        
        try {
            cList = carDao.getAllCar(
                page, 
                pageSize, 
                searchKey != null ? searchKey : "", 
                color != null ? color : "", 
                priceOrder != null ? priceOrder : ""
            );
            
            oList = ownerDao.getAllOwner(1, 999999999, "");
            
            request.setAttribute("carList", cList);
            request.setAttribute("ownerList", oList);
            request.setAttribute("currentPage", page);
            request.setAttribute("pageSize", pageSize);
            
            request.setAttribute("searchKey", searchKey);
            request.setAttribute("color", color);
            request.setAttribute("priceOrder", priceOrder);
            
            boolean hasMorePages = cList.size() == pageSize;
            request.setAttribute("hasMorePages", hasMorePages);
            
        } catch (Exception e) {
            message = "Có lỗi xảy ra khi tải dữ liệu: " + e.getMessage();
            request.setAttribute("message", message);
            e.printStackTrace();
        }
        
        request.getRequestDispatcher("/Views/homepage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }
}