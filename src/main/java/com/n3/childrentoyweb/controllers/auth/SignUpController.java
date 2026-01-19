package com.n3.childrentoyweb.controllers.auth;

import com.n3.childrentoyweb.exception.EmailAlreadyExistsException;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.AuthService;
import com.n3.childrentoyweb.services.CacheService;
import com.n3.childrentoyweb.services.EmailService;
import com.n3.childrentoyweb.services.UserService;
import com.n3.childrentoyweb.utils.OTPUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet(name = "signUp", value = "/sign-up")
public class SignUpController extends HttpServlet {
    private AuthService authService;
    private UserService userService;
    private CacheService cacheService;
    private EmailService emailService;

    @Override
    public void init() {
        this.authService = new AuthService();
        this.userService = new UserService();
        this.cacheService = CacheService.getInstance();
        this.emailService = EmailService.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/sign-up.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String otp;
        try {
            User user = (User) req.getSession().getAttribute("pendingUser");
            if (user == null) {
                user = new User(req.getParameter("firstName"),
                            req.getParameter("lastName"),
                            req.getParameter("phone"),
                            req.getParameter("gender"),
                            req.getParameter("email"),
                            req.getParameter("password"));
            }

            this.authService.validate(user, req.getParameter("confirmPassword"));
            this.userService.isEmailExist(user.getEmail());

            cacheService.remove(user.getEmail());

            otp = OTPUtil.generate();

            this.cacheService.add(user.getEmail(), otp);

            this.emailService.sendOtpEmail(user.getEmail(), otp);

            req.getSession().setAttribute("pendingUser", user);
            req.getRequestDispatcher("/common/verify-otp.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher( "/sign-up.jsp").forward(req, resp);
        }
    }
}
