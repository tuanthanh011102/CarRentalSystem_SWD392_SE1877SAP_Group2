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
                background: linear-gradient(135deg, rgba(16, 185, 129, 0.95) 0%, rgba(5, 150, 105, 0.95) 100%),
                    url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 600"><rect fill="%23059669" width="1200" height="600"/><circle cx="100" cy="100" r="50" fill="%2310b981" opacity="0.1"/><circle cx="800" cy="400" r="80" fill="%2310b981" opacity="0.1"/><circle cx="1000" cy="150" r="60" fill="%2310b981" opacity="0.1"/></svg>');
                background-size: cover;
                background-position: center;
                position: relative;
            }

            .hero-bg::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="1" fill="white" opacity="0.3"/></svg>');
                background-size: 50px 50px;
                animation: stars 20s linear infinite;
            }

            @keyframes stars {
                from {
                    background-position: 0 0;
                }
                to {
                    background-position: 50px 50px;
                }
            }

            .tab-active {
                background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                color: white;
                box-shadow: 0 4px 6px -1px rgba(16, 185, 129, 0.3);
            }

            .tab-inactive {
                background-color: #f3f4f6;
                color: #6b7280;
            }

            .car-card {
                transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                border: 2px solid transparent;
            }

            .car-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 25px 50px -12px rgba(16, 185, 129, 0.25);
                border-color: #10b981;
            }

            .gradient-bg {
                background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            }

            .search-box {
                backdrop-filter: blur(10px);
                background: rgba(255, 255, 255, 0.95);
            }

            .feature-badge {
                background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
            }

            .price-tag {
                background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .animate-float {
                animation: float 3s ease-in-out infinite;
            }

            @keyframes float {
                0%, 100% {
                    transform: translateY(0px);
                }
                50% {
                    transform: translateY(-10px);
                }
            }

            .status-badge {
                background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                box-shadow: 0 4px 6px -1px rgba(16, 185, 129, 0.4);
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

        <section class="hero-bg relative min-h-[650px] flex items-center justify-center overflow-hidden">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 w-full relative z-10">
                <div class="text-center mb-12 animate-float">
                    <h1 class="text-5xl md:text-7xl font-bold text-white mb-6 drop-shadow-lg">
                        CRS - Cùng Bạn Trên<br/>
                        <span class="text-6xl md:text-8xl">Mọi Hành Trình</span>
                    </h1>
                    <p class="text-xl md:text-2xl text-white drop-shadow-md font-medium">
                        Trải nghiệm sự khác biệt với xe gia đình đời mới khắp Việt Nam
                    </p>
                </div>

                <div class="search-box rounded-3xl shadow-2xl p-8 max-w-5xl mx-auto border border-green-100">
                    <div class="flex flex-wrap gap-3 mb-8">
                        <button onclick="setActiveTab('self-drive')" id="tab-self-drive" class="tab-active flex items-center px-6 py-3 rounded-xl font-semibold transition-all">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"/>
                            </svg>
                            Xe tự lái
                        </button>
                    </div>

                    <form action="${pageContext.request.contextPath}/homepage" method="GET">
                        <div class="grid md:grid-cols-12 gap-5 items-end">
                            <div class="md:col-span-4">
                                <label class="block text-sm font-semibold text-gray-700 mb-2">
                                    <svg class="w-4 h-4 inline mr-1 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/>
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/>
                                    </svg>
                                    Địa điểm
                                </label>
                                <select name="searchKey" class="w-full px-4 py-3.5 border-2 border-gray-200 rounded-xl focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-all">
                                    <option value="">Tất cả địa điểm</option>
                                    <option value="TP. Hồ Chí Minh" ${param.searchKey == 'TP. Hồ Chí Minh' ? 'selected' : ''}>TP. Hồ Chí Minh</option>
                                    <option value="Hà Nội" ${param.searchKey == 'Hà Nội' ? 'selected' : ''}>Hà Nội</option>
                                    <option value="Đà Nẵng" ${param.searchKey == 'Đà Nẵng' ? 'selected' : ''}>Đà Nẵng</option>
                                    <option value="Cần Thơ" ${param.searchKey == 'Cần Thơ' ? 'selected' : ''}>Cần Thơ</option>
                                </select>
                            </div>

                            <div class="md:col-span-3">
                                <label class="block text-sm font-semibold text-gray-700 mb-2">
                                    <svg class="w-4 h-4 inline mr-1 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17h.01"/>
                                    </svg>
                                    Màu xe
                                </label>
                                <select name="color" class="w-full px-4 py-3.5 border-2 border-gray-200 rounded-xl focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-all">
                                    <option value="">Tất cả màu</option>
                                    <option value="Trắng" ${param.color == 'Trắng' ? 'selected' : ''}>Trắng</option>
                                    <option value="Đen" ${param.color == 'Đen' ? 'selected' : ''}>Đen</option>
                                    <option value="Xám" ${param.color == 'Xám' ? 'selected' : ''}>Xám</option>
                                    <option value="Đỏ" ${param.color == 'Đỏ' ? 'selected' : ''}>Đỏ</option>
                                    <option value="Xanh" ${param.color == 'Xanh' ? 'selected' : ''}>Xanh</option>
                                </select>
                            </div>

                            <div class="md:col-span-3">
                                <label class="block text-sm font-semibold text-gray-700 mb-2">
                                    <svg class="w-4 h-4 inline mr-1 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 4h13M3 8h9m-9 4h6m4 0l4-4m0 0l4 4m-4-4v12"/>
                                    </svg>
                                    Sắp xếp giá
                                </label>
                                <select name="priceOrder" class="w-full px-4 py-3.5 border-2 border-gray-200 rounded-xl focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-all">
                                    <option value="">Mặc định</option>
                                    <option value="ASC" ${param.priceOrder == 'ASC' ? 'selected' : ''}>Giá tăng dần</option>
                                    <option value="DESC" ${param.priceOrder == 'DESC' ? 'selected' : ''}>Giá giảm dần</option>
                                </select>
                            </div>

                            <div class="md:col-span-2">
                                <button type="submit" class="w-full gradient-bg hover:shadow-2xl text-white font-bold py-3.5 px-6 rounded-xl transition-all duration-300 transform hover:scale-105 flex items-center justify-center">
                                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                                    </svg>
                                    Tìm Xe
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </section>

        <section class="py-20 bg-white">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="mb-12 text-center">
                    <h2 class="text-4xl font-bold text-gray-900 mb-3">
                        <span class="bg-gradient-to-r from-green-600 to-emerald-600 bg-clip-text text-transparent">Xe Dành Cho Bạn</span>
                    </h2>
                    <p class="text-gray-600 text-lg">Khám phá những chiếc xe tốt nhất trong khu vực của bạn</p>
                </div>

                <c:if test="${not empty message}">
                    <div class="bg-red-50 border-l-4 border-red-500 text-red-700 px-6 py-4 rounded-lg mb-8 flex items-center">
                        <svg class="w-6 h-6 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                        ${message}
                    </div>
                </c:if>

                <c:choose>
                    <c:when test="${empty carList}">
                        <div class="text-center py-20">
                            <div class="inline-flex items-center justify-center w-24 h-24 bg-gray-100 rounded-full mb-6">
                                <svg class="w-12 h-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                      d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                </svg>
                            </div>
                            <h3 class="text-2xl font-bold text-gray-900 mb-2">Không tìm thấy xe nào</h3>
                            <p class="text-gray-600 mb-6">Vui lòng thử lại với tiêu chí tìm kiếm khác</p>
                            <a href="homepage" class="inline-flex items-center px-6 py-3 gradient-bg text-white font-semibold rounded-xl hover:shadow-lg transition-all">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
                                </svg>
                                Làm mới tìm kiếm
                            </a>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
                            <c:forEach var="car" items="${carList}">
                                <div class="car-card bg-white rounded-2xl shadow-lg overflow-hidden cursor-pointer">
                                    <div class="relative h-56 bg-gradient-to-br from-gray-100 to-gray-200">
                                        <c:choose>
                                            <c:when test="${not empty car.thumbnail}">
                                                <img src="${car.thumbnail}" alt="${car.name}" class="w-full h-full object-cover">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="w-full h-full flex items-center justify-center">
                                                    <svg class="w-20 h-20 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                          d="M5 8h14M5 8a2 2 0 110-4h14a2 2 0 110 4M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4"/>
                                                    </svg>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="absolute top-4 right-4">
                                            <span class="status-badge text-white text-xs font-bold px-4 py-2 rounded-full">
                                                ${car.status}
                                            </span>
                                        </div>
                                    </div>

                                    <div class="p-6">
                                        <h3 class="text-xl font-bold text-gray-900 mb-1 truncate">${car.name}</h3>
                                        <p class="text-sm text-gray-500 mb-4 font-medium">${car.model}</p>

                                        <div class="space-y-3 mb-5">
                                            <div class="flex items-center text-sm text-gray-600">
                                                <div class="w-8 h-8 bg-green-50 rounded-lg flex items-center justify-center mr-3">
                                                    <svg class="w-4 h-4 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                          d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/>
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/>
                                                    </svg>
                                                </div>
                                                <span class="truncate font-medium">${car.location}</span>
                                            </div>
                                            <div class="flex items-center text-sm text-gray-600">
                                                <div class="w-8 h-8 bg-blue-50 rounded-lg flex items-center justify-center mr-3">
                                                    <svg class="w-4 h-4 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                          d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17h.01"/>
                                                    </svg>
                                                </div>
                                                <span class="font-medium">${car.color}</span>
                                            </div>
                                            <div class="flex items-center text-sm text-gray-600">
                                                <div class="w-8 h-8 bg-purple-50 rounded-lg flex items-center justify-center mr-3">
                                                    <svg class="w-4 h-4 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                          d="M15 5v2m0 4v2m0 4v2M5 5a2 2 0 00-2 2v3a2 2 0 110 4v3a2 2 0 002 2h14a2 2 0 002-2v-3a2 2 0 110-4V7a2 2 0 00-2-2H5z"/>
                                                    </svg>
                                                </div>
                                                <span class="font-medium">${car.registrationNo}</span>
                                            </div>
                                        </div>

                                        <div class="border-t-2 border-gray-100 pt-5 space-y-4">
                                            <div class="text-center">
                                                <span class="text-3xl font-bold price-tag">
                                                    <fmt:formatNumber value="${car.pricePer}" pattern="#,###"/>đ
                                                </span>
                                                <span class="text-sm text-gray-500 font-medium">/ngày</span>
                                            </div>
                                            <div class="flex gap-3">
                                                <button onclick="viewCarDetail(${car.carId})"
                                                        class="flex-1 bg-gradient-to-r from-yellow-400 to-yellow-500 hover:from-yellow-500 hover:to-yellow-600 text-white px-4 py-3 rounded-xl text-sm font-bold transition-all transform hover:scale-105 shadow-md">
                                                    Chi tiết
                                                </button>
                                                <button onclick="viewCarDetail(${car.carId})"
                                                        class="flex-1 gradient-bg hover:shadow-xl text-white px-4 py-3 rounded-xl text-sm font-bold transition-all transform hover:scale-105">
                                                    Thuê xe
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="flex justify-center items-center mt-16 gap-6">
                            <c:if test="${currentPage > 1}">
                                <a href="${pageContext.request.contextPath}/homepage?page=${currentPage - 1}&searchKey=${param.searchKey}&color=${param.color}&priceOrder=${param.priceOrder}"
                                   class="flex items-center px-6 py-3 bg-white border-2 border-gray-300 hover:border-green-500 hover:bg-green-50 rounded-xl text-gray-800 font-semibold transition-all">
                                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
                                    </svg>
                                    Trang trước
                                </a>
                            </c:if>

                            <span class="px-6 py-3 gradient-bg text-white font-bold rounded-xl shadow-lg">
                                Trang ${currentPage}
                            </span>

                            <c:if test="${hasMorePages}">
                                <a href="${pageContext.request.contextPath}/homepage?page=${currentPage + 1}&searchKey=${param.searchKey}&color=${param.color}&priceOrder=${param.priceOrder}"
                                   class="flex items-center px-6 py-3 gradient-bg hover:shadow-2xl rounded-xl text-white font-semibold transition-all transform hover:scale-105">
                                    Trang tiếp
                                    <svg class="w-5 h-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                    </svg>
                                </a>
                            </c:if>
                        </div>
                    </c:otherwise>
                </c:choose>
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

                                                    function setActiveTab(tabName) {
                                                        document.querySelectorAll('[id^="tab-"]').forEach(tab => {
                                                            tab.className = 'tab-inactive flex items-center px-6 py-3 rounded-xl font-semibold transition-all';
                                                        });
                                                        document.getElementById('tab-' + tabName).className = 'tab-active flex items-center px-6 py-3 rounded-xl font-semibold transition-all';
                                                    }

                                                    function viewCarDetail(carId) {
                                                        window.location.href = '${pageContext.request.contextPath}/car-detail?carId=' + carId;
                                                    }
        </script>
    </body>
</html>