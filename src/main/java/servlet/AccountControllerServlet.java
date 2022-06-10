package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import model.User;
import utils.XForm;

/**
 * Servlet implementation class AccountControllerServlet
 */
@WebServlet({ "/account/logout", "/account/change-password", "/account/update-infor", "/account/sign-up" })
public class AccountControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getRequestURI();
		if(uri.contains("logout")) {
			request.getSession().removeAttribute("user");
			request.getRequestDispatcher("/index").forward(request, response);			
			return;
		} else if(uri.contains("change-password")) {
			request.getRequestDispatcher("/views/assets/ChangePassword.jsp").forward(request, response);			
			return;
		} else if(uri.contains("sign-up")) {
			request.getRequestDispatcher("/views/assets/sign-up.jsp").forward(request, response);			
			return;
		}
		request.getRequestDispatcher("/HomeServlet").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getRequestURI();
		if(uri.contains("update-infor")) {
			UserDAO uDAO = new UserDAO();
			User uSession = (User) request.getSession().getAttribute("user");
			User u = new User();
			u = XForm.getBean(User.class, request, response);
			boolean isSucess = true;
			if(u.getFullname().equals("")) {
				isSucess = false;
				request.setAttribute("errUpdateName", "Vui lòng không bỏ trống ");
			} 
			if(u.getEmail().equals("")) {
				isSucess = false;
				request.setAttribute("errUpdateEmail", "Vui lòng không bỏ trống ");
			}
			if(isSucess) {
				u.setPassword(uSession.getPassword());
				u.setAdmin(uSession.getAdmin());
				boolean isUpdate = uDAO.updateUser(u);
				if(isUpdate) {
					request.setAttribute("isSuccess", "Cập nhập thành công");
					request.getSession().setAttribute("user", u);
				}				
			}
			
		} else if(uri.contains("change-password")) {
			User u = (User) request.getSession().getAttribute("user");
			Boolean isChange = true;
			String userId = u.getUserId();
			String oldPassSession = u.getPassword();
			String oldPassForm = request.getParameter("passwordOld");
			String newPass = request.getParameter("passwordNew");
			String confirmPass = request.getParameter("passwordConfirm");
			// Check required
			if(oldPassForm.equals("") || newPass.equals("") || confirmPass.equals("")) {
				request.setAttribute("errRequired", "Vui lòng không bỏ trống");
				request.getRequestDispatcher("/views/assets/ChangePassword.jsp").forward(request, response);
				return;
			}
			if(!oldPassSession.equals(oldPassForm)) {
				request.setAttribute("errPassOldSession", "Mật khẩu cũ không hợp lệ");
				isChange = false;
			}
			if(!newPass.equals(confirmPass)) {
				request.setAttribute("confirmPass", confirmPass);
				request.setAttribute("errPassConfirm", "Xác nhận mật khẩu không chính xác");
				isChange = false;
			}
			if(isChange) {
				UserDAO uDAO = new UserDAO();
				// Cập nhập lại mật khẩu bên trong Session
				u.setPassword(confirmPass);
				request.getSession().setAttribute("user", u);
				request.setAttribute("isSuccess", "Cập nhập mật khẩu thành công");
				uDAO.changePass(userId, confirmPass);
			}
			request.getRequestDispatcher("/views/assets/ChangePassword.jsp").forward(request, response);
			return;
		} else if(uri.contains("sign-up")) {
			User u =  XForm.getBean(User.class, request, response);
			UserDAO uDAO = new UserDAO();
			/* Giu lai tai khoan*/
			request.setAttribute("username", u.getUserId());
			/* Kiem tra rong */
			if(u.getUserId().equals("") || u.getPassword().equals("")|| u.getEmail().equals("")) {
				request.setAttribute("isRequired", "Vui lòng không để trống trường nào!");
			} else {
					/* Kiem tra User da ton tai hay chua*/
					boolean isExist = uDAO.isExistUser(u.getUserId());
					if(!isExist) {
						/* Kiem tra xac nhan mat khau co chinh xac*/
						String password = u.getPassword();
						String passwordConfirm = request.getParameter("passwordConfirm");
						if(password.equals(passwordConfirm)) {
							boolean isSignup = uDAO.signUp(u);
							if(isSignup) {
								request.setAttribute("isSuccess", "Tạo tài khoản thành công");	
							} 						
						} else {
							request.setAttribute("errConfirmPass", "Vui lòng nhập mật khẩu chính xác");	
						}
					} else {
						request.setAttribute("isExistUser", "Tài khoản đã tồn tại");			
					}
			}
			request.getRequestDispatcher("/views/assets/sign-up.jsp").forward(request, response);
			return;
		}
		request.getRequestDispatcher("/HomeServlet").forward(request, response);
	}

}
