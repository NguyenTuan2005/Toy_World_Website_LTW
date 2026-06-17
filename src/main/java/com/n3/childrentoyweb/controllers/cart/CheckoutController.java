package com.n3.childrentoyweb.controllers.cart;

import com.n3.childrentoyweb.dto.OrderDetailDTO;
import com.n3.childrentoyweb.enums.LocationProvince;
import com.n3.childrentoyweb.enums.PaymentMethod;
import com.n3.childrentoyweb.exception.DataInvalidException;
import com.n3.childrentoyweb.models.*;
import com.n3.childrentoyweb.services.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "checkout", value = "/checkout")
public class CheckoutController extends HttpServlet {
    private LocationService locationService;
    private PaymentService paymentService;
    private OrderService orderService;
    private UserService userService;
    private EmailService emailService;
    private OrderDetailService orderDetailService;

    @Override
    public void init() throws ServletException {
        this.locationService = new LocationService();
        this.paymentService = new PaymentService();
        this.orderService = new OrderService();
        this.userService = new UserService();
        this.orderDetailService = new OrderDetailService();
        this.emailService = EmailService.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User currentUser;
        try {
            if ((currentUser = (User) request.getSession().getAttribute("currentUser")) == null)
                throw new DataInvalidException("Bạn hãy vui lòng đăng nhập");

            if (currentUser.getIsLostKey()){
                request.setAttribute("username",currentUser.getFirstName()+" "+currentUser.getLastName());
                request.getRequestDispatcher("/Policy-lost-key.jsp").forward(request, response);
            }

            if (currentUser.getLocationId() != null) {
                Location location = locationService.findByUserId(currentUser.getId());
                request.setAttribute("location", location);
            }

            List<PaymentMethod> methods = paymentService.findAllPaymentMethod();


            long orderId = Long.parseLong(request.getParameter("orderId"));
            OrderDetailDTO order = orderService.findOrderDetailForCheckout(orderId, currentUser.getId());

            request.setAttribute("order", order);
            request.setAttribute("paymentMethods", methods);
            request.setAttribute("provinces", LocationProvince.values());
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);

        } catch (Exception  e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user;
        try {
            if ((user = (User) req.getSession().getAttribute("currentUser")) == null)
                throw new DataInvalidException("Bạn hãy vui lòng đăng nhập");

            long orderId = Long.parseLong(req.getParameter("orderId"));
            String paymentMethodName = req.getParameter("paymentMethod");
            String province = req.getParameter("province");
            String address = req.getParameter("address");


            if (province == null || province.trim().isEmpty() || address == null || address.trim().isEmpty())
                throw new DataInvalidException("Thông tin địa chỉ không hợp lệ");

            Location location;
            boolean hasLocation = user.getLocationId() != null;
            if (!hasLocation) {
                location = new Location(address, province);
                long locationId = this.locationService.save(location);
                user.setLocationId(locationId);
                location.setId(locationId);
                this.userService.updateLocation(user, location);
            } else {
                location = this.locationService.findByUserId(user.getId());
                boolean isSameLocation = location.equal(new Location(address, province));
                if (!isSameLocation)
                    location = this.locationService.update(new Location(location.getId(),address, province));
            }

            paymentService.checkout(user.getId(), orderId, paymentMethodName);

            OrderDetailDTO orderDetailDTO = orderDetailService.findOrderDetail(orderId);

            emailService.sendCheckoutEmail(user, orderDetailDTO, location, orderId);

            req.setAttribute("success", "Đã thanh toán thành công, chúng tôi sẽ gửi bạn email hóa đơn thông tin.");
            req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/my-shopping-cart.jsp").forward(req, resp);
        }
    }
}
