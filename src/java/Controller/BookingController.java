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
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.time.temporal.ChronoUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONException;
import org.json.JSONObject;

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
        HttpSession session = request.getSession(false); // Don't create new session

        try {
            if (session == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            User user = (User) session.getAttribute("user");
            if (user == null || user.getUserId() <= 0) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            if (!"customer".equals(user.getRole())) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied. Customer role required.");
                return;
            }

            String bidParam = request.getParameter("bid");
            if (bidParam == null || bidParam.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Booking ID is required");
                return;
            }

            long bid = Long.parseLong(bidParam);

            Booking b = null;

            try {
                b = bookingDao.getBookingById(bid);
            } catch (Exception e) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Booking not found");
                return;
            }

            Customer c = customerDao.getCustomerByCustomerId(b.getCustomerId());
            if (c == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Customer not found");
                return;
            }

            if (c.getUserId() != user.getUserId()) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "You don't have permission to view this booking");
                return;
            }

            Car car = carDao.getCarById(b.getCarId());
            if (car == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Car not found");
                return;
            }

            request.setAttribute("booking", b);
            request.setAttribute("customer", c);
            request.setAttribute("car", car);
            request.getRequestDispatcher("/Views/booking-confirm.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            Logger.getLogger(BookingController.class.getName()).log(Level.WARNING, "Invalid booking ID format", e);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid booking ID format");
        } catch (Exception ex) {
            Logger.getLogger(BookingController.class.getName()).log(Level.SEVERE, "Error loading booking confirmation", ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while loading the booking");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();

        try {
            HttpSession session = request.getSession(false);
            if (session == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Bạn chưa đăng nhập, vui lòng đăng nhập trước khi đặt xe");
                out.print(jsonResponse.toString());
                return;
            }

            User user = (User) session.getAttribute("user");
            if (user == null || user.getUserId() <= 0) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Bạn chưa đăng nhập, vui lòng đăng nhập trước khi đặt xe");
                out.print(jsonResponse.toString());
                return;
            }

            if (!"customer".equals(user.getRole())) {
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Tài khoản admin hoặc chủ xe không được phép thuê xe!");
                out.print(jsonResponse.toString());
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
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Thiếu tham số truyền vào");
                    out.print(jsonResponse.toString());
                    return;
                }

                carId = Long.parseLong(carIdParam);
                rentalDays = Integer.parseInt(rentalDaysParam);
                totalPrice = Float.parseFloat(totalPriceParam);

                if (carId <= 0 || rentalDays <= 0 || totalPrice <= 0) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Tham số truyền vào có giá trị không hợp lệ");
                    out.print(jsonResponse.toString());
                    return;
                }

                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                pickupDate = LocalDate.parse(pickupDateStr, formatter);
                returnDate = LocalDate.parse(returnDateStr, formatter);

            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Tham số truyền vào có giá trị không hợp lệ");
                out.print(jsonResponse.toString());
                return;
            } catch (DateTimeParseException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Ngày thuê xe có định dạng sai, vui lòng định dạng theo: yyyy-MM-dd");
                out.print(jsonResponse.toString());
                return;
            }

            LocalDate today = LocalDate.now();
            if (pickupDate.isBefore(today)) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Ngày thuê không được ở trong quá khứ");
                out.print(jsonResponse.toString());
                return;
            }

            if (returnDate.isBefore(pickupDate) || returnDate.isEqual(pickupDate)) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Ngày trả xe phải ở sau ngày thuê xe");
                out.print(jsonResponse.toString());
                return;
            }

            long actualDays = ChronoUnit.DAYS.between(pickupDate, returnDate);
            if (actualDays != rentalDays) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Rental days mismatch. Expected: " + actualDays + ", Provided: " + rentalDays);
                out.print(jsonResponse.toString());
                return;
            }

            Customer c;
            try {
                c = customerDao.getCustomerByUserId(user.getUserId());
                if (c == null) {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Không tìm thấy profile khách hàng tương ứng với tài khoản đăng nhập");
                    out.print(jsonResponse.toString());
                    return;
                }

                if ((c.getCccdId() == null || c.getCccdId().isEmpty())
                        || (c.getGplx() == null || c.getGplx().isEmpty())) {
                    response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Bạn phải cung cấp đủ CCCD và Giấy Phép Lái Xe trước khi thuê xe!");
                    out.print(jsonResponse.toString());
                    return;
                }
            } catch (Exception ex) {
                Logger.getLogger(BookingController.class.getName()).log(Level.SEVERE,
                        "Error fetching customer", ex);
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Lỗi trong quá trình lấy thông tin khách hàng, vui lòng thử lại sau");
                out.print(jsonResponse.toString());
                return;
            }

            Car car;
            try {
                car = carDao.getCarById(carId);
                if (car == null) {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Không tìm thấy xe");
                    out.print(jsonResponse.toString());
                    return;
                }

                if (!"available".equalsIgnoreCase(car.getStatus())) {
                    response.setStatus(HttpServletResponse.SC_CONFLICT);
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Xe không ở trong trạng thái có thể thuê");
                    out.print(jsonResponse.toString());
                    return;
                }

                boolean isBooked = bookingDao.isCarBookedForDates(carId, pickupDate, returnDate);
                if (isBooked) {
                    response.setStatus(HttpServletResponse.SC_CONFLICT);
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Xe đã được thuê vào ngày này, vui lòng chọn ngày khác");
                    out.print(jsonResponse.toString());
                    return;
                }

                BigDecimal expectedPrice = car.getPricePer()
                        .multiply(BigDecimal.valueOf(rentalDays));
                BigDecimal providedPrice = BigDecimal.valueOf(totalPrice);

                if (providedPrice.subtract(expectedPrice).abs()
                        .compareTo(BigDecimal.valueOf(0.02)) > 0) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Price mismatch. Expected: " + expectedPrice + ", Provided: " + providedPrice);
                    out.print(jsonResponse.toString());
                    return;
                }

            } catch (Exception ex) {
                Logger.getLogger(BookingController.class.getName()).log(Level.SEVERE,
                        "Error fetching car", ex);
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Error retrieving car information");
                out.print(jsonResponse.toString());
                return;
            }

            // Create booking
            Booking b = new Booking();
            b.setCustomerId(c.getCustomerId());
            b.setCarId(carId);
            b.setPrice(totalPrice);
            b.setStartDate(pickupDate);
            b.setReturnDate(returnDate);
            b.setBookingStatus("payment pending");

            try {
                long createdId = bookingDao.createBooking(b);

                // Prepare success response with booking details
                response.setStatus(HttpServletResponse.SC_OK);
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Đặt xe thành công");
                jsonResponse.put("bookingId", createdId);

                JSONObject bookingData = new JSONObject();
                bookingData.put("bookingId", b.getBookingId());
                bookingData.put("customerId", c.getCustomerId());
                bookingData.put("customerName", c.getName());
                bookingData.put("carId", car.getCarId());
                bookingData.put("carName", car.getName());
                bookingData.put("pickupDate", pickupDate.toString());
                bookingData.put("returnDate", returnDate.toString());
                bookingData.put("rentalDays", rentalDays);
                bookingData.put("totalPrice", totalPrice);
                bookingData.put("status", b.getBookingStatus());

                jsonResponse.put("data", bookingData);
                out.print(jsonResponse.toString());

            } catch (Exception ex) {
                Logger.getLogger(BookingController.class.getName()).log(Level.SEVERE,
                        "Error creating booking", ex);
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Error creating booking. Please try again");
                out.print(jsonResponse.toString());
            }

        } catch (JSONException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.put("success", false);
            jsonResponse.put("message", "An unexpected error occurred");
            out.print(jsonResponse.toString());
            Logger.getLogger(BookingController.class.getName()).log(Level.SEVERE, "Unexpected error", e);
        }
    }
}
