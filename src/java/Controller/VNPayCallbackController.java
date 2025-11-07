/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.BookingDAO;
import DAOs.PaymentDAO;
import Entities.Payment;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author tuanthanh
 */
@WebServlet(name = "VNPayCallbackController", urlPatterns = {"/payment/callback"})
public class VNPayCallbackController extends HttpServlet {
    
    private PaymentDAO paymentDao = new PaymentDAO();
    private BookingDAO bookingDao = new BookingDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);

        // Validate session và booking ID
        if (session == null || session.getAttribute("bid") == null) {
            request.setAttribute("status", "Lỗi phiên làm việc");
            request.setAttribute("message", "Phiên làm việc đã hết hạn. Vui lòng thử lại!");
            request.getRequestDispatcher("/Views/booking-result.jsp").forward(request, response);
            return;
        }
        
        long bid = (long) session.getAttribute("bid");

        // Lấy các tham số từ VNPAY callback
        Map<String, String> vnpParams = new HashMap<>();
        request.getParameterMap().forEach((key, values) -> {
            if (values.length > 0 && key.startsWith("vnp_")) {
                vnpParams.put(key, values[0]);
            }
        });
        
        String vnp_Amount = request.getParameter("vnp_Amount");
        String vnp_PayDate = request.getParameter("vnp_PayDate");
        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        String vnp_TransactionStatus = request.getParameter("vnp_TransactionStatus");
        String vnp_TxnRef = request.getParameter("vnp_TxnRef");
        String vnp_SecureHash = request.getParameter("vnp_SecureHash");

        // Validate required parameters
        if (vnp_ResponseCode == null || vnp_TransactionStatus == null
                || vnp_TxnRef == null || vnp_SecureHash == null) {
            request.setAttribute("status", "Lỗi dữ liệu");
            request.setAttribute("message", "Dữ liệu thanh toán không hợp lệ!");
            request.getRequestDispatcher("/Views/booking-result.jsp").forward(request, response);
            return;
        }
        
        try {
            // Check duplicate callback - kiểm tra payment đã được xử lý chưa
            Payment existingPayment = paymentDao.getPaymentByBookingId(bid);
            if (existingPayment != null
                    && ("completed".equals(existingPayment.getStatus())
                    || "refunded".equals(existingPayment.getStatus()))) {
                // Payment đã được xử lý rồi, chỉ hiển thị kết quả
                request.setAttribute("status",
                        "completed".equals(existingPayment.getStatus())
                        ? "Thanh toán thành công" : "Thanh toán thất bại");
                request.setAttribute("message",
                        "Giao dịch này đã được xử lý trước đó.");
            } else {
                // Xử lý callback
                processPaymentCallback(request, bid, vnp_ResponseCode, vnp_TransactionStatus,
                        vnp_PayDate, vnp_TxnRef);
            }
            
        } catch (Exception ex) {
            Logger.getLogger(VNPayCallbackController.class.getName())
                    .log(Level.SEVERE, "Error processing VNPAY callback for booking: " + bid, ex);
            request.setAttribute("status", "Lỗi hệ thống");
            request.setAttribute("message", "Có lỗi xảy ra khi xử lý thanh toán. Vui lòng liên hệ hỗ trợ!");
        }
        
        session.removeAttribute("bid");

        // Set attributes để hiển thị
        request.setAttribute("vnp_Amount", vnp_Amount);
        request.setAttribute("vnp_PayDate", vnp_PayDate);
        request.setAttribute("vnp_ResponseCode", vnp_ResponseCode);
        request.setAttribute("vnp_TransactionStatus", vnp_TransactionStatus);
        request.setAttribute("vnp_TxnRef", vnp_TxnRef);
        
        request.getRequestDispatcher("/Views/booking-result.jsp").forward(request, response);
    }
    
    private void processPaymentCallback(HttpServletRequest request, long bid,
            String responseCode, String transactionStatus,
            String payDate, String txnRef) throws Exception {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        LocalDateTime dateTime = LocalDateTime.parse(payDate, formatter);
        Timestamp paidAt = Timestamp.valueOf(dateTime);
        
        if ("00".equals(responseCode) && "00".equals(transactionStatus)) {
            // Thanh toán thành công
            String bStatus = "confirm pending";
            String pStatus = "completed";
            
            paymentDao.updatePaymentStatusByBookingId(bid, pStatus, txnRef, paidAt);
            bookingDao.updateBookingStatus(bid, bStatus);
            
            request.setAttribute("status", "Thanh toán thành công");
            request.setAttribute("message",
                    "Bạn đã đặt thuê xe thành công, vui lòng đợi chủ xe xác nhận đặt xe!");
            
        } else if ("24".equals(responseCode) || "15".equals(responseCode)) {
            // Hủy hoặc hết hạn
            String pStatus = "failed";
            
            paymentDao.updatePaymentStatusByBookingId(bid, pStatus, txnRef, paidAt);
            
            request.setAttribute("status", "Thanh toán thất bại");
            request.setAttribute("message",
                    "Giao dịch bị hủy hoặc hết hạn. Nếu là nhầm lẫn, vui lòng thanh toán lại. "
                    + "Đơn đặt xe sẽ tự động hủy sau 2 giờ!");
            
        } else {
            // Các trường hợp lỗi khác
            String pStatus = "failed";
            
            paymentDao.updatePaymentStatusByBookingId(bid, pStatus, txnRef, paidAt);
            
            request.setAttribute("status", "Thanh toán thất bại");
            request.setAttribute("message",
                    "Giao dịch không thành công (Mã lỗi: " + responseCode + "). "
                    + "Vui lòng thử lại hoặc liên hệ hỗ trợ!");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }
    
}
