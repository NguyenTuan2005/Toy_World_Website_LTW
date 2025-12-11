<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Quản trị - Thống Kê Doanh Thu</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="../css/root.css"/>
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>

<main class="main-content">
    <h1 class="text-center my-4">Thống kê doanh thu</h1>

    <!-- Tổng quan KPI -->
    <div class="row mb-4">
        <div class="col-lg-4 col-md-12 mb-3">
            <div class="card">
                <div class="card-body text-center py-3">
                    <small class="text-muted d-block">Tổng doanh thu</small>
                    <h4 class="mb-0">250.5M ₫</h4>
                </div>
            </div>
        </div>
        <div class="col-lg-4 col-md-6 mb-3">
            <div class="card">
                <div class="card-body text-center py-3">
                    <small class="text-muted d-block">Số đơn hàng</small>
                    <h4 class="mb-0">1.248</h4>
                </div>
            </div>
        </div>
        <div class="col-lg-4 col-md-6 mb-3">
            <div class="card">
                <div class="card-body text-center py-3">
                    <small class="text-muted d-block">Giá trị TB/đơn</small>
                    <h4 class=" mb-0">200.7K ₫</h4>
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

<script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.4.3/echarts.min.js"></script>
<script>
    const revenueChart = echarts.init(document.getElementById('revenueTimeChart'));
    revenueChart.setOption({
        tooltip: {trigger: 'axis'},
        xAxis: {
            type: 'category',
            data: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12']
        },
        yAxis: {type: 'value'},
        series: [{
            data: [18.5, 20.2, 22.8, 19.5, 25.3, 28.7, 24.2, 26.8, 23.5, 27.2, 29.8, 30.5],
            type: 'line',
            smooth: true,
            areaStyle: {opacity: 0.3},
            itemStyle: {color: '#D51B1B50'}
        }]
    });

    const paymentChart = echarts.init(document.getElementById('paymentMethodChart'));
    paymentChart.setOption({
        tooltip: {trigger: 'item'},
        series: [{
            type: 'pie',
            radius: ['40%', '70%'],
            data: [
                {value: 58, name: 'COD', itemStyle: {color: '#198754'}},
                {value: 42, name: 'VNPay', itemStyle: {color: '#0dcaf0'}}
            ],
            label: {formatter: '{b}: {d}%'}
        }]
    });

    const productChart = echarts.init(document.getElementById('productPriceChart'));
    productChart.setOption({
        tooltip: {trigger: 'axis', axisPointer: {type: 'shadow'}},
        xAxis: {
            type: 'category',
            data: ['SP A', 'SP B', 'SP C', 'SP D', 'SP E'],
            axisLabel: {interval: 0, rotate: 0}
        },
        yAxis: {type: 'value'},
        series: [{
            data: [45, 39.6, 35.6, 30.8, 28.5],
            type: 'bar',
            itemStyle: {
                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                    {offset: 0, color: '#fd7e14'},
                    {offset: 1, color: '#ffc107'}
                ])
            },
            label: {show: true, position: 'top', formatter: '{c}M'}
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

