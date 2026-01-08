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
            <p>Chào mừng trở lại! Đây là tổng quan về cửa hàng của bạn trong tháng hiện tại.</p>
        </div>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <!-- Revenue -->
            <div class="stat-card success">
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
            <div class="stat-card primary">
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
            <div class="stat-card primary">
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

        <!-- Charts -->
        <div class="charts-row" style="grid-template-columns: 1fr 1fr;">
            <!-- Revenue -->
            <div class="chart-card">
                <div class="chart-header">
                    <h2>Doanh thu theo thời gian</h2>
                    <div class="chart-actions">
                        <select class="form-select form-select-sm" style="width: auto;" onchange="loadRevenue(this.value)">
                            <option value="7">7 ngày qua</option>
                            <option value="30">30 ngày qua</option>
                            <option value="3month" >3 tháng qua</option>
                            <option value="1year" >1 năm qua</option>
                        </select>
                    </div>
                </div>
                <div style="height: 300px;">
                    <canvas id="revenueChart"></canvas>
                </div>
            </div>

            <!-- Orders Over Time -->
            <div class="chart-card">
                <div class="chart-header">
                    <h2>Số đơn hàng theo thời gian</h2>
                    <select class="form-select form-select-sm" style="width: auto;" onchange="loadOrdersOverTime(this.value)">
                        <option value="7">7 ngày qua</option>
                        <option value="30">30 ngày qua</option>
                        <option value="3month" >3 tháng qua</option>
                        <option value="1year" >1 năm qua</option>
                    </select>
                </div>
                <div style="height: 280px;">
                    <canvas id="ordersOverTimeChart"></canvas>
                </div>
            </div>


        </div>

        <div class="charts-row" style="grid-template-columns: 1fr 1fr; margin-bottom: 32px;">
            <!-- Inventory Status -->
            <div class="chart-card">
                <div class="chart-header">
                    <h2>Top sản phẩm tồn kho</h2>
                    <select class="form-select form-select-sm" style="width: auto;" onchange="loadProductStock(this.value)">
                        <option value="desc">Tồn kho cao nhất</option>
                        <option value="asc">Tồn kho thấp nhất</option>
                    </select>
                </div>
                <div style="height: 300px;">
                    <canvas id="productStockChart"></canvas>
                </div>
            </div>

            <!-- Order Status -->
            <div class="chart-card">
                <div class="chart-header">
                    <h2>Trạng thái đơn hàng</h2>
                    <select class="form-select form-select-sm" style="width: auto;" onchange="loadProductStock(this.value)">
                        <option value="7">7 ngày qua</option>
                        <option value="30">30 ngày qua</option>
                        <option value="3month" >3 tháng qua</option>
                        <option value="1year" >1 năm qua</option>
                    </select>
                </div>
                <div style="height: 280px;">
                    <canvas id="orderStatusChart"></canvas>
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
    let revenueChart;

    function loadRevenue(range) {
        fetch(`${pageContext.request.contextPath}/api/orders/analytics?metric=revenue&range=` + range)
            .then(res => res.json())
            .then(data => {
                const labels = data.map(d => d.label);
                const values = data.map(d => d.value);
                renderRevenueChart(labels, values);
            })
            .catch(err => console.error(err));
    }

    function renderRevenueChart(labels, values) {
        const ctx = document.getElementById('revenueChart').getContext('2d');

        if (!revenueChart) {
            revenueChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Doanh thu (VNĐ)',
                        data: values,
                        borderColor: '#0d6efd',
                        backgroundColor: 'rgba(231,243,255,1)',
                        borderWidth: 3,
                        tension: 0.35,
                        fill: true,
                        pointRadius: 4,
                        pointHoverRadius: 6,
                        pointBackgroundColor: '#0d6efd'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            backgroundColor: '#fff',
                            titleColor: '#1a1a1a',
                            bodyColor: '#6c757d',
                            borderColor: '#e9ecef',
                            padding: 12,
                            callbacks: {
                                label: ctx =>
                                    ctx.raw.toLocaleString('vi-VN') + ' đ'
                            }
                        }
                    },
                    scales: {
                        x: {
                            grid: { display: false },
                            ticks: { color: '#6b7280' },
                            title: { display: true, text: 'Thời gian' }
                        },
                        y: {
                            beginAtZero: true,
                            grid: { color: '#e5e7eb' },
                            ticks: {
                                color: '#6b7280',
                                callback: v => v.toLocaleString('vi-VN')
                            },
                            title: {
                                display: true,
                                text: 'Doanh thu (VNĐ)'
                            }
                        }
                    },
                    animation: {
                        duration: 900,
                        easing: 'easeOutQuart'
                    }
                }
            });
        } else {
            revenueChart.data.labels = labels;
            revenueChart.data.datasets[0].data = values;
            revenueChart.update();
        }
    }

    // Product Stock Chart
    let productStockChart;

    function loadProductStock(order) {
        fetch(`${pageContext.request.contextPath}/api/products/analytics?order=` + order)
            .then(res => res.json())
            .then(data => {
                const labels = data.map(d => d.name);
                const values = data.map(d => d.quantity);
                renderProductStockChart(labels, values);
            })
            .catch(err => console.error(err));
    }

    function renderProductStockChart(labels, values) {
        const ctx = document.getElementById('productStockChart').getContext('2d');

        if (!productStockChart) {
            productStockChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Số lượng tồn kho',
                        data: values,
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
        } else {
            productStockChart.data.labels = labels;
            productStockChart.data.datasets[0].data = values;
            productStockChart.update();
        }
    }

    // Orders Over Time Chart
    let ordersOverTimeChart;

    function loadOrdersOverTime(range) {
        fetch(`${pageContext.request.contextPath}/api/orders/analytics?metric=order&range=` + range)
            .then(res => res.json())
            .then(data => {
                const labels = data.map(d => d.label);
                const values = data.map(d => d.value);
                renderOrdersOverTimeChart(labels, values);
            })
            .catch(err => console.error(err));
    }

    function renderOrdersOverTimeChart(labels, values) {
        const ctx = document.getElementById('ordersOverTimeChart').getContext('2d');

        if (!ordersOverTimeChart) {
            ordersOverTimeChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Số đơn',
                        data: values,
                        borderColor: '#198754',
                        backgroundColor: 'rgba(231,243,255,1)',
                        borderWidth: 3,
                        tension: 0.35,
                        fill: true,
                        pointRadius: 4,
                        pointHoverRadius: 6,
                        pointBackgroundColor: '#198754',
                        pointBorderColor: '#fff',
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            backgroundColor: '#fff',
                            titleColor: '#1a1a1a',
                            bodyColor: '#6c757d',
                            borderColor: '#e9ecef',
                            padding: 12,
                            callbacks: {
                                label: function(context) {
                                    return context.parsed.y + ' đơn hàng';
                                }
                            }
                        }
                    },
                    scales: {
                        x: {
                            grid: { display: false },
                            ticks: { color: '#6b7280' },
                            title: { display: true, text: 'Thời gian' }
                        },
                        y: {
                            beginAtZero: true,
                            grid: { color: '#e5e7eb' },
                            ticks: {
                                color: '#6b7280',
                                callback: v => v.toLocaleString('vi-VN')
                            },
                            title: {
                                display: true,
                                text: 'Số đơn'
                            }
                        }
                    },
                    animation: {
                        duration: 900,
                        easing: 'easeOutQuart'
                    }
                }
            });
        } else {
            ordersOverTimeChart.data.labels = labels;
            ordersOverTimeChart.data.datasets[0].data = values;
            ordersOverTimeChart.update();
        }
    }



    // Order Status Chart
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

    document.addEventListener("DOMContentLoaded", () => {
        loadRevenue(7);// 7 ngày
        loadOrdersOverTime(7);
        loadProductStock("desc");
    });
</script>
</body>
</html>
