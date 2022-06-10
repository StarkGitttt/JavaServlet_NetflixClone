package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import dao.UserGoogleDAO;
import model.User;
import model.UserGoogle;

/**
 * Servlet implementation class MainServlet
 */
@WebServlet({"/index", "/index/login"})
public class MainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String code = request.getParameter("code");
		if(code == null || code.isEmpty()) {
			request.getRequestDispatcher("/views/index.jsp").forward(request, response);			
		} else {
			UserGoogleDAO uGoogleDAO = new UserGoogleDAO();
			UserDAO uDAO = new UserDAO();
			// Xử lí mã trả về từ google
			String accessToken = uGoogleDAO.getToken(code);
			// Sau khi xử lí mã có refresh token gửi lại cho gg để lấy authentication token để truy vấn dữ liệu
			UserGoogle uGoogle = uGoogleDAO.getUserInfo(accessToken);
			// Thực hiện cập nhập vào cơ sở dữ liệu
			uGoogleDAO.loginWithGoogle(uGoogle);
			// Lưu user vào session để thực hiện các chức năng
			User u = new User();
			u = uDAO.findUser(uGoogle.getEmail());
			request.getSession().setAttribute("user",u);
			request.getRequestDispatcher("/HomeServlet").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getRequestURI();
		if(uri.contains("login")) {
			UserDAO userDAO = new UserDAO();
			boolean isSuccess = userDAO.isLogin(request, response);
			if(isSuccess) {
				request.getRequestDispatcher("/HomeServlet").forward(request, response);
				return;
			}
		}
		doGet(request, response);
	}

}
