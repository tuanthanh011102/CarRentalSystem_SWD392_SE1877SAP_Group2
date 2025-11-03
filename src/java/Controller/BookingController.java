/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.BookingDAO;
import DAOs.CarDAO;
import DAOs.CustomerDAO;
import Entities.Booking;
import Entities.Car;
import Entities.Customer;
import Entities.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.time.temporal.ChronoUnit;
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
    private CarDAO carDao = new CarDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Session expired");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null || user.getUserId() <= 0) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not authenticated");
            return;
        }

        long carId;
        int rentalDays;
        float totalPrice;
        LocalDate pickupDate;
        LocalDate returnDate;

        try {
            String carIdParam = request.getParameter("carId");
            String rentalDaysParam = request.getParameter("rentalDays");
            String totalPriceParam = request.getParameter("totalPrice");
            String pickupDateStr = request.getParameter("pickupDate");
            String returnDateStr = request.getParameter("returnDate");

            if (carIdParam == null || rentalDaysParam == null || totalPriceParam == null
                    || pickupDateStr == null || returnDateStr == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters");
                return;
            }

            carId = Long.parseLong(carIdParam);
            rentalDays = Integer.parseInt(rentalDaysParam);
            totalPrice = Float.parseFloat(totalPriceParam);

            if (carId <= 0 || rentalDays <= 0 || totalPrice <= 0) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameter values");
                return;
            }

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            pickupDate = LocalDate.parse(pickupDateStr, formatter);
            returnDate = LocalDate.parse(returnDateStr, formatter);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format");
            return;
        } catch (DateTimeParseException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid date format. Expected yyyy-MM-dd");
            return;
        }

        LocalDate today = LocalDate.now();
        if (pickupDate.isBefore(today)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Pickup date cannot be in the past");
            return;
        }

        if (returnDate.isBefore(pickupDate) || returnDate.isEqual(pickupDate)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Return date must be after pickup date");
            return;
        }

        long actualDays = ChronoUnit.DAYS.between(pickupDate, returnDate);
        if (actualDays != rentalDays) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Rental days mismatch. Expected: " + actualDays + ", Provided: " + rentalDays);
            return;
        }

        Customer c;
        try {
            c = customerDao.getCustomerByUserId(user.getUserId());
            if (c == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Customer profile not found");
                return;
            }
        } catch (Exception ex) {
            Logger.getLogger(BookingController.class.getName()).log(Level.SEVERE,
                    "Error fetching customer", ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error retrieving customer information");
            return;
        }

        Car car;
        try {
            car = carDao.getCarById(carId);
            if (car == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Car not found");
                return;
            }

            if (!"available".equalsIgnoreCase(car.getStatus())) {
                response.sendError(HttpServletResponse.SC_CONFLICT, "Car is not available for booking");
                return;
            }

            boolean isBooked = bookingDao.isCarBookedForDates(carId, pickupDate, returnDate);
            if (isBooked) {
                response.sendError(HttpServletResponse.SC_CONFLICT,
                        "Car is already booked for the selected dates");
                return;
            }

            // Fix: Validate total price against car's daily rate
            BigDecimal expectedPrice = car.getPricePer()
                    .multiply(BigDecimal.valueOf(rentalDays));
            BigDecimal providedPrice = BigDecimal.valueOf(totalPrice);

            // Allow small rounding differences (e.g., 0.01)
            if (providedPrice.subtract(expectedPrice).abs()
                    .compareTo(BigDecimal.valueOf(0.02)) > 0) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                        "Price mismatch. Expected: " + expectedPrice + ", Provided: " + providedPrice);
                return;
            }

        } catch (Exception ex) {
            Logger.getLogger(BookingController.class.getName()).log(Level.SEVERE,
                    "Error fetching car", ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error retrieving car information");
            return;
        }

        // Create booking
        Booking b = new Booking();
        b.setCustomerId(c.getCustomerId());
        b.setCarId(carId);
        b.setPrice(totalPrice);
        b.setStartDate(pickupDate);
        b.setReturnDate(returnDate);
        b.setBookingStatus("pending");

        try {
            bookingDao.createBooking(b);

            // Optional: Update car status to 'booked' or 'pending'
            // carDao.updateCarStatus(carId, "booked");
        } catch (Exception ex) {
            Logger.getLogger(BookingController.class.getName()).log(Level.SEVERE,
                    "Error creating booking", ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error creating booking. Please try again");
            return;
        }

        request.setAttribute("c", c);
        request.setAttribute("car", car);
        request.setAttribute("b", b);
        request.getRequestDispatcher("/Views/booking-confirm.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
