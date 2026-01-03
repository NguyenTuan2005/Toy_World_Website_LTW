<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>

    <title>Quản trị - Dashboard</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/root.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/index.css">
</head>

<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>

<main class ="main-content">
    <div class="dashboard-container">
        <!-- Header -->
        <div class="dashboard-header">
            <h1>Dashboard</h1>
            <p>Chào mừng trở lại! Đây là tổng quan về cửa hàng của bạn.</p>
        </div>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <!-- Revenue -->
            <div class="stat-card primary">
                <div class="stat-card-header">
                    <div>
                        <div class="stat-value">
                            <fmt:formatNumber value="${revenueThisMonth}" type="number" maxFractionDigits="0"/>
                        </div>
                        <div class="stat-label">Tổng doanh thu</div>
                    </div>
                    <div class="stat-icon">
                        <span class="mb-2 fs-4">₫</span>
                    </div>
                </div>
                <c:set var="growClass" value="${growthRate >= 0 ? 'positive' : 'negative'}" />
                <c:set var="arrow" value="${growthRate >= 0 ? 'bi-arrow-up' : 'bi-arrow-down'}" />
                <div class="stat-change ${growClass}">
                    <i class="bi ${arrow}"></i>
                    <fmt:formatNumber value="${revenueGrowth}" maxFractionDigits="1"/>% so với tháng trước
                </div>
            </div>
            <!-- Order -->
            <div class="stat-card warning">
                <div class="stat-card-header">
                    <div>
                        <div class="stat-value">${totalOrderThisMonth}</div>
                        <div class="stat-label">Đơn hàng</div>
                    </div>
                    <div class="stat-icon">
                        <i class="bi bi-cart-check"></i>
                    </div>
                </div>
                <c:set var="growClass" value="${growthRate >= 0 ? 'positive' : 'negative'}" />
                <c:set var="arrow" value="${growthRate >= 0 ? 'bi-arrow-up' : 'bi-arrow-down'}" />
                <div class="stat-change ${growClass}">
                    <i class="bi ${arrow}"></i>
                    <fmt:formatNumber value="${orderGrowth}" maxFractionDigits="1"/>% so với tháng trước
                </div>
            </div>
            <!-- product -->
            <div class="stat-card success">
                <div class="stat-card-header">
                    <div>
                        <div class="stat-value">${totalProductThisMonth}</div>
                        <div class="stat-label">Sản phẩm</div>
                    </div>
                    <div class="stat-icon">
                        <i class="bi bi-box-seam"></i>
                    </div>
                </div>
                <c:set var="growClass" value="${growthRate >= 0 ? 'positive' : 'negative'}" />
                <c:set var="arrow" value="${growthRate >= 0 ? 'bi-arrow-up' : 'bi-arrow-down'}" />
                <div class="stat-change ${growClass}">
                    <i class="bi ${arrow}"></i>
                    <fmt:formatNumber value="${productGrowth}" maxFractionDigits="1"/>% so với tháng trước
                </div>
            </div>
            <!-- User -->
            <div class="stat-card info">
                <div class="stat-card-header">
                    <div>
                        <div class="stat-value">${totalUserThisMonth}</div>
                        <div class="stat-label">Khách hàng</div>
                    </div>
                    <div class="stat-icon">
                        <i class="bi bi-people"></i>
                    </div>
                </div>
                <c:set var="growClass" value="${growthRate >= 0 ? 'positive' : 'negative'}" />
                <c:set var="arrow" value="${growthRate >= 0 ? 'bi-arrow-up' : 'bi-arrow-down'}" />
                <div class="stat-change ${growClass}">
                    <i class="bi ${arrow}"></i>
                    <fmt:formatNumber value="${userGrowth}" maxFractionDigits="1"/>% so với tháng trước
                </div>
            </div>
        </div>

        <!-- Charts Row -->
        <div class="charts-row">
            <!-- Revenue Chart -->
            <div class="chart-card">
                <div class="chart-header">
                    <h2>Doanh thu theo thời gian</h2>
                    <div class="chart-actions">
                        <select class="form-select form-select-sm" style="width: auto;">
                            <option>7 ngày qua</option>
                            <option>30 ngày qua</option>
                            <option>3 tháng qua</option>
                            <option>Năm nay</option>
                        </select>
                    </div>
                </div>
                <div style="height: 300px;">
                    <canvas id="revenueChart"></canvas>
                </div>
            </div>

            <!-- Top Products -->
            <div class="chart-card">
                <div class="chart-header">
                    <h2>Sản phẩm bán chạy</h2>
                    <button class="btn btn-sm btn-outline-secondary">
                        <i class="bi bi-three-dots"></i>
                    </button>
                </div>
                <ul class="top-products-list">
                    <li class="product-item">
                        <div class="product-info">
                            <div class="product-rank">1</div>
                            <div class="product-details">
                                <h6>Xe điều khiển từ xa</h6>
                                <p>Đồ chơi điện tử</p>
                            </div>
                        </div>
                        <div class="product-sales">
                            <strong>1,234</strong>
                            <span>đã bán</span>
                        </div>
                    </li>
                    <li class="product-item">
                        <div class="product-info">
                            <div class="product-rank">2</div>
                            <div class="product-details">
                                <h6>Bộ Lego Classic</h6>
                                <p>Lắp ráp sáng tạo</p>
                            </div>
                        </div>
                        <div class="product-sales">
                            <strong>987</strong>
                            <span>đã bán</span>
                        </div>
                    </li>
                    <li class="product-item">
                        <div class="product-info">
                            <div class="product-rank">3</div>
                            <div class="product-details">
                                <h6>Búp bê Barbie</h6>
                                <p>Búp bê thời trang</p>
                            </div>
                        </div>
                        <div class="product-sales">
                            <strong>856</strong>
                            <span>đã bán</span>
                        </div>
                    </li>
                    <li class="product-item">
                        <div class="product-info">
                            <div class="product-rank">4</div>
                            <div class="product-details">
                                <h6>Robot biến hình</h6>
                                <p>Đồ chơi siêu nhân</p>
                            </div>
                        </div>
                        <div class="product-sales">
                            <strong>745</strong>
                            <span>đã bán</span>
                        </div>
                    </li>
                    <li class="product-item">
                        <div class="product-info">
                            <div class="product-rank">5</div>
                            <div class="product-details">
                                <h6>Bộ đồ chơi bác sĩ</h6>
                                <p>Đồ chơi giáo dục</p>
                            </div>
                        </div>
                        <div class="product-sales">
                            <strong>623</strong>
                            <span>đã bán</span>
                        </div>
                    </li>
                </ul>
            </div>
        </div>

        <!-- Additional Charts Row -->
        <div class="charts-row" style="grid-template-columns: 1fr 1fr; margin-bottom: 32px;">
            <!-- Orders Over Time -->
            <div class="chart-card">
                <div class="chart-header">
                    <h2>Số đơn hàng theo thời gian</h2>
                    <select class="form-select form-select-sm" style="width: auto;">
                        <option>7 ngày qua</option>
                        <option>30 ngày qua</option>
                        <option>3 tháng qua</option>
                    </select>
                </div>
                <div style="height: 280px;">
                    <canvas id="ordersTimeChart"></canvas>
                </div>
            </div>

            <!-- Order Status -->
            <div class="chart-card">
                <div class="chart-header">
                    <h2>Trạng thái đơn hàng</h2>
                    <button class="btn btn-sm btn-outline-secondary">
                        <i class="bi bi-three-dots"></i>
                    </button>
                </div>
                <div style="height: 280px;">
                    <canvas id="orderStatusChart"></canvas>
                </div>
            </div>
        </div>

        <!-- Customer & Inventory Row -->
        <div class="charts-row" style="grid-template-columns: 1fr 1fr;">
            <!-- Customer Analysis -->
            <div class="chart-card">
                <div class="chart-header">
                    <h2>Phân tích khách hàng</h2>
                    <select class="form-select form-select-sm" style="width: auto;">
                        <option>Tháng này</option>
                        <option>Quý này</option>
                        <option>Năm nay</option>
                    </select>
                </div>
                <div style="height: 300px;">
                    <canvas id="customerChart"></canvas>
                </div>
                <div class="customer-stats">
                    <div class="customer-stat-item">
                        <div class="customer-stat-label">
                            <span class="stat-dot" style="background: #0d6efd;"></span>
                            Khách hàng mới
                        </div>
                        <strong>2,456</strong>
                    </div>
                    <div class="customer-stat-item">
                        <div class="customer-stat-label">
                            <span class="stat-dot" style="background: #198754;"></span>
                            Khách hàng quay lại
                        </div>
                        <strong>6,086</strong>
                    </div>
                </div>
            </div>

            <!-- Inventory Status -->
            <div class="chart-card">
                <div class="chart-header">
                    <h2>Top sản phẩm tồn kho</h2>
                    <select class="form-select form-select-sm" style="width: auto;">
                        <option>Tồn kho cao nhất</option>
                        <option>Tồn kho thấp nhất</option>
                        <option>Cần nhập thêm</option>
                    </select>
                </div>
                <div style="height: 300px;">
                    <canvas id="inventoryChart"></canvas>
                </div>
            </div>
        </div>
    </div>

