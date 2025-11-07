<%-- 
    Document   : booking-result
    Created on : Nov 8, 2025, 1:59:49 AM
    Author     : hainn
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kết Quả Thanh Toán - CRS</title>

        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <style>
            .gradient-bg {
                background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            }
            
            .gradient-bg-red {
                background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            }
            
            .gradient-bg-yellow {
                background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
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
            
            .animate-check {
                animation: checkmark 0.6s ease-in-out;
            }
            
            @keyframes checkmark {
                0% {
                    transform: scale(0);
                    opacity: 0;
                }
                50% {
                    transform: scale(1.2);
                }
                100% {
                    transform: scale(1);
                    opacity: 1;
                }
            }
            
            .animate-fade-in {
                animation: fadeIn 0.5s ease-in;
            }
            
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            
            .pulse-ring {
                animation: pulse-ring 1.5s cubic-bezier(0.4, 0, 0.6, 1) infinite;
            }
            
            @keyframes pulse-ring {
                0% {
                    transform: scale(1);
                    opacity: 1;
                }
                100% {
                    transform: scale(1.5);
                    opacity: 0;
                }
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

        <section class="py-16 min-h-screen">
            <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
                <!-- Success Result -->
                <c:if test="${vnp_ResponseCode == '00' && vnp_TransactionStatus == '00'}">
                    <div class="animate-fade-in">
                        <!-- Success Icon -->
                        <div class="flex justify-center mb-8">
                            <div class="relative">
                                <div class="absolute inset-0 gradient-bg rounded-full blur-xl opacity-50 pulse-ring"></div>
                                <div class="relative w-28 h-28 gradient-bg rounded-full flex items-center justify-center animate-check">
                                    <svg class="w-16 h-16 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M5 13l4 4L19 7"/>
                                    </svg>
                                </div>
                            </div>
                        </div>

                        <!-- Success Message -->
                        <div class="text-center mb-10">
                            <h1 class="text-4xl font-bold text-gray-900 mb-4">
                                ${status}
                            </h1>
                            <p class="text-lg text-gray-600 max-w-2xl mx-auto">
                                ${message}
                            </p>
                        </div>

                        <!-- Transaction Details Card -->
                        <div class="bg-white rounded-2xl shadow-xl overflow-hidden border-2 border-green-100 mb-8">
                            <div class="gradient-bg px-6 py-4">
                                <h2 class="text-xl font-bold text-white flex items-center">
                                    <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                              d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                    </svg>
                                    Chi Tiết Giao Dịch
                                </h2>
                            </div>
                            
                            <div class="p-8 space-y-6">
                                <div class="flex items-center justify-between py-4 border-b border-gray-100">
                                    <div class="flex items-center">
                                        <div class="w-12 h-12 bg-blue-50 rounded-xl flex items-center justify-center mr-4">
                                            <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                      d="M7 20l4-16m2 16l4-16M6 9h14M4 15h14"/>
                                            </svg>
                                        </div>
                                        <div>
                                            <p class="text-sm text-gray-500 font-medium">Mã giao dịch</p>
                                            <p class="text-lg font-bold text-gray-900">${vnp_TxnRef}</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="flex items-center justify-between py-4 border-b border-gray-100">
                                    <div class="flex items-center">
                                        <div class="w-12 h-12 bg-green-50 rounded-xl flex items-center justify-center mr-4">
                                            <svg class="w-6 h-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                      d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                            </svg>
                                        </div>
                                        <div>
                                            <p class="text-sm text-gray-500 font-medium">Số tiền</p>
                                            <p class="text-2xl font-bold bg-gradient-to-r from-green-600 to-emerald-600 bg-clip-text text-transparent">
                                                <fmt:formatNumber value="${vnp_Amount / 100}" pattern="#,###"/>đ
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <div class="flex items-center justify-between py-4">
                                    <div class="flex items-center">
                                        <div class="w-12 h-12 bg-purple-50 rounded-xl flex items-center justify-center mr-4">
                                            <svg class="w-6 h-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                      d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                                            </svg>
                                        </div>
                                        <div>
                                            <p class="text-sm text-gray-500 font-medium">Thời gian thanh toán</p>
                                            <p class="text-lg font-bold text-gray-900">
                                                ${fn:substring(vnp_PayDate, 6, 8)}/${fn:substring(vnp_PayDate, 4, 6)}/${fn:substring(vnp_PayDate, 0, 4)} 
                                                ${fn:substring(vnp_PayDate, 8, 10)}:${fn:substring(vnp_PayDate, 10, 12)}
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="flex gap-4 justify-center">
                            <a href="${pageContext.request.contextPath}/homepage" class="px-8 py-4 bg-white border-2 border-gray-300 hover:border-green-500 rounded-xl text-gray-700 font-bold transition-all hover:bg-green-50 flex items-center">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                                </svg>
                                Về trang chủ
                            </a>
                            <a href="profile" class="px-8 py-4 gradient-bg hover:shadow-2xl rounded-xl text-white font-bold transition-all transform hover:scale-105 flex items-center">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                          d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                                </svg>
                                Xem đơn thuê
                            </a>
                        </div>
                    </div>
                </c:if>

                <!-- Failed Result -->
                <c:if test="${vnp_ResponseCode == '24' || vnp_ResponseCode == '15'}">
                    <div class="animate-fade-in">
                        <!-- Failed Icon -->
                        <div class="flex justify-center mb-8">
                            <div class="relative">
                                <div class="absolute inset-0 gradient-bg-yellow rounded-full blur-xl opacity-50 pulse-ring"></div>
                                <div class="relative w-28 h-28 gradient-bg-yellow rounded-full flex items-center justify-center animate-check">
                                    <svg class="w-16 h-16 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" 
                                              d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
                                    </svg>
                                </div>
                            </div>
                        </div>

                        <!-- Warning Message -->
                        <div class="text-center mb-10">
                            <h1 class="text-4xl font-bold text-gray-900 mb-4">
                                ${status}
                            </h1>
                            <p class="text-lg text-gray-600 max-w-2xl mx-auto">
                                ${message}
                            </p>
                        </div>

                        <!-- Transaction Details Card -->
                        <div class="bg-white rounded-2xl shadow-xl overflow-hidden border-2 border-yellow-100 mb-8">
                            <div class="gradient-bg-yellow px-6 py-4">
                                <h2 class="text-xl font-bold text-white flex items-center">
                                    <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                              d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                    </svg>
                                    Chi Tiết Giao Dịch
                                </h2>
                            </div>
                            
                            <div class="p-8 space-y-6">
                                <div class="flex items-center justify-between py-4 border-b border-gray-100">
                                    <div class="flex items-center">
                                        <div class="w-12 h-12 bg-blue-50 rounded-xl flex items-center justify-center mr-4">
                                            <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                      d="M7 20l4-16m2 16l4-16M6 9h14M4 15h14"/>
                                            </svg>
                                        </div>
                                        <div>
                                            <p class="text-sm text-gray-500 font-medium">Mã giao dịch</p>
                                            <p class="text-lg font-bold text-gray-900">${vnp_TxnRef}</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="flex items-center justify-between py-4 border-b border-gray-100">
                                    <div class="flex items-center">
                                        <div class="w-12 h-12 bg-yellow-50 rounded-xl flex items-center justify-center mr-4">
                                            <svg class="w-6 h-6 text-yellow-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                      d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                            </svg>
                                        </div>
                                        <div>
                                            <p class="text-sm text-gray-500 font-medium">Trạng thái</p>
                                            <p class="text-lg font-bold text-yellow-600">
                                                <c:choose>
                                                    <c:when test="${vnp_ResponseCode == '24'}">Đã hủy bởi người dùng</c:when>
                                                    <c:otherwise>Giao dịch hết hạn</c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <div class="flex items-center justify-between py-4">
                                    <div class="flex items-center">
                                        <div class="w-12 h-12 bg-purple-50 rounded-xl flex items-center justify-center mr-4">
                                            <svg class="w-6 h-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                      d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                                            </svg>
                                        </div>
                                        <div>
                                            <p class="text-sm text-gray-500 font-medium">Thời gian</p>
                                            <p class="text-lg font-bold text-gray-900">
                                                ${fn:substring(vnp_PayDate, 6, 8)}/${fn:substring(vnp_PayDate, 4, 6)}/${fn:substring(vnp_PayDate, 0, 4)} 
                                                ${fn:substring(vnp_PayDate, 8, 10)}:${fn:substring(vnp_PayDate, 10, 12)}
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Warning Box -->
                        <div class="bg-yellow-50 border-l-4 border-yellow-500 p-6 rounded-xl mb-8">
                            <div class="flex items-start">
                                <svg class="w-6 h-6 text-yellow-600 mr-3 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                          d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
                                </svg>
                                <div>
                                    <h3 class="text-lg font-bold text-yellow-900 mb-2">Lưu ý quan trọng</h3>
                                    <p class="text-yellow-800">
                                        Đơn đặt xe của bạn sẽ tự động bị hủy sau 2 giờ nếu không thanh toán thành công. 
                                        Nếu bạn vẫn muốn thuê xe này, vui lòng thực hiện thanh toán lại.
                                    </p>
                                </div>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="flex gap-4 justify-center flex-wrap">
                            <a href="${pageContext.request.contextPath}/homepage" class="px-8 py-4 bg-white border-2 border-gray-300 hover:border-green-500 rounded-xl text-gray-700 font-bold transition-all hover:bg-green-50 flex items-center">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                                </svg>
                                Về trang chủ
                            </a>
                            <a href="profile" class="px-8 py-4 gradient-bg-yellow hover:shadow-2xl rounded-xl text-white font-bold transition-all transform hover:scale-105 flex items-center">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                          d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
                                </svg>
                                Thanh toán lại
                            </a>
                        </div>
                    </div>
                </c:if>

                <!-- Other Errors -->
                <c:if test="${not empty status && vnp_ResponseCode != '00' && vnp_ResponseCode != '24' && vnp_ResponseCode != '15'}">
                    <div class="animate-fade-in">
                        <!-- Error Icon -->
                        <div class="flex justify-center mb-8">
                            <div class="relative">
                                <div class="absolute inset-0 gradient-bg-red rounded-full blur-xl opacity-50 pulse-ring"></div>
                                <div class="relative w-28 h-28 gradient-bg-red rounded-full flex items-center justify-center animate-check">
                                    <svg class="w-16 h-16 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M6 18L18 6M6 6l12 12"/>
                                    </svg>
                                </div>
                            </div>
                        </div>

                        <!-- Error Message -->
                        <div class="text-center mb-10">
                            <h1 class="text-4xl font-bold text-gray-900 mb-4">
                                ${status}
                            </h1>
                            <p class="text-lg text-gray-600 max-w-2xl mx-auto">
                                ${not empty message ? message : 'Đã xảy ra lỗi trong quá trình xử lý thanh toán. Vui lòng thử lại sau hoặc liên hệ hỗ trợ.'}
                            </p>
                        </div>

                        <!-- Error Details Card -->
                        <c:if test="${not empty vnp_TxnRef}">
                            <div class="bg-white rounded-2xl shadow-xl overflow-hidden border-2 border-red-100 mb-8">
                                <div class="gradient-bg-red px-6 py-4">
                                    <h2 class="text-xl font-bold text-white flex items-center">
                                        <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                  d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
                                        </svg>
                                        Thông Tin Lỗi
                                    </h2>
                                </div>
                                
                                <div class="p-8 space-y-6">
                                    <div class="flex items-center justify-between py-4 border-b border-gray-100">
                                        <div class="flex items-center">
                                            <div class="w-12 h-12 bg-blue-50 rounded-xl flex items-center justify-center mr-4">
                                                <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                          d="M7 20l4-16m2 16l4-16M6 9h14M4 15h14"/>
                                                </svg>
                                            </div>
                                            <div>
                                                <p class="text-sm text-gray-500 font-medium">Mã giao dịch</p>
                                                <p class="text-lg font-bold text-gray-900">${vnp_TxnRef}</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="flex items-center justify-between py-4 border-b border-gray-100">
                                        <div class="flex items-center">
                                            <div class="w-12 h-12 bg-red-50 rounded-xl flex items-center justify-center mr-4">
                                                <svg class="w-6 h-6 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                          d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                                </svg>
                                            </div>
                                            <div>
                                                <p class="text-sm text-gray-500 font-medium">Mã lỗi</p>
                                                <p class="text-lg font-bold text-red-600">${vnp_ResponseCode}</p>
                                            </div>
                                        </div>
                                    </div>

                                    <c:if test="${not empty vnp_PayDate}">
                                        <div class="flex items-center justify-between py-4">
                                            <div class="flex items-center">
                                                <div class="w-12 h-12 bg-purple-50 rounded-xl flex items-center justify-center mr-4">
                                                    <svg class="w-6 h-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                              d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                                                    </svg>
                                                </div>
                                                <div>
                                                    <p class="text-sm text-gray-500 font-medium">Thời gian</p>
                                                    <p class="text-lg font-bold text-gray-900">
                                                        ${fn:substring(vnp_PayDate, 6, 8)}/${fn:substring(vnp_PayDate, 4, 6)}/${fn:substring(vnp_PayDate, 0, 4)} 
                                                        ${fn:substring(vnp_PayDate, 8, 10)}:${fn:substring(vnp_PayDate, 10, 12)}
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:if>

                        <!-- Support Contact -->
                        <div class="bg-blue-50 border-l-4 border-blue-500 p-6 rounded-xl mb-8">
                            <div class="flex items-start">
                                <svg class="w-6 h-6 text-blue-600 mr-3 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                          d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                </svg>
                                <div>
                                    <h3 class="text-lg font-bold text-blue-900 mb-2">Cần hỗ trợ?</h3>
                                    <p class="text-blue-800 mb-3">
                                        Nếu bạn gặp vấn đề hoặc cần trợ giúp, vui lòng liên hệ với chúng tôi:
                                    </p>
                                    <div class="space-y-2">
                                        <p class="text-blue-900 font-medium">
                                            <svg class="w-4 h-4 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                      d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"/>
                                            </svg>
                                            Hotline: 1900-xxxx
                                        </p>
                                        <p class="text-blue-900 font-medium">
                                            <svg class="w-4 h-4 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                      d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                                            </svg>
                                            Email: support@crs.com.vn
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="flex gap-4 justify-center flex-wrap">
                            <a href="${pageContext.request.contextPath}/homepage" class="px-8 py-4 bg-white border-2 border-gray-300 hover:border-green-500 rounded-xl text-gray-700 font-bold transition-all hover:bg-green-50 flex items-center">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                                </svg>
                                Về trang chủ
                            </a>
                            <a href="profile" class="px-8 py-4 gradient-bg hover:shadow-2xl rounded-xl text-white font-bold transition-all transform hover:scale-105 flex items-center">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                          d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
                                </svg>
                                Thử lại
                            </a>
                        </div>
                    </div>
                </c:if>

                <!-- Session Error (No transaction data) -->
                <c:if test="${empty status && empty vnp_TxnRef}">
                    <div class="animate-fade-in">
                        <div class="flex justify-center mb-8">
                            <div class="w-28 h-28 bg-gray-200 rounded-full flex items-center justify-center">
                                <svg class="w-16 h-16 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                          d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
                                </svg>
                            </div>
                        </div>

                        <div class="text-center mb-10">
                            <h1 class="text-4xl font-bold text-gray-900 mb-4">
                                Không tìm thấy thông tin giao dịch
                            </h1>
                            <p class="text-lg text-gray-600 max-w-2xl mx-auto">
                                Phiên làm việc đã hết hạn hoặc không có dữ liệu thanh toán. Vui lòng thử lại.
                            </p>
                        </div>

                        <div class="flex justify-center">
                            <a href="${pageContext.request.contextPath}/homepage" class="px-8 py-4 gradient-bg hover:shadow-2xl rounded-xl text-white font-bold transition-all transform hover:scale-105 flex items-center">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                                </svg>
                                Về trang chủ
                            </a>
                        </div>
                    </div>
                </c:if>
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