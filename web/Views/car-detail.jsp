<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${car.name}</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <style>
            .gradient-bg {
                background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            }
            .card-hover {
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }
            .card-hover:hover {
                transform: translateY(-4px);
                box-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1);
            }
            .feature-icon {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 48px;
                height: 48px;
                background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
                border-radius: 12px;
                margin-right: 12px;
            }
        </style>
    </head>
    <body class="bg-gradient-to-br from-gray-50 to-green-50 min-h-screen">
        <header class="bg-white shadow-md sticky top-0 z-50">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between items-center py-5">
                    <!-- Logo -->
                    <div class="">
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

        <div class="max-w-7xl mx-auto p-6 py-8">

            <div class="bg-white rounded-2xl shadow-lg overflow-hidden mb-8 card-hover">
                <img src="${car.thumbnail}" class="w-full h-[500px] object-cover" alt="${car.name}">
            </div>

            <div class="flex justify-between items-start mb-8">
                <div>
                    <h1 class="text-4xl font-bold text-gray-900 mb-2">${car.name} ${car.model}</h1>
                    <div class="flex items-center text-gray-600">
                        <svg class="w-5 h-5 mr-2 text-green-600" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M5.05 4.05a7 7 0 119.9 9.9L10 18.9l-4.95-4.95a7 7 0 010-9.9zM10 11a2 2 0 100-4 2 2 0 000 4z" clip-rule="evenodd"/>
                        </svg>
                        <span class="font-medium">${car.location}</span>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <div class="lg:col-span-2 space-y-6">
                    <div class="bg-white p-6 rounded-2xl shadow-md card-hover">
                        <h2 class="text-2xl font-bold text-gray-900 mb-6 flex items-center">
                            <span class="w-1 h-8 gradient-bg rounded-full mr-3"></span>
                            Đặc điểm nổi bật
                        </h2>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div class="flex items-center p-4 bg-gradient-to-r from-green-50 to-emerald-50 rounded-xl">
                                <div class="feature-icon">
                                    <span class="text-2xl">🎨</span>
                                </div>
                                <div>
                                    <p class="text-sm text-gray-500">Màu sắc</p>
                                    <p class="font-semibold text-gray-900">${car.color}</p>
                                </div>
                            </div>
                            <div class="flex items-center p-4 bg-gradient-to-r from-green-50 to-emerald-50 rounded-xl">
                                <div class="feature-icon">
                                    <span class="text-2xl">🏷️</span>
                                </div>
                                <div>
                                    <p class="text-sm text-gray-500">Biển số</p>
                                    <p class="font-semibold text-gray-900">${car.registrationNo}</p>
                                </div>
                            </div>
                            <div class="flex items-center p-4 bg-gradient-to-r from-green-50 to-emerald-50 rounded-xl">
                                <div class="feature-icon">
                                    <span class="text-2xl">⚙️</span>
                                </div>
                                <div>
                                    <p class="text-sm text-gray-500">Truyền động</p>
                                    <p class="font-semibold text-gray-900">Số tự động</p>
                                </div>
                            </div>
                            <div class="flex items-center p-4 bg-gradient-to-r from-green-50 to-emerald-50 rounded-xl">
                                <div class="feature-icon">
                                    <span class="text-2xl">⛽</span>
                                </div>
                                <div>
                                    <p class="text-sm text-gray-500">Nhiên liệu</p>
                                    <p class="font-semibold text-gray-900">Xăng</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="bg-white p-6 rounded-2xl shadow-md card-hover">
                        <h2 class="text-2xl font-bold text-gray-900 mb-4 flex items-center">
                            <span class="w-1 h-8 gradient-bg rounded-full mr-3"></span>
                            Mô tả chi tiết
                        </h2>
                        <p class="text-gray-600 leading-relaxed">
                            Xe hiện đại, tiện nghi đầy đủ. Phù hợp thuê đi gia đình hoặc công việc. 
                            Được bảo dưỡng định kỳ, sạch sẽ và an toàn. Chủ xe nhiệt tình, sẵn sàng hỗ trợ 
                            trong suốt quá trình thuê xe.
                        </p>
                    </div>
                </div>

                <div class="lg:col-span-1">
                    <div class="bg-white p-8 rounded-2xl shadow-xl border-2 border-green-100 sticky top-24">
                        <div class="text-center mb-6">
                            <p class="text-sm text-gray-500 mb-2">Giá thuê mỗi ngày</p>
                            <p class="text-5xl font-bold bg-gradient-to-r from-green-600 to-emerald-600 bg-clip-text text-transparent">
                                <fmt:formatNumber value="${car.pricePer}" pattern="#,###"/>đ <span class="text-sm text-gray-500 font-normal">/ngày</span>
                            </p>
                        </div>

                        <div class="space-y-4 mb-6">
                            <div class="flex items-center text-sm text-gray-600">
                                <svg class="w-5 h-5 mr-2 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                Miễn phí giao xe tận nơi
                            </div>
                            <div class="flex items-center text-sm text-gray-600">
                                <svg class="w-5 h-5 mr-2 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                Bảo hiểm toàn diện
                            </div>
                            <div class="flex items-center text-sm text-gray-600">
                                <svg class="w-5 h-5 mr-2 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                Hỗ trợ 24/7
                            </div>
                        </div>

                        <button id="btnRent" class="gradient-bg text-white w-full py-4 rounded-xl text-lg font-bold hover:shadow-2xl transform hover:scale-105 transition-all duration-300 flex items-center justify-center">
                            <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                  d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                            </svg>
                            Đặt xe ngay
                        </button>

                        <p class="text-xs text-center text-gray-500 mt-4">
                            Bạn sẽ không bị trừ tiền ngay lập tức
                        </p>
                    </div>
                </div>
            </div>
        </div>

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
            // User menu dropdown
            $("#userMenuButton").click(function (e) {
                e.stopPropagation();
                $("#userDropdown").toggleClass("hidden");
            });

            $(document).click(function () {
                $("#userDropdown").addClass("hidden");
            });

            // Rent button
            $("#btnRent").click(function () {
                Swal.fire({
                    title: "Đặt xe thành công!",
                    text: "Chúng tôi sẽ liên hệ với bạn sớm nhất.",
                    icon: "success",
                    confirmButtonColor: "#10B981",
                    confirmButtonText: "Đồng ý"
                });
            });

            // Favorite button
            let isFavorite = false;
            $("#btnFavorite").click(function () {
                isFavorite = !isFavorite;
                if (isFavorite) {
                    $(this).addClass("border-red-400 bg-red-50");
                } else {
                    $(this).removeClass("border-red-400 bg-red-50");
                }
            });
        </script>

    </body>
</html>