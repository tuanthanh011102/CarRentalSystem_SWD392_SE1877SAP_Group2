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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
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
    <body class="bg-white min-h-screen">
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

        <div class="max-w-7xl mx-auto p-6 py-8">
            <div class="bg-white rounded-2xl shadow-lg overflow-hidden mb-8 card-hover">
                <img src="${car.thumbnail}" 
                     class="w-full h-[500px] object-cover" alt="Toyota Vios">
            </div>

            <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-10">
                <div>
                    <!-- Car Name and Rating -->
                    <div class="flex flex-wrap items-center gap-3 mb-2">
                        <h1 class="text-3xl md:text-4xl font-bold text-gray-900">${car.name}</h1>
                        <div class="flex items-center bg-yellow-50 text-yellow-600 px-3 py-1 rounded-full shadow-sm">
                            <svg class="w-5 h-5 fill-current mr-1" viewBox="0 0 20 20">
                            <path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/>
                            </svg>
                            <span class="font-semibold">${rating}</span>
                            <span class="text-gray-500 text-sm ml-1">(${totalReview} đánh giá)</span>
                        </div>
                    </div>

                    <!-- Location -->
                    <div class="flex items-center text-gray-600 mt-1">
                        <svg class="w-5 h-5 mr-2 text-green-600" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" 
                              d="M5.05 4.05a7 7 0 119.9 9.9L10 18.9l-4.95-4.95a7 7 0 010-9.9zM10 11a2 2 0 100-4 2 2 0 000 4z" 
                              clip-rule="evenodd"/>
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
                            Chủ xe
                        </h2>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div class="flex items-center p-4 bg-gradient-to-r from-green-50 to-emerald-50 rounded-xl">
                                <div>
                                    <p class="text-sm text-gray-500">Tên</p>
                                    <p class="font-semibold text-gray-900">${owner.name}</p>
                                </div>
                            </div>
                            <div class="flex items-center p-4 bg-gradient-to-r from-green-50 to-emerald-50 rounded-xl">
                                <div>
                                    <p class="text-sm text-gray-500">Liên hệ</p>
                                    <p class="font-semibold text-gray-900">${owner.contact}</p>
                                </div>
                            </div>
                        </div>
                    </div>
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
                        </div>
                    </div>

                    <div class="flex justify-between items-start mb-8">
                        <div>
                            <h1 class="text-2xl font-bold text-gray-900 mb-6">Đánh giá từ những khách hàng khác</h1>
                            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                                <c:forEach items="${rList}" var="r">
                                    <div class="bg-white rounded-2xl shadow-md hover:shadow-xl transition-shadow duration-300 p-6 border border-gray-100">
                                        <div class="flex items-start justify-between mb-4">
                                            <div class="flex items-center gap-3">
                                                <div class="w-12 h-12 bg-gradient-to-br from-blue-500 to-purple-600 rounded-full flex items-center justify-center text-white font-semibold text-lg">
                                                    ${fn:substring(r.customer.name, 0, 1)}
                                                </div>
                                                <div>
                                                    <p class="font-semibold text-gray-900">${r.customer.name}</p>
                                                    <div class="flex items-center gap-1 mt-1">
                                                        <c:forEach var="i" begin="1" end="5">
                                                            <c:choose>
                                                                <c:when test="${i <= r.rating}">
                                                                    <!-- Filled star -->
                                                                    <svg class="w-4 h-4 fill-yellow-400" viewBox="0 0 20 20">
                                                                    <path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/>
                                                                    </svg>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <!-- Empty star -->
                                                                    <svg class="w-4 h-4 fill-gray-300" viewBox="0 0 20 20">
                                                                    <path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/>
                                                                    </svg>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                        <p class="text-gray-700 mb-4 leading-relaxed">${r.comment}</p>
                                        <div class="flex items-center text-sm text-gray-500">
                                            <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                                            </svg>
                                            ${r.createdAt}
                                        </div>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty rList}">
                                    <h1 class="text-lg text-gray-500 mb-6">Chưa có đánh giá nào</h1>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="lg:col-span-1">
                    <div class="bg-white p-6 rounded-2xl shadow-xl border-2 border-green-100 sticky top-24">
                        <!-- Price Section -->
                        <div class="text-center mb-6 pb-6 border-b border-gray-200">
                            <p class="text-sm text-gray-500 mb-2">Đơn giá thuê</p>
                            <p class="text-4xl font-bold bg-gradient-to-r from-green-600 to-emerald-600 bg-clip-text text-transparent">
                                <fmt:formatNumber value="${car.pricePer}" pattern="#,###"/>đ <span class="text-lg text-gray-500 font-normal">/ngày</span>
                            </p>
                        </div>

                        <div class="space-y-4 mb-6">
                            <!-- Pick-up Date/Time -->
                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-2">Nhận xe</label>
                                <input type="text" id="pickupDate" 
                                       class="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:border-green-500 focus:outline-none cursor-pointer bg-white"
                                       placeholder="23/10/2025   21:00" readonly>
                            </div>

                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-2">Trả xe</label>
                                <input type="text" id="returnDate" 
                                       class="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:border-green-500 focus:outline-none cursor-pointer bg-white"
                                       placeholder="24/10/2025   20:00" readonly>
                            </div>

                            <div class="flex items-center justify-between p-3 bg-green-50 rounded-xl">
                                <span class="text-sm text-gray-600">Số ngày thuê</span>
                                <span class="text-lg font-bold text-green-600" id="rentalDays">0 ngày</span>
                            </div>
                        </div>

                        <div class="space-y-3 mb-6 pb-6 border-b border-gray-200">
                            <div class="flex justify-between text-sm">
                                <span class="text-gray-600">Đơn giá thuê</span>
                                <span class="font-semibold" id="pricePerDay"><fmt:formatNumber value="${car.pricePer}" pattern="#,###"/>đ /ngày</span>
                            </div>
                            <div class="flex justify-between text-sm">
                                <span class="text-gray-600">Tổng cộng</span>
                                <span class="font-semibold" id="totalPerDay">0 x 0 ngày</span>
                            </div>
                        </div>

                        <div class="mb-6">
                            <div class="flex justify-between items-center mb-2">
                                <span class="text-lg font-bold text-gray-900">Thành tiền</span>
                                <span class="text-2xl font-bold text-green-600" id="totalPrice">0đ</span>
                            </div>
                        </div>

                        <button id="btnRent" class="gradient-bg text-white w-full py-4 rounded-xl text-lg font-bold hover:shadow-2xl transform hover:scale-105 transition-all duration-300 flex items-center justify-center disabled:opacity-50 disabled:cursor-not-allowed disabled:transform-none" disabled>
                            <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                  d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                            </svg>
                            CHỌN THUÊ
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

        <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            const pricePerDay = ${car.pricePer};
            const carId = ${car.carId};

            let pickupDateTime = null;
            let returnDateTime = null;

            const pickupPicker = flatpickr("#pickupDate", {
                enableTime: true,
                dateFormat: "d/m/Y   H:i",
                time_24hr: true,
                minDate: "today",
                defaultHour: 21,
                onChange: function (selectedDates) {
                    if (selectedDates.length > 0) {
                        pickupDateTime = selectedDates[0];

                        returnPicker.set('minDate', new Date(pickupDateTime.getTime() + 24 * 60 * 60 * 1000));

                        if (returnDateTime && returnDateTime <= pickupDateTime) {
                            returnDateTime = null;
                            document.getElementById("returnDate").value = "";
                        }

                        calculateTotal();
                    }
                }
            });

            const returnPicker = flatpickr("#returnDate", {
                enableTime: true,
                dateFormat: "d/m/Y   H:i",
                time_24hr: true,
                minDate: new Date(Date.now() + 24 * 60 * 60 * 1000),
                defaultHour: 20,
                onChange: function (selectedDates) {
                    if (selectedDates.length > 0) {
                        returnDateTime = selectedDates[0];
                        calculateTotal();
                    }
                }
            });

            function calculateTotal() {
                if (!pickupDateTime || !returnDateTime) {
                    document.getElementById("rentalDays").textContent = "0 ngày";
                    document.getElementById("totalPerDay").textContent = "0 x 0 ngày";
                    document.getElementById("totalPrice").textContent = "0đ";
                    document.getElementById("btnRent").disabled = true;
                    return;
                }

                const diffTime = Math.abs(returnDateTime - pickupDateTime);
                const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
                const rentalDays = Math.max(1, diffDays);

                const totalPerDay = pricePerDay;

                const finalTotal = totalPerDay * rentalDays;

                document.getElementById("rentalDays").textContent = rentalDays + " ngày";
                document.getElementById("totalPerDay").textContent = formatNumber(totalPerDay) + " x " + rentalDays + " ngày";
                document.getElementById("totalPrice").textContent = formatNumber(finalTotal) + "đ";
                document.getElementById("btnRent").disabled = false;
            }

            function formatNumber(num) {
                return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
            }

            document.getElementById("btnRent").addEventListener("click", function () {
                const isLoggedIn = ${not empty user};
                
                if (!isLoggedIn) {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Yêu cầu đăng nhập',
                        text: 'Bạn cần đăng nhập để đặt xe!',
                        showCancelButton: true,
                        confirmButtonText: 'Đăng nhập',
                        cancelButtonText: 'Hủy',
                        confirmButtonColor: '#10b981',
                        cancelButtonColor: '#6b7280',
                        reverseButtons: true
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = 'login';
                        }
                    });
                    return;
                }
                
                if (!pickupDateTime || !returnDateTime) {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Thông báo',
                        text: 'Vui lòng chọn ngày nhận và trả xe!',
                        confirmButtonText: 'Đóng',
                        confirmButtonColor: '#3085d6'
                    });
                    return;
                }

                const diffTime = Math.abs(returnDateTime - pickupDateTime);
                const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
                const rentalDays = Math.max(1, diffDays);
                const totalPerDay = pricePerDay;
                const finalTotal = totalPerDay * rentalDays;

                let pickupDate = document.getElementById("pickupDate").value;
                let returnDate = document.getElementById("returnDate").value;
                let totalPrice = formatNumber(finalTotal);

                Swal.fire({
                    title: 'Xác nhận đặt xe',
                    html: `
                            <div style="text-align: left; line-height: 1.8;">
                              <p><strong>Nhận xe:</strong> ` + pickupDate + `</p>
                              <p><strong>Trả xe:</strong> ` + returnDate + `</p>
                              <p><strong>Số ngày thuê:</strong> ` + rentalDays + ` ngày</p>
                              <p><strong>Tổng tiền:</strong> ` + totalPrice + `đ</p>
                            </div>
                          `,
                    icon: 'question',
                    showCancelButton: true,
                    confirmButtonText: 'Xác nhận',
                    cancelButtonText: 'Hủy',
                    confirmButtonColor: 'green',
                    cancelButtonColor: 'gray',
                    reverseButtons: true
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            url: "${pageContext.request.contextPath}/booking",
                            method: "POST",
                            data: {
                                carId: carId,
                                pickupDate: pickupDate,
                                returnDate: returnDate,
                                rentalDays: rentalDays,
                                totalPrice: totalPrice
                            }, success(response) {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Đặt xe thành công!',
                                    text: 'Chúng tôi sẽ liên hệ với bạn sớm nhất.',
                                    confirmButtonText: 'Đóng',
                                    confirmButtonColor: '#28a745'
                                });
                            }
                        });
                    }
                });
            });

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