<%-- 
    Document   : homepage
    Created on : Oct 22, 2025, 1:56:14 PM
    Author     : tuanthanh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CRS - Thuê Xe Tự Lái</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <style>
            .hero-bg {
                background: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)),
                    url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 600"><rect fill="%23334155" width="1200" height="600"/></svg>');
                background-size: cover;
                background-position: center;
            }
            .tab-active {
                background-color: #10b981;
                color: white;
            }
            .tab-inactive {
                background-color: white;
                color: #6b7280;
            }
            .car-card {
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }
            .car-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            }
        </style>
    </head>
    <body class="bg-gray-50">
        <!-- Header -->
        <header class="bg-white shadow-sm">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between items-center py-4">
                    <!-- Logo -->
                    <div class="flex items-center">
                        <span class="ml-2 text-2xl font-bold text-gray-900">CRS</span>
                    </div>

                    <!-- Navigation -->
                    <nav class="hidden md:flex items-center space-x-8">
                        <c:if test="${empty user}">
                            <a href="register" class="text-gray-700 hover:text-emerald-500">Đăng ký</a>
                            <a href="login" class="px-6 py-2 border-2 border-gray-900 rounded-lg text-gray-900 hover:bg-gray-900 hover:text-white transition">
                                Đăng nhập
                            </a>
                        </c:if>
                        <c:if test="${not empty user}">
                            <div class="relative" id="userMenu">
                                <button id="userMenuButton" 
                                        class="flex items-center space-x-2 text-gray-700 hover:text-emerald-600 focus:outline-none">
                                    <span>${user.name}</span>
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M19 9l-7 7-7-7"/>
                                    </svg>
                                </button>

                                <!-- Dropdown -->
                                <div id="userDropdown" 
                                     class="hidden absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg border border-gray-100 z-50">
                                    <a href="profile" 
                                       class="block px-4 py-2 text-gray-700 hover:bg-gray-100 transition">
                                        Trang cá nhân
                                    </a>
                                    <form action="logout" method="POST">
                                        <button type="submit" 
                                                class="w-full text-left px-4 py-2 text-gray-700 hover:bg-gray-100 transition">
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

        <!-- Hero Section -->
        <section class="hero-bg relative min-h-[600px] flex items-center justify-center">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 w-full">
                <div class="text-center mb-12">
                    <h1 class="text-5xl md:text-6xl font-bold text-white mb-6">
                        CRS - Cùng Bạn Trên<br/>Mọi Hành Trình
                    </h1>
                    <p class="text-xl text-white">
                        Trải nghiệm sự khác biệt với xe gia đình đời mới khắp Việt Nam
                    </p>
                </div>

                <div class="bg-white rounded-2xl shadow-2xl p-8 max-w-5xl mx-auto">
                    <!-- Tabs -->
                    <div class="flex flex-wrap gap-2 mb-8">
                        <button onclick="setActiveTab('self-drive')" id="tab-self-drive" class="tab-active flex items-center px-6 py-3 rounded-lg font-medium transition">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4"/>
                            </svg>
                            Xe tự lái
                        </button>
                    </div>

                    <form action="${pageContext.request.contextPath}/homepage" method="GET">
                        <div class="grid md:grid-cols-12 gap-4 items-end">
                            <!-- Location -->
                            <div class="md:col-span-4">
                                <label class="block text-sm font-medium text-gray-700 mb-2">
                                    <svg class="w-4 h-4 inline mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/>
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/>
                                    </svg>
                                    Địa điểm
                                </label>
                                <select name="searchKey" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-emerald-500 focus:border-transparent">
                                    <option value="">Tất cả địa điểm</option>
                                    <option value="TP. Hồ Chí Minh" ${param.searchKey == 'TP. Hồ Chí Minh' ? 'selected' : ''}>TP. Hồ Chí Minh</option>
                                    <option value="Hà Nội" ${param.searchKey == 'Hà Nội' ? 'selected' : ''}>Hà Nội</option>
                                    <option value="Đà Nẵng" ${param.searchKey == 'Đà Nẵng' ? 'selected' : ''}>Đà Nẵng</option>
                                    <option value="Cần Thơ" ${param.searchKey == 'Cần Thơ' ? 'selected' : ''}>Cần Thơ</option>
                                </select>
                            </div>

                            <div class="md:col-span-3">
                                <label class="block text-sm font-medium text-gray-700 mb-2">
                                    <svg class="w-4 h-4 inline mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17h.01"/>
                                    </svg>
                                    Màu xe
                                </label>
                                <select name="color" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-emerald-500 focus:border-transparent">
                                    <option value="">Tất cả màu</option>
                                    <option value="Trắng" ${param.color == 'Trắng' ? 'selected' : ''}>Trắng</option>
                                    <option value="Đen" ${param.color == 'Đen' ? 'selected' : ''}>Đen</option>
                                    <option value="Xám" ${param.color == 'Xám' ? 'selected' : ''}>Xám</option>
                                    <option value="Đỏ" ${param.color == 'Đỏ' ? 'selected' : ''}>Đỏ</option>
                                    <option value="Xanh" ${param.color == 'Xanh' ? 'selected' : ''}>Xanh</option>
                                </select>
                            </div>

                            <!-- Price Order -->
                            <div class="md:col-span-3">
                                <label class="block text-sm font-medium text-gray-700 mb-2">
                                    <svg class="w-4 h-4 inline mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 4h13M3 8h9m-9 4h6m4 0l4-4m0 0l4 4m-4-4v12"/>
                                    </svg>
                                    Sắp xếp giá
                                </label>
                                <select name="priceOrder" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-emerald-500 focus:border-transparent">
                                    <option value="">Mặc định</option>
                                    <option value="ASC" ${param.priceOrder == 'ASC' ? 'selected' : ''}>Giá tăng dần</option>
                                    <option value="DESC" ${param.priceOrder == 'DESC' ? 'selected' : ''}>Giá giảm dần</option>
                                </select>
                            </div>

                            <!-- Search Button -->
                            <div class="md:col-span-2">
                                <button type="submit" class="w-full bg-emerald-500 hover:bg-emerald-600 text-white font-semibold py-3 px-6 rounded-lg transition shadow-lg">
                                    Tìm Xe
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </section>

        <!-- Cars Section -->
        <section class="py-16 bg-gray-50">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="mb-8">
                    <h2 class="text-3xl font-bold text-gray-900 mb-2">Xe Dành Cho Bạn</h2>
                    <p class="text-gray-600">Khám phá những chiếc xe tốt nhất trong khu vực của bạn</p>
                </div>

                <c:if test="${not empty message}">
                    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6">
                        ${message}
                    </div>
                </c:if>

                <c:choose>
                    <c:when test="${empty carList}">
                        <div class="text-center py-16">
                            <svg class="mx-auto h-24 w-24 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                  d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            <h3 class="mt-4 text-xl font-medium text-gray-900">Không tìm thấy xe nào</h3>
                            <p class="mt-2 text-gray-600">Vui lòng thử lại với tiêu chí tìm kiếm khác</p>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                            <c:forEach var="car" items="${carList}">
                                <div class="car-card bg-white rounded-xl shadow-md overflow-hidden cursor-pointer">
                                    <div class="relative h-48 bg-gray-200">
                                        <c:choose>
                                            <c:when test="${not empty car.thumbnail}">
                                                <img src="${car.thumbnail}" alt="${car.name}" class="w-full h-full object-cover">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="w-full h-full flex items-center justify-center bg-gray-300">
                                                    <svg class="w-16 h-16 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                          d="M5 8h14M5 8a2 2 0 110-4h14a2 2 0 110 4M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4"/>
                                                    </svg>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="absolute top-3 right-3">
                                            <span class="bg-emerald-500 text-white text-xs font-semibold px-3 py-1 rounded-full">
                                                ${car.status}
                                            </span>
                                        </div>
                                    </div>

                                    <div class="p-5">
                                        <h3 class="text-lg font-bold text-gray-900 mb-1 truncate">${car.name}</h3>
                                        <p class="text-sm text-gray-600 mb-3">${car.model}</p>

                                        <div class="space-y-2 mb-4">
                                            <div class="flex items-center text-sm text-gray-600">
                                                <svg class="w-4 h-4 mr-2 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                      d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/>
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                      d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/>
                                                </svg>
                                                <span class="truncate">${car.location}</span>
                                            </div>
                                            <div class="flex items-center text-sm text-gray-600">
                                                <svg class="w-4 h-4 mr-2 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                      d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17h.01"/>
                                                </svg>
                                                <span>${car.color}</span>
                                            </div>
                                            <div class="flex items-center text-sm text-gray-600">
                                                <svg class="w-4 h-4 mr-2 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                      d="M15 5v2m0 4v2m0 4v2M5 5a2 2 0 00-2 2v3a2 2 0 110 4v3a2 2 0 002 2h14a2 2 0 002-2v-3a2 2 0 110-4V7a2 2 0 00-2-2H5z"/>
                                                </svg>
                                                <span>${car.registrationNo}</span>
                                            </div>
                                        </div>

                                        <div class="border-t pt-4 grid items-center gap-5">
                                            <div>
                                                <span class="text-2xl font-bold text-emerald-600">
                                                    <fmt:formatNumber value="${car.pricePer}" pattern="#,###"/>đ
                                                </span>
                                                <span class="text-sm text-gray-500">/ngày</span>
                                            </div>
                                            <div class="flex gap-2 justify-center w-full">
                                                <button onclick="viewCarDetail(${car.carId})"
                                                        class="w-full bg-yellow-500 hover:bg-yellow-600 text-white px-4 py-2 rounded-lg text-sm font-semibold transition">
                                                    Chi tiết
                                                </button>
                                                <button onclick="viewCarDetail(${car.carId})"
                                                        class="w-full bg-emerald-500 hover:bg-emerald-600 text-white px-4 py-2 rounded-lg text-sm font-semibold transition">
                                                    Thuê xe
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Pagination -->
                        <div class="flex justify-center items-center mt-10 gap-4">
                            <c:if test="${currentPage > 1}">
                                <a href="${pageContext.request.contextPath}/homepage?page=${currentPage - 1}&searchKey=${param.searchKey}&color=${param.color}&priceOrder=${param.priceOrder}"
                                   class="px-4 py-2 bg-gray-200 hover:bg-gray-300 rounded-lg text-gray-800 font-medium transition">
                                    Trang trước
                                </a>
                            </c:if>

                            <span class="text-gray-700 font-semibold">Trang ${currentPage}</span>

                            <c:if test="${hasMorePages}">
                                <a href="${pageContext.request.contextPath}/homepage?page=${currentPage + 1}&searchKey=${param.searchKey}&color=${param.color}&priceOrder=${param.priceOrder}"
                                   class="px-4 py-2 bg-emerald-500 hover:bg-emerald-600 rounded-lg text-white font-medium transition">
                                    Trang tiếp
                                </a>
                            </c:if>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <!-- Footer -->
        <footer class="bg-gray-900 text-white py-12">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center">
                    <div class="flex items-center justify-center mb-4">
                        <svg class="w-10 h-10 text-emerald-500" viewBox="0 0 50 50" fill="currentColor">
                        <path d="M10 15 L25 5 L40 15 L40 35 L25 45 L10 35 Z" stroke="currentColor" stroke-width="2" fill="none"/>
                        <path d="M18 25 L25 20 L32 25 L32 35 L25 40 L18 35 Z"/>
                        </svg>
                        <span class="ml-2 text-2xl font-bold">MIOTO</span>
                    </div>
                    <p class="text-gray-400">&copy; 2025 Mioto. Tất cả quyền được bảo lưu.</p>
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

                                                    function setActiveTab(tabName) {
                                                        document.querySelectorAll('[id^="tab-"]').forEach(tab => {
                                                            tab.className = 'tab-inactive flex items-center px-6 py-3 rounded-lg font-medium transition';
                                                        });
                                                        document.getElementById('tab-' + tabName).className = 'tab-active flex items-center px-6 py-3 rounded-lg font-medium transition';
                                                    }

                                                    function viewCarDetail(carId) {
                                                        window.location.href = '${pageContext.request.contextPath}/car-detail?carId=' + carId;
                                                    }
        </script>
    </body>
</html>