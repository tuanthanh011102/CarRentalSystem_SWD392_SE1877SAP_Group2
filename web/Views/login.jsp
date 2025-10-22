<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Đăng nhập - Car Rental</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

        <style>
            body {
                background: linear-gradient(to right, #e0f2fe, #f0fdfa);
            }
        </style>
    </head>
    <body class="flex items-center justify-center h-screen">
        <!-- Card container -->
        <div class="bg-white shadow-lg rounded-2xl w-full max-w-md p-8">
            <h1 class="text-3xl font-bold text-center text-emerald-600 mb-6">Đăng nhập</h1>

            <!-- Login form -->
            <form id="loginForm" action="login" method="post" class="space-y-5">
                <div>
                    <label class="block font-semibold text-gray-700 mb-2">Email</label>
                    <input type="email" name="email" required
                           class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-emerald-400 focus:outline-none"
                           placeholder="example@gmail.com">
                </div>

                <div>
                    <label class="block font-semibold text-gray-700 mb-2">Mật khẩu</label>
                    <input type="password" name="password" required
                           class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-emerald-400 focus:outline-none"
                           placeholder="••••••••">
                    <p class="text-xs text-gray-500 mt-1">
                        Mật khẩu phải có ít nhất 8 ký tự, gồm chữ hoa, số và ký tự đặc biệt.
                    </p>
                </div>

                <div class="flex items-center justify-between">
                    <label class="flex items-center">
                        <input type="checkbox" name="remember" class="text-emerald-600 focus:ring-emerald-500">
                        <span class="ml-2 text-sm text-gray-600">Ghi nhớ đăng nhập</span>
                    </label>
                    <a href="#" class="text-sm text-emerald-600 hover:underline">Quên mật khẩu?</a>
                </div>

                <button type="submit"
                        class="w-full bg-emerald-500 hover:bg-emerald-600 text-white font-semibold py-2 rounded-lg transition">
                    Đăng nhập
                </button>
            </form>

            <div class="mt-6 text-center text-sm text-gray-600">
                Chưa có tài khoản?
                <a href="register.jsp" class="text-emerald-600 hover:underline">Đăng ký ngay</a>
            </div>
        </div>

        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
            $(document).ready(function () {
                $('#loginForm').on('submit', function (e) {
                    e.preventDefault();

                    const email = $('input[name="email"]').val().trim();
                    const password = $('input[name="password"]').val().trim();

                    const emailRegex = /^[^@\s]+@[^@\s]+\.[^@\s]+$/;
                    const passwordRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]).{8,}$/;

                    if (!emailRegex.test(email)) {
                        Toastify({
                            text: "Email không hợp lệ!",
                            backgroundColor: "#ef4444",
                            duration: 3000
                        }).showToast();
                        return;
                    }

                    if (!passwordRegex.test(password)) {
                        Toastify({
                            text: "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, số và ký tự đặc biệt!",
                            backgroundColor: "#ef4444",
                            duration: 4000
                        }).showToast();
                        return;
                    }

                    $.post('login', {email, password}, function (response) {
                        if (response.success) {
                            Toastify({
                                text: "Đăng nhập thành công!",
                                backgroundColor: "green",
                                duration: 1000
                            }).showToast();

                            setTimeout(() => {
                                window.location.href = 'homepage';
                            }, 1000);
                        } else {
                            Toastify({
                                text: "Đăng nhập thất bại! Sai email hoặc mật khẩu, vui lòng thử lại.",
                                backgroundColor: "#ef4444",
                                duration: 4000
                            }).showToast();
                        }
                    }).fail(() => {
                        Toastify({
                            text: "Lỗi máy chủ! Không thể kết nối đến máy chủ.",
                            backgroundColor: "#ef4444",
                            duration: 4000
                        }).showToast();
                    }
                    );
                });
            });
        </script>
    </body>
</html>
