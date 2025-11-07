<%-- 
    Document   : booking
    Created on : Nov 8, 2025, 2:02:28 AM
    Author     : hainn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

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
    <body>
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

        <section>
            
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
