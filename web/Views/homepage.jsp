<%-- 
    Document   : homepage
    Created on : Oct 22, 2025, 1:56:14 PM
    Author     : tuanthanh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
        </style>
    </head>
    <body>
        <!DOCTYPE html>
    <html lang="vi">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Mioto - Thuê Xe Tự Lái</title>
            <script src="https://cdn.tailwindcss.com"></script>
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
            </style>
        </head>
        <body class="bg-white">
            <!-- Header -->
            <header class="bg-white shadow-sm">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="flex justify-between items-center py-4">
                        <!-- Logo -->
                        <div class="flex items-center">
                            <svg class="w-10 h-10 text-emerald-500" viewBox="0 0 50 50" fill="currentColor">
                            <path d="M10 15 L25 5 L40 15 L40 35 L25 45 L10 35 Z" stroke="currentColor" stroke-width="2" fill="none"/>
                            <path d="M18 25 L25 20 L32 25 L32 35 L25 40 L18 35 Z"/>
                            </svg>
                            <span class="ml-2 text-2xl font-bold text-gray-900">MIOTO</span>
                        </div>

                        <!-- Navigation -->
                        <nav class="hidden md:flex items-center space-x-8">
                            <a href="#" class="text-gray-700 hover:text-emerald-500">Về Mioto</a>
                            <a href="#" class="text-gray-700 hover:text-emerald-500">Trở thành chủ xe</a>
                            <a href="#" class="text-gray-700 hover:text-emerald-500">Đăng ký</a>
                            <a href="#" class="px-6 py-2 border-2 border-gray-900 rounded-lg text-gray-900 hover:bg-gray-900 hover:text-white transition">
                                Đăng nhập
                            </a>
                        </nav>
                    </div>
                </div>
            </header>

            <!-- Hero Section -->
            <section class="hero-bg relative min-h-[600px] flex items-center justify-center">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 w-full">
                    <div class="text-center mb-12">
                        <h1 class="text-5xl md:text-6xl font-bold text-white mb-6">
                            Mioto - Cùng Bạn Trên<br/>Mọi Hành Trình
                        </h1>
                        <p class="text-xl text-white">
                            Trải nghiệm sự khác biệt từ <span class="text-emerald-400 font-semibold">hơn 10.000</span> xe gia đình đời mới khắp Việt Nam
                        </p>
                    </div>

                    <!-- Booking Card -->
                    <div class="bg-white rounded-2xl shadow-2xl p-8 max-w-5xl mx-auto">
                        <!-- Tabs -->
                        <div class="flex flex-wrap gap-2 mb-8">
                            <button onclick="setActiveTab('self-drive')" id="tab-self-drive" class="tab-active flex items-center px-6 py-3 rounded-lg font-medium transition">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4"/>
                                </svg>
                                Xe tự lái
                            </button>
<!--                            <button onclick="setActiveTab('driver')" id="tab-driver" class="tab-inactive flex items-center px-6 py-3 rounded-lg font-medium transition">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                                </svg>
                                Xe có tài xế
                            </button>
                            <button onclick="setActiveTab('long-term')" id="tab-long-term" class="tab-inactive flex items-center px-6 py-3 rounded-lg font-medium transition">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                                </svg>
                                Thuê xe dài hạn
                            </button>-->
                        </div>

                        <!-- Booking Form -->
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
                                <select class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-emerald-500 focus:border-transparent">
                                    <option>TP. Hồ Chí Minh</option>
                                    <option>Hà Nội</option>
                                    <option>Đà Nẵng</option>
                                    <option>Cần Thơ</option>
                                </select>
                            </div>

                            <!-- Date Time -->
                            <div class="md:col-span-6">
                                <label class="block text-sm font-medium text-gray-700 mb-2">
                                    <svg class="w-4 h-4 inline mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                                    </svg>
                                    Thời gian thuê
                                </label>
                                <input type="text" value="21:00, 22/10/2025 - 20:00, 23/10/2025" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-emerald-500 focus:border-transparent">
                            </div>

                            <!-- Search Button -->
                            <div class="md:col-span-2">
                                <button class="w-full bg-emerald-500 hover:bg-emerald-600 text-white font-semibold py-3 px-6 rounded-lg transition shadow-lg">
                                    Tìm Xe
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Cars Section -->
            <section class="py-16 bg-gray-50">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    
                </div>
            </section>

            <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
            <script>
                            function setActiveTab(tabName) {
                                // Remove active class from all tabs
                                document.querySelectorAll('[id^="tab-"]').forEach(tab => {
                                    tab.className = 'tab-inactive flex items-center px-6 py-3 rounded-lg font-medium transition';
                                });

                                // Add active class to selected tab
                                document.getElementById('tab-' + tabName).className = 'tab-active flex items-center px-6 py-3 rounded-lg font-medium transition';
                            }
            </script>
        </body>
    </html>
