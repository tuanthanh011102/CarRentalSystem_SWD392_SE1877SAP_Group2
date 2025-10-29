/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.BookingDAO;
import DAOs.CustomerDAO;
import Entities.Booking;
import Entities.Customer;
import Entities.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author tuanthanh
 */
@WebServlet(name = "BookingController", urlPatterns = {"/booking"})
public class BookingController extends HttpServlet {

    private BookingDAO bookingDao = new BookingDAO();
    private CustomerDAO customerDao = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Views/booking-confirm.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession(false).getAttribute("user");

        int carId = Integer.parseInt(request.getParameter("carId"));
        int rentalDays = Integer.parseInt(request.getParameter("rentalDays"));
        float totalPrice = Float.parseFloat(request.getParameter("totalPrice"));
        String pickupDateStr = request.getParameter("pickupDate");
        String returnDateStr = request.getParameter("returnDate");

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        LocalDateTime pickupDate = LocalDateTime.parse(pickupDateStr, formatter);
        LocalDateTime returnDate = LocalDateTime.parse(returnDateStr, formatter);

        Customer c;
        try {
            c = customerDao.getCustomerByUserId(user.getUserId());
        } catch (Exception ex) {
            Logger.getLogger(BookingController.class.getName()).log(Level.SEVERE, null, ex);
            response.sendError(500);
            return;
        }

        Booking b = new Booking();
        b.setCustomerId(c.getCustomerId());
    }

}
