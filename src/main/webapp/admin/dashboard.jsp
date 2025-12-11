<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />

    <title>Quản trị - Dashboard</title>


    <link
            rel="stylesheet"
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"
    />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="css/dashboard.css">
    <link rel="stylesheet" href="../css/root.css"/>
    <link rel="stylesheet" href="css/index.css">
</head>

<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>

<main class="col-md-9 col-lg-10 px-4 py-3 main-content">
    <script src="js/Chart.extension.js"></script>
    <script src="js/chartjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/echarts@5/dist/echarts.min.js"></script>
    <main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg">
        <div class="container-fluid py-2">
            <div class="row gy-3">
                <div class="ms-3">
                    <h3 class="mb-0 h4 font-weight-bolder"></h3>
                    <p class="mb-4">
                    <h1>Thống kê tổng quan về cửa hàng của bạn</h1>
                    </p>
                </div>

                <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
                    <div class="card">
                        <div class="card-header p-2 ps-3">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <p class="text-sm mb-0 text-capitalize">Sản Phẩm Mới Của Tháng </p>
                                    <h4 class="mb-0">120</h4>
                                </div>
                                <div
                                        class="d-flex justify-content-center align-items-center bg-danger rounded"
                                        style="width: 40px; height: 40px; background-color: #cf102d;"
                                >
                                    <i class="bi bi-box-seam text-white"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
                    <div class="card">
                        <div class="card-header p-2 ps-3">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <p class="text-sm mb-0 text-capitalize">Số Lượng Đơn Hàng </p>
                                    <h4 class="mb-0">120</h4>
                                </div>
                                <div
                                        class="d-flex justify-content-center align-items-center bg-danger rounded"
                                        style="width: 40px; height: 40px; background-color: #cf102d;"
                                >
                                    <i class="bi bi-receipt text-white"></i>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
                    <div class="card">
                        <div class="card-header p-2 ps-3">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <p class="text-sm mb-0 text-capitalize">Đơn Hàng Đã Thành Công</p>
                                    <h4 class="mb-0">120</h4>
                                </div>
                                <div
                                        class="d-flex justify-content-center align-items-center bg-danger rounded"
                                        style="width: 40px; height: 40px; background-color: #cf102d;"
                                >
                                    <i class="bi bi-receipt text-white"></i>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
                    <div class="card">
                        <div class="card-header p-2 ps-3">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <p class="text-sm mb-0 text-capitalize">Số Lượng Đơn Hàng Không Thành
                                        công</p>
                                    <h4 class="mb-0">120</h4>
                                </div>
                                <div
                                        class="d-flex justify-content-center align-items-center bg-danger rounded"
                                        style="width: 40px; height: 40px; background-color: #cf102d;"
                                >
                                    <i class="bi bi-receipt text-white"></i>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
                    <div class="card">
                        <div class="card-header p-2 ps-3">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <p class="text-sm mb-0 text-capitalize text-truncate">Số Lượng Khách Hàng
                                        Mới Trong Tháng</p>
                                    <h4 class="mb-0">120</h4>
                                </div>
                                <div
                                        class="d-flex justify-content-center align-items-center bg-danger rounded"
                                        style="width: 40px; height: 40px; background-color: #cf102d;"
                                >
                                    <i class="bi bi-people text-white"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
                    <div class="card">
                        <div class="card-header p-2 ps-3">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <p class="text-sm mb-0 text-capitalize">Số Lượng Khuyển Mãi</p>
                                    <h4 class="mb-0">120</h4>
                                </div>
                                <div
                                        class="d-flex justify-content-center align-items-center bg-danger rounded"
                                        style="width: 40px; height: 40px; background-color: #cf102d;"
                                >
                                    <i class="bi bi-tags-fill text-white"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
                    <div class="card">
                        <div class="card-header p-2 ps-3">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <p class="text-sm mb-0 text-capitalize">Số Lượng Bài Viết Của Tuần</p>
                                    <h4 class="mb-0">120</h4>
                                </div>
                                <div
                                        class="d-flex justify-content-center align-items-center bg-danger rounded"
                                        style="width: 40px; height: 40px; background-color: #cf102d;"
                                >
                                    <i class="bi bi-file-earmark-text text-white"></i>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
                    <div class="card">
                        <div class="card-header p-2 ps-3">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <p class="text-sm mb-0 text-capitalize">Số Lượng Thương Hiệu</p>
                                    <h4 class="mb-0">120</h4>
                                </div>

                                <div
                                        class="d-flex justify-content-center align-items-center bg-danger rounded"
                                        style="width: 40px; height: 40px; background-color: #cf102d;"
                                >
                                    <i class="bi bi-patch-check-fill text-white"></i>


                                </div>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>
        <br>
        <div class="container">
            <div class="row justify-content-center align-items-start">

                <!-- sản phẩm đã bán ra -->
                <div class="col-md-6 col-lg-6 text-center mb-4">
                    <h3>Biểu đồ sản phẩm đã bán ra trong tháng</h3>
                    <div id="chart" class="chart-card"></div>
                </div>

                <!-- doanh thu theo tuần -->
                <div class="col-md-6 col-lg-6 text-center mb-4">
                    <h3>Biểu đồ doanh thu theo tuần</h3>
                    <div id="container" class="chart-card"></div>
                </div>

            </div>
        </div>


        <script>
            // Khởi tạo biểu đồ
            var chart = echarts.init(document.getElementById("chart"));

            // Option cấu hình
            var option = {
                title: {
                    text: "",
                    left: "center",
                },
                tooltip: {},
                xAxis: {
                    type: "category",
                    data: ["Logo", "Car", "Th3", "Th4", "Th5", "Th6"]
                },
                yAxis: {
                    type: "value"
                },
                series: [
                    {
                        name: "Số lượng",
                        type: "bar",
                        data: [120, 200, 150, 80, 70, 110],
                        itemStyle: {
                            color: "#ff4d4f"
                        }
                    }
                ]
            };
            chart.setOption(option);
        </script>


        <script type="text/javascript"
                src="https://fastly.jsdelivr.net/npm/echarts@5/dist/echarts.min.js"></script>

        <script type="text/javascript">
            var dom = document.getElementById('container');
            var myChart = echarts.init(dom, null, {
                renderer: 'canvas',
                useDirtyRect: false
            });
            var app = {};

            var option;

            option = {
                xAxis: {
                    type: 'category',
                    data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                },
                yAxis: {
                    type: 'value'
                },
                series: [
                    {
                        data: [820, 932, 901, 934, 1290, 1330, 1320],
                        type: 'line',
                        smooth: true
                    }
                ]
            };

            if (option && typeof option === 'object') {
                myChart.setOption(option);
            }

            window.addEventListener('resize', myChart.resize);
        </script>
        </div>
    </main>


</main>


<script src="js/index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
