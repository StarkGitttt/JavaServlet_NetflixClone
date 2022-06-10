package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.StatisticsDAO;

/**
 * Servlet implementation class AdminController
 */
@WebServlet("/admin")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		StatisticsDAO sDAO = new StatisticsDAO();
		// Statistics General
		request.setAttribute("countUser", sDAO.countUser());
		request.setAttribute("countVisitor", sDAO.countVisitor());
		request.setAttribute("countMovie", sDAO.countMovie());
		request.setAttribute("countLike", sDAO.countLike());
		// Statistics Today
		request.setAttribute("countMovieToday", sDAO.countMovieToday());
		request.setAttribute("countVisitorToday", sDAO.countVisitorToday());
		request.setAttribute("countLikeToday", sDAO.countLikeToday());
		request.getRequestDispatcher("/views/admin.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		doGet(request, response);
	}

}
