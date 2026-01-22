<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<fmt:setLocale value="vi_VN" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Quản trị - Quản Lý Người Dùng</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/admin-base.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/index.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/root.css"/>
</head>
<body>

<div class="container-fluid">
    <div class="row">

        <aside id="sidebar" class="col-lg-2 col-md-3 bg-light text-primary min-vh-100 p-0">
            <jsp:include page="/common/sidebar.jsp"></jsp:include>
        </aside>

        <button class="btn btn-outline-secondary d-none fixed-top ms-3 mt-3 z-1 w-lg-3 w-md-5" onclick="openSidebar()" id="openSidebarBtn">
            <i class="fas fa-bars"></i>
        </button>

        <main class="col-md-9 col-lg-10" id="mainContent">
            <h1 class="text-center my-4">Thống kê doanh thu
                <select class="form-select" name="month">
                    <option value="1"  ${month == 1  ? "selected" : ""}>Tháng 1</option>
                    <option value="2"  ${month == 2  ? "selected" : ""}>Tháng 2</option>
                    <option value="3"  ${month == 3  ? "selected" : ""}>Tháng 3</option>
                    <option value="4"  ${month == 4  ? "selected" : ""}>Tháng 4</option>
                    <option value="5"  ${month == 5  ? "selected" : ""}>Tháng 5</option>
                    <option value="6"  ${month == 6  ? "selected" : ""}>Tháng 6</option>
                    <option value="7"  ${month == 7  ? "selected" : ""}>Tháng 7</option>
                    <option value="8"  ${month == 8  ? "selected" : ""}>Tháng 8</option>
                    <option value="9"  ${month == 9  ? "selected" : ""}>Tháng 9</option>
                    <option value="10" ${month == 10 ? "selected" : ""}>Tháng 10</option>
                    <option value="11" ${month == 11 ? "selected" : ""}>Tháng 11</option>
                    <option value="12" ${month == 12 ? "selected" : ""}>Tháng 12</option>
                </select>


            </h1>

            <!-- Tổng quan KPI -->
            <div class="row mb-4">
                <div class="col-lg-4 col-md-12 mb-3">
                    <div class="card">
                        <div class="card-body text-center py-3">
                            <small class="text-muted d-block">Tổng doanh thu</small>
                            <h4 class="mb-0">
                                <fmt:formatNumber value="${totalPricesOfOrder}" type="currency" currencyCode="VND"/>
                            </h4>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 mb-3">
                    <div class="card">
                        <div class="card-body text-center py-3">
                            <small class="text-muted d-block">Số đơn hàng</small>
                            <h4 class="mb-0">${totalNumberOfOrders}</h4>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 mb-3">
                    <div class="card">
                        <div class="card-body text-center py-3">
                            <small class="text-muted d-block">Giá trị TB/đơn</small>
                            <h4 class=" mb-0">
                                <fmt:formatNumber value="${averageValuePerOrder}" type="currency" currencyCode="VND"/>
                            </h4>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Biểu đồ doanh thu và phương thức thanh toán -->
            <div class="row mb-4">
                <div class="col-lg-8 mb-3">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">Doanh thu theo thời gian</h5>
                        </div>
                        <div class="card-body">
                            <div id="revenueTimeChart" style="height: 300px;"></div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 mb-3">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">Phương thức thanh toán</h5>
                        </div>
                        <div class="card-body">
                            <div id="paymentMethodChart" style="height: 300px;"></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Top sản phẩm -->
            <div class="w-100 mb-3">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">Top 5 sản phẩm bán chạy</h5>
                    </div>
                    <div class="card-body">
                        <div id="productPriceChart" style="height: 280px;"></div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>


<script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.4.3/echarts.min.js"></script>
<script>
    const revenueChart = echarts.init(document.getElementById('revenueTimeChart'));

    const revenueData =[
        <c:forEach var="item" items="${revenueOverTime}" varStatus="loop">
        ${item}<c:if test="${!loop.last}">,</c:if>
        </c:forEach>
    ];


    revenueChart.setOption({
        tooltip: { trigger: 'axis' },
        xAxis: {
            type: 'category',
            data: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12']
        },
        yAxis: { type: 'value' },
        series: [{
            data: revenueData,
            type: 'line',
            smooth: true,
            areaStyle: { opacity: 0.3 },
            itemStyle: { color: '#D51B1B50' }
        }]
    });

    const paymentData = [
        <c:forEach var="item" items="${paymentChart}" varStatus="loop">
        {
            value: ${item.percent},
            name: '${item.name}',
            itemStyle: {
                color: '${item.name eq "COD" ? "#198754" : "#0dcaf0"}'
            }
        }<c:if test="${!loop.last}">, </c:if>
        </c:forEach>
    ];

    console.log('Paymentchart ');

    console.log( paymentData);

    const paymentChart = echarts.init(document.getElementById('paymentMethodChart'));
    paymentChart.setOption({
        tooltip: { trigger: 'item' },
        series: [{
            type: 'pie',
            radius: ['40%', '70%'],
            data:paymentData,
            label: {formatter: '{b}: {d}%'}
        }]
    });

    const productChart = echarts.init(document.getElementById('productPriceChart'));

    const productChartNames = [
        <c:forEach var="item" items="${productChart}" varStatus="loop">
        '${item.name}'<c:if test="${!loop.last}">, </c:if>
        </c:forEach>
    ];

    console.log(productChartNames)

    const productChartData = [
        <c:forEach var="item" items="${productChart}" varStatus="loop">
        ${item.totalPrice}<c:if test="${!loop.last}">, </c:if>
        </c:forEach>
    ]

    console.log(productChartData)

    productChart.setOption({
        tooltip: {trigger: 'axis', axisPointer: {type: 'shadow'}},
        xAxis: {
            type: 'category',
            data: productChartNames,
            axisLabel: { interval: 0, rotate: 0 }
        },
        yAxis: { type: 'value' },
        series: [{
            data: productChartData ,
            type: 'bar',
            itemStyle: {
                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                    { offset: 0, color: '#fd7e14' },
                    { offset: 1, color: '#ffc107' }
                ])
            },
            label: { show: true, position: 'top', formatter: '{c}M' }
        }]
    });

    window.addEventListener('resize', () => {
        revenueChart.resize();
        paymentChart.resize();
        productChart.resize();
    });
</script>
<script src="js/index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

