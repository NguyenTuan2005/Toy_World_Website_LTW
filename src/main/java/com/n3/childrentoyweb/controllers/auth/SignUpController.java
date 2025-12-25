package com.n3.childrentoyweb.controllers.auth;

import com.n3.childrentoyweb.dto.SignUpUserDTO;
import com.n3.childrentoyweb.exception.EmailAlreadyExistsException;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.AuthService;
import com.n3.childrentoyweb.services.CacheService;
import com.n3.childrentoyweb.services.EmailService;
import com.n3.childrentoyweb.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Random;
import java.util.logging.Logger;

@WebServlet(name = "signUp", value = "/sign-up")
public class SignUpController extends HttpServlet {
    private AuthService authService;
    private UserService userService;
    private CacheService cacheService;
    private EmailService emailService;

    private static final Logger log =
            Logger.getLogger(SignUpController.class.getName());

    @Override
    public void init() {
        this.authService = new AuthService();
        this.userService = new UserService();
        this.cacheService = new CacheService();
        this.emailService = new EmailService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/sign-up.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SignUpUserDTO signUpUserDTO = new SignUpUserDTO(new User(req.getParameter("firstName"),
                                                req.getParameter("lastName"),
                                                req.getParameter("phone"),
                                                req.getParameter("gender"),
                                                req.getParameter("email"),
                                                req.getParameter("password")),
                                                req.getParameter("confirmPassword"));
        try {
            this.authService.validate(signUpUserDTO);
            this.userService.isEmailExist(signUpUserDTO.getUser().getEmail());

            String otp = String.format("%06d", new Random().nextInt(999999));
            this.cacheService.add(signUpUserDTO.getUser().getEmail(),otp);

            this.emailService.sendOtpEmail(signUpUserDTO.getUser().getEmail(), otp);

            req.getRequestDispatcher("/common/verify-otp.jsp").forward(req, resp);
        } catch (IllegalArgumentException | EmailAlreadyExistsException e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher( "/sign-up.jsp").forward(req, resp);
        }
    }
}
