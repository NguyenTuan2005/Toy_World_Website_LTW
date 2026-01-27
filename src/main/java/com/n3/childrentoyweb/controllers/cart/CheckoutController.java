package com.n3.childrentoyweb.controllers.cart;

import com.n3.childrentoyweb.enums.OrderStatus;
import com.n3.childrentoyweb.enums.PaymentMethod;
import com.n3.childrentoyweb.enums.PaymentStatus;
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

    @Override
    public void init() throws ServletException {
        this.locationService = new LocationService();
        this.paymentService = new PaymentService();
        this.orderService = new OrderService();
        this.userService = new UserService();
        this.emailService = EmailService.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user;
        Cart cart = (Cart) req.getSession().getAttribute(Cart.CART);
        try {
            if ((user = (User) req.getSession().getAttribute("currentUser")) == null)
                throw new DataInvalidException("Bạn hãy vui lòng đăng nhập");
            if (cart == null || cart.getTotalQuantity() == 0)
                throw new DataInvalidException("Giỏ hàng trống");

            if (user.getLocationId() != null) {
                Location location = locationService.findByUserId(user.getId());
                req.setAttribute("location", location);
            }

            List<PaymentMethod> paymentMethods = paymentService.findAllPaymentMethod();
            req.setAttribute("paymentMethods", paymentMethods);

            req.getRequestDispatcher("/checkout.jsp").forward(req,resp);
        } catch (DataInvalidException e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/my-shopping-cart.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user;
        Cart cart = (Cart) req.getSession().getAttribute(Cart.CART);
        try {
            if ((user = (User) req.getSession().getAttribute("currentUser")) == null)
                throw new DataInvalidException("Bạn hãy vui lòng đăng nhập");
            if (cart == null || cart.getTotalQuantity() == 0)
                throw new DataInvalidException("Giỏ hàng trống");

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

            Order order = new Order(user.getId(), cart.getTotalPrice(), cart.getTotalPromotion(), OrderStatus.IN_PREPARE.getStatus());
            long orderId = this.orderService.save(order);

            List<CartItem> items = cart.getCartItems();
            for (CartItem item : items) {
                OrderDetail detail = new OrderDetail(orderId, item.getProductId(), item.getQuantity());
                this.orderService.saveOrderDetail(detail);
            }

            String paymentMethodName = req.getParameter("paymentMethod");
            if (paymentMethodName == null || paymentMethodName.trim().isEmpty())
                throw new DataInvalidException("Thông tin phương thức thanh toán không hợp lệ");

            long paymentMethodId = this.paymentService.findPaymentMethodIdByName(paymentMethodName);

            Payment payment = new Payment(paymentMethodId, orderId, cart.getTotalCost(), PaymentStatus.SUCCESS.getStatus());
            this.paymentService.save(payment);

            emailService.sendCheckoutEmail(user, cart, location, orderId, payment);

            req.getSession().setAttribute(Cart.CART, new Cart());
            req.setAttribute("success", "Đã thanh toán thành công, chúng tôi sẽ gửi bạn email hóa đơn thông tin.");
            req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/my-shopping-cart.jsp").forward(req, resp);
        }
    }
}
