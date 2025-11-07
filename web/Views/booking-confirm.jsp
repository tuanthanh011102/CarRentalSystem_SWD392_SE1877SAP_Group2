<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Xác Nhận Đặt Xe - CRS</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <style>
            .gradient-bg {
                background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            }

            .hero-bg {
                background: linear-gradient(135deg, rgba(16, 185, 129, 0.1) 0%, rgba(5, 150, 105, 0.1) 100%);
            }

            .info-card {
                transition: all 0.3s ease;
                border: 2px solid transparent;
            }

            .info-card:hover {
                border-color: #10b981;
                box-shadow: 0 10px 25px -5px rgba(16, 185, 129, 0.2);
            }

            .success-icon {
                animation: scaleIn 0.5s ease-out;
            }

            @keyframes scaleIn {
                0% {
                    transform: scale(0);
                    opacity: 0;
                }
                50% {
                    transform: scale(1.1);
                }
                100% {
                    transform: scale(1);
                    opacity: 1;
                }
            }

            .status-badge {
                background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                box-shadow: 0 4px 6px -1px rgba(16, 185, 129, 0.4);
            }

            .detail-row {
                border-bottom: 1px solid #f3f4f6;
                padding: 1rem 0;
            }

            .detail-row:last-child {
                border-bottom: none;
            }
        </style>
    </head>
    <body class="bg-gradient-to-br from-gray-50 to-green-50">
        <header class="bg-white shadow-md sticky top-0 z-50">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between items-center py-2">
                    <div>
                        <a href="homepage" class="flex items-center space-x-2">
                            <div class="w-10 h-10 gradient-bg rounded-lg flex items-center justify-center">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                      d="M13 10V3L4 14h7v7l9-11h-7z"/>
                                </svg>
                            </div>
                            <span class="text-2xl font-bold bg-gradient-to-r from-green-600 to-emerald-600 bg-clip-text text-transparent">CRS</span>
                        </a>
                    </div>

                    <nav class="hidden md:flex items-center space-x-6">
                        <c:if test="${empty user}">
                            <a href="register" class="text-gray-600 hover:text-green-600 font-medium transition-colors">Đăng ký</a>
                            <a href="login" class="px-6 py-2.5 gradient-bg rounded-lg text-white font-semibold hover:shadow-lg transition-all duration-300">
                                Đăng nhập
                            </a>
                        </c:if>
                        <c:if test="${not empty user}">
                            <div class="relative" id="userMenu">
                                <button id="userMenuButton" 
                                        class="flex items-center space-x-2 px-4 py-2 rounded-lg text-gray-700 hover:bg-green-50 hover:text-green-600 transition-all focus:outline-none">
                                    <div class="w-8 h-8 gradient-bg rounded-full flex items-center justify-center text-white font-semibold">
                                        ${fn:substring(user.name, 0, 1)}
                                    </div>
                                    <span class="font-medium">${user.name}</span>
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                                    </svg>
                                </button>

                                <div id="userDropdown" 
                                     class="hidden absolute right-0 mt-2 w-56 bg-white rounded-xl shadow-xl border border-gray-100 overflow-hidden z-50">
                                    <a href="profile" 
                                       class="flex items-center px-4 py-3 text-gray-700 hover:bg-green-50 hover:text-green-600 transition-colors">
                                        <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                              d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                                        </svg>
                                        Trang cá nhân
                                    </a>
                                    <form action="logout" method="POST">
                                        <button type="submit" 
                                                class="w-full flex items-center px-4 py-3 text-red-600 hover:bg-red-50 transition-colors">
                                            <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                  d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
                                            </svg>
                                            Đăng xuất
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:if>
                    </nav>
                </div>
            </div>
        </header>

        <section class="hero-bg py-12">
            <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                <div class="success-icon inline-flex items-center justify-center w-20 h-20 bg-green-100 rounded-full mb-6">
                    <svg class="w-10 h-10 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                    </svg>
                </div>
                <h1 class="text-4xl md:text-5xl font-bold text-gray-900 mb-4">
                    Đặt Giữ Chỗ Thành Công!
                </h1>
                <p class="text-xl text-gray-600 mb-2">
                    Cảm ơn bạn đã tin tưởng và sử dụng dịch vụ của CRS, Giữ chỗ sẽ có hạn trong vòng 2 tiếng, vui lòng thanh toán để xác nhận thuê xe!
                </p>
                <p class="text-lg text-gray-500">
                    Mã đặt xe của bạn: <span class="font-bold text-green-600">#${booking.bookingId}</span>
                </p>
            </div>
        </section>

        <section class="py-12">
            <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="grid md:grid-cols-2 gap-8">
                    <!-- Customer Information -->
                    <div class="info-card bg-white rounded-2xl shadow-lg p-8">
                        <div class="flex items-center mb-6">
                            <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center mr-4">
                                <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                      d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                                </svg>
                            </div>
                            <h2 class="text-2xl font-bold text-gray-900">Thông Tin Khách Hàng</h2>
                        </div>

                        <div class="space-y-4">
                            <div class="detail-row">
                                <p class="text-sm text-gray-500 mb-1">Họ và tên</p>
                                <p class="text-lg font-semibold text-gray-900">${customer.name}</p>
                            </div>
                            <div class="detail-row">
                                <p class="text-sm text-gray-500 mb-1">Số điện thoại</p>
                                <p class="text-lg font-semibold text-gray-900">${customer.phone}</p>
                            </div>
                            <div class="detail-row">
                                <p class="text-sm text-gray-500 mb-1">Email</p>
                                <p class="text-lg font-semibold text-gray-900">${customer.email}</p>
                            </div>
                            <div class="detail-row">
                                <p class="text-sm text-gray-500 mb-1">CCCD/CMND</p>
                                <p class="text-lg font-semibold text-gray-900">${customer.cccdId}</p>
                            </div>
                            <div class="detail-row">
                                <p class="text-sm text-gray-500 mb-1">Địa chỉ</p>
                                <p class="text-lg font-semibold text-gray-900">${customer.address}</p>
                            </div>
                        </div>
                    </div>

                    <div class="info-card bg-white rounded-2xl shadow-lg p-8">
                        <div class="flex items-center mb-6">
                            <div class="w-12 h-12 bg-purple-100 rounded-xl flex items-center justify-center mr-4">
                                <svg class="w-6 h-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                      d="M13 10V3L4 14h7v7l9-11h-7z"/>
                                </svg>
                            </div>
                            <h2 class="text-2xl font-bold text-gray-900">Thông Tin Xe</h2>
                        </div>

                        <c:if test="${not empty car.thumbnail}">
                            <div class="mb-6 rounded-xl overflow-hidden">
                                <img src="${car.thumbnail}" alt="${car.name}" class="w-full h-48 object-cover">
                            </div>
                        </c:if>

                        <div class="space-y-4">
                            <div class="detail-row">
                                <p class="text-sm text-gray-500 mb-1">Tên xe</p>
                                <p class="text-lg font-semibold text-gray-900">${car.name}</p>
                            </div>
                            <div class="detail-row">
                                <p class="text-sm text-gray-500 mb-1">Dòng xe</p>
                                <p class="text-lg font-semibold text-gray-900">${car.model}</p>
                            </div>
                            <div class="detail-row">
                                <p class="text-sm text-gray-500 mb-1">Biển số</p>
                                <p class="text-lg font-semibold text-gray-900">${car.registrationNo}</p>
                            </div>
                            <div class="detail-row">
                                <p class="text-sm text-gray-500 mb-1">Màu sắc</p>
                                <p class="text-lg font-semibold text-gray-900">${car.color}</p>
                            </div>
                            <div class="detail-row">
                                <p class="text-sm text-gray-500 mb-1">Địa điểm</p>
                                <p class="text-lg font-semibold text-gray-900">${car.location}</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mt-8 bg-white rounded-2xl shadow-lg p-8">
                    <div class="flex items-center mb-6">
                        <div class="w-12 h-12 bg-green-100 rounded-xl flex items-center justify-center mr-4">
                            <svg class="w-6 h-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                  d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                            </svg>
                        </div>
                        <h2 class="text-2xl font-bold text-gray-900">Chi Tiết Đặt Xe</h2>
                    </div>

                    <div class="grid md:grid-cols-2 gap-8">
                        <div class="space-y-4">
                            <div class="detail-row">
                                <p class="text-sm text-gray-500 mb-1">Mã đặt xe</p>
                                <p class="text-lg font-bold text-green-600">#${booking.bookingId}</p>
                            </div>
                            <div class="detail-row">
                                <p class="text-sm text-gray-500 mb-1">Ngày bắt đầu</p>
                                <p class="text-lg font-semibold text-gray-900">
                                    ${booking.startDate}
                                </p>
                            </div>
                            <div class="detail-row">
                                <p class="text-sm text-gray-500 mb-1">Ngày trả xe</p>
                                <p class="text-lg font-semibold text-gray-900">
                                    ${booking.returnDate}
                                </p>
                            </div>
                        </div>

                        <div class="space-y-4">
                            <div class="detail-row">
                                <p class="text-sm text-gray-500 mb-1">Trạng thái</p>
                                <span class="inline-block status-badge text-white text-sm font-bold px-4 py-2 rounded-full">
                                    ${booking.bookingStatus}
                                </span>
                            </div>
                            <div class="detail-row">
                                <p class="text-sm text-gray-500 mb-1">Giá thuê/ngày</p>
                                <p class="text-lg font-semibold text-gray-900">
                                    <fmt:formatNumber value="${car.pricePer}" pattern="#,###"/>đ
                                </p>
                            </div>
                            <div class="detail-row bg-green-50 rounded-xl p-4 -m-4">
                                <p class="text-sm text-gray-500 mb-1">Tổng tiền</p>
                                <p class="text-3xl font-bold text-green-600">
                                    <fmt:formatNumber value="${booking.price}" pattern="#,###"/>đ
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mt-8 flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="homepage" 
                       class="flex items-center justify-center px-8 py-4 bg-white border-2 border-gray-300 hover:border-green-500 hover:bg-green-50 rounded-xl text-gray-800 font-semibold transition-all">
                        Về trang chủ
                    </a>
                    <c:if test="${booking.bookingStatus == 'payment pending'}">
                        <form action="${pageContext.request.contextPath}/payment/request" method="POST">
                            <button type="submit" class="flex items-center justify-center px-8 py-4 gradient-bg hover:shadow-2xl text-white font-bold rounded-xl transition-all transform hover:scale-105">
                                Thanh Toán
                            </button>
                            <input type="hidden" name="bid" value="${booking.bookingId}" />
                        </form>
                    </c:if>
                </div>

                <div class="mt-8 bg-yellow-50 border-l-4 border-yellow-400 p-6 rounded-lg">
                    <div class="flex">
                        <div class="flex-shrink-0">
                            <svg class="h-6 w-6 text-yellow-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
                            </svg>
                        </div>
                        <div class="ml-3">
                            <h3 class="text-lg font-semibold text-yellow-800 mb-2">Lưu ý quan trọng</h3>
                            <ul class="list-disc list-inside text-yellow-700 space-y-1">
                                <li>Vui lòng mang theo CCCD/CMND và bằng lái xe khi nhận xe</li>
                                <li>Liên hệ chủ xe trước 24h nếu muốn hủy hoặc thay đổi lịch</li>
                                <li>Kiểm tra kỹ xe trước khi nhận và trước khi trả</li>
                                <li>Giữ gìn xe sạch sẽ và trả xe đúng giờ</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <footer class="bg-gray-900 text-white py-12 mt-16">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center">
                    <div class="flex items-center justify-center mb-6">
                        <div class="w-12 h-12 gradient-bg rounded-xl flex items-center justify-center">
                            <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                  d="M13 10V3L4 14h7v7l9-11h-7z"/>
                            </svg>
                        </div>
                        <span class="ml-3 text-3xl font-bold">CRS</span>
                    </div>
                    <p class="text-gray-400 mb-4">Nền tảng cho thuê xe tự lái hàng đầu Việt Nam</p>
                    <p class="text-gray-500 text-sm">&copy; 2025 CRS. Tất cả quyền được bảo lưu.</p>
                </div>
            </div>
        </footer>

        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            $(document).ready(function () {
                const $menuButton = $('#userMenuButton');
                const $dropdown = $('#userDropdown');

                $menuButton.on('click', function (e) {
                    e.stopPropagation();
                    $dropdown.toggleClass('hidden');
                });

                $(document).on('click', function () {
                    $dropdown.addClass('hidden');
                });
            });
        </script>
    </body>
</html>