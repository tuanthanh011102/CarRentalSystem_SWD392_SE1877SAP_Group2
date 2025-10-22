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

        try {
            cList = carDao.getAllCar(1, 10, "", "", "");
            oList = ownerDao.getAllOwner(1, 999999999, "");
        } catch (Exception e) {
            message = e.getMessage();

            request.setAttribute("message", message);
            request.getRequestDispatcher("/Views/homepage.jsp").forward(request, response);
            return;
        }

        request.setAttribute("carList", cList);
        request.setAttribute("ownerList", oList);
        request.getRequestDispatcher("/Views/homepage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
