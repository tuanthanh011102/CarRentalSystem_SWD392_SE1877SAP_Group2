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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author tuanthanh
 */
@WebServlet(name = "CarDetailController", urlPatterns = {"/car-detail"})
public class CarDetailController extends HttpServlet {

    private CarDAO carDao = new CarDAO();
    private OwnerDAO ownerDao = new OwnerDAO();
    private ReviewDAO reviewDao = new ReviewDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int carId = 0;

        try {
            carId = Integer.parseInt(request.getParameter("carId"));
        } catch (NumberFormatException e) {
            response.sendError(404);
            return;
        }

        if (carId < 1) {
            response.sendError(404);
            return;
        }

        Car car;
        Owner owner;
        try {
            car = carDao.getCarById(carId);
        } catch (Exception ex) {
            Logger.getLogger(CarDetailController.class.getName()).log(Level.SEVERE, null, ex);
            response.sendError(500);
            return;
        }

        if (car == null) {
            response.sendError(404);
        }

        try {
            owner = ownerDao.getOwnerById(car.getOwnerId());
        } catch (Exception ex) {
            Logger.getLogger(CarDetailController.class.getName()).log(Level.SEVERE, null, ex);
            response.sendError(500);
            return;
        }

        if (owner == null) {
            response.sendError(404);
        }

        request.setAttribute("owner", owner);
        request.setAttribute("car", car);
        request.getRequestDispatcher("/Views/car-detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
