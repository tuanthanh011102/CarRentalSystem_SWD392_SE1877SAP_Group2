/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.UserDAO;
import Entities.User;
import Utils.Utils;
import com.google.gson.Gson;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    private final UserDAO userDao = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Map<String, Object> result = new HashMap<>();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            User user = userDao.getUserByEmail(email);

            if (user == null) {
                result.put("success", false);
                result.put("message", "Email không tồn tại!");
            } else {
                String hashedRequestPassword = Utils.hash(password);

                if (user.getPasswordHash().equals(hashedRequestPassword)) {
                    request.getSession().setAttribute("user", user);
                    result.put("success", true);
                    result.put("message", "Đăng nhập thành công!");
                } else {
                    result.put("success", false);
                    result.put("message", "Sai mật khẩu!");
                }
            }

        } catch (Exception ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
            result.put("success", false);
            result.put("message", "Lỗi máy chủ: " + ex.getMessage());
        }

        response.getWriter().write(new Gson().toJson(result));
    }
}