</main>

<script src="js/index.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>
<script>
    // Revenue Chart
    const revenueCtx = document.getElementById('revenueChart').getContext('2d');
    const gradient = revenueCtx.createLinearGradient(0, 0, 0, 300);
    gradient.addColorStop(0, 'rgba(13, 110, 253, 0.2)');
    gradient.addColorStop(1, 'rgba(13, 110, 253, 0)');

    new Chart(revenueCtx, {
        type: 'line',
        data: {
            labels: ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'CN'],
            datasets: [{
                label: 'Doanh thu (triệu đồng)',
                data: [12, 15, 13, 18, 16, 22, 20],
                borderColor: '#0d6efd',
                backgroundColor: gradient,
                borderWidth: 2,
                tension: 0.4,
                fill: true,
                pointRadius: 4,
                pointBackgroundColor: '#0d6efd',
                pointBorderColor: '#fff',
                pointBorderWidth: 2,
                pointHoverRadius: 6
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            aspectRatio: 2.5,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    backgroundColor: '#fff',
                    titleColor: '#1a1a1a',
                    bodyColor: '#6c757d',
                    borderColor: '#e9ecef',
                    borderWidth: 1,
                    padding: 12,
                    displayColors: false,
                    callbacks: {
                        label: function(context) {
                            return context.parsed.y + ' triệu đồng';
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: {
                        borderDash: [5, 5],
                        color: '#f1f3f5'
                    },
                    ticks: {
                        callback: function(value) {
                            return value + 'M';
                        },
                        color: '#6c757d'
                    }
                },
                x: {
                    grid: {
                        display: false
                    },
                    ticks: {
                        color: '#6c757d'
                    }
                }
            }
        }
    });

    // Inventory Chart
    const inventoryCtx = document.getElementById('inventoryChart').getContext('2d');
    new Chart(inventoryCtx, {
        type: 'bar',
        data: {
            labels: ['Xe điều khiển', 'Lego Classic', 'Búp bê Barbie', 'Robot biến hình', 'Bộ đồ bác sĩ', 'Xe đẩy búp bê', 'Bộ đồ nhà bếp', 'Gấu bông Teddy'],
            datasets: [{
                label: 'Số lượng tồn kho',
                data: [456, 389, 367, 342, 298, 276, 245, 223],
                backgroundColor: [
                    '#0d6efd',
                    '#198754',
                    '#fd7e14',
                    '#0dcaf0',
                    '#6f42c1',
                    '#d63384',
                    '#ffc107',
                    '#20c997'
                ],
                borderRadius: 6,
                borderSkipped: false
            }]
        },
        options: {
            indexAxis: 'y',
            responsive: true,
            maintainAspectRatio: true,
            aspectRatio: 1.5,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    backgroundColor: '#fff',
                    titleColor: '#1a1a1a',
                    bodyColor: '#6c757d',
                    borderColor: '#e9ecef',
                    borderWidth: 1,
                    padding: 12,
                    displayColors: false,
                    callbacks: {
                        label: function(context) {
                            return context.parsed.x + ' sản phẩm';
                        }
                    }
                }
            },
            scales: {
                x: {
                    beginAtZero: true,
                    grid: {
                        borderDash: [5, 5],
                        color: '#f1f3f5'
                    },
                    ticks: {
                        color: '#6c757d'
                    }
                },
                y: {
                    grid: {
                        display: false
                    },
                    ticks: {
                        color: '#6c757d',
                        font: {
                            size: 12
                        }
                    }
                }
            }
        }
    });

    // Customer Analysis Chart
    const customerCtx = document.getElementById('customerChart').getContext('2d');
    new Chart(customerCtx, {
        type: 'bar',
        data: {
            labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'],
            datasets: [
                {
                    label: 'Khách hàng mới',
                    data: [120, 150, 180, 220, 190, 210, 240, 260, 230, 250, 280, 300],
                    backgroundColor: '#0d6efd',
                    borderRadius: 6,
                    borderSkipped: false
                },
                {
                    label: 'Khách hàng quay lại',
                    data: [300, 320, 340, 380, 360, 390, 420, 450, 430, 460, 490, 520],
                    backgroundColor: '#198754',
                    borderRadius: 6,
                    borderSkipped: false
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            aspectRatio: 2,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    backgroundColor: '#fff',
                    titleColor: '#1a1a1a',
                    bodyColor: '#6c757d',
                    borderColor: '#e9ecef',
                    borderWidth: 1,
                    padding: 12
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: {
                        borderDash: [5, 5],
                        color: '#f1f3f5'
                    },
                    ticks: {
                        color: '#6c757d'
                    }
                },
                x: {
                    grid: {
                        display: false
                    },
                    ticks: {
                        color: '#6c757d'
                    }
                }
            }
        }
    });

    // Orders Over Time Chart
    const ordersTimeCtx = document.getElementById('ordersTimeChart').getContext('2d');
    new Chart(ordersTimeCtx, {
        type: 'line',
        data: {
            labels: ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'CN'],
            datasets: [{
                label: 'Số đơn hàng',
                data: [45, 52, 48, 65, 58, 72, 68],
                borderColor: '#198754',
                backgroundColor: 'rgba(25, 135, 84, 0.1)',
                borderWidth: 2,
                tension: 0.4,
                fill: true,
                pointRadius: 4,
                pointBackgroundColor: '#198754',
                pointBorderColor: '#fff',
                pointBorderWidth: 2,
                pointHoverRadius: 6
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            aspectRatio: 2.2,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    backgroundColor: '#fff',
                    titleColor: '#1a1a1a',
                    bodyColor: '#6c757d',
                    borderColor: '#e9ecef',
                    borderWidth: 1,
                    padding: 12,
                    displayColors: false,
                    callbacks: {
                        label: function(context) {
                            return context.parsed.y + ' đơn hàng';
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: {
                        borderDash: [5, 5],
                        color: '#f1f3f5'
                    },
                    ticks: {
                        color: '#6c757d'
                    }
                },
                x: {
                    grid: {
                        display: false
                    },
                    ticks: {
                        color: '#6c757d'
                    }
                }
            }
        }
    });

    // Order Status Chart (keeping this one)
    const orderStatusCtx = document.getElementById('orderStatusChart').getContext('2d');
    new Chart(orderStatusCtx, {
        type: 'bar',
        data: {
            labels: ['Chờ xử lý', 'Đang xử lý', 'Đang giao', 'Đã giao', 'Đã hủy'],
            datasets: [{
                label: 'Số đơn hàng',
                data: [45, 78, 92, 234, 12],
                backgroundColor: [
                    '#ffc107',
                    '#0dcaf0',
                    '#0d6efd',
                    '#198754',
                    '#dc3545'
                ],
                borderRadius: 8,
                borderSkipped: false
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    backgroundColor: '#fff',
                    titleColor: '#1a1a1a',
                    bodyColor: '#6c757d',
                    borderColor: '#e9ecef',
                    borderWidth: 1,
                    padding: 12
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: {
                        borderDash: [5, 5],
                        color: '#f1f3f5'
                    },
                    ticks: {
                        color: '#6c757d'
                    }
                },
                x: {
                    grid: {
                        display: false
                    },
                    ticks: {
                        color: '#6c757d',
                        font: {
                            size: 11
                        }
                    }
                }
            }
        }
    });
</script>
</body>
</html>
