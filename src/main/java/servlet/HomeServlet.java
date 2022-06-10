package servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CategoryDAO;
import dao.FavoriteDAO;
import dao.MovieDAO;
import dao.UserDAO;
import dao.VisitorDAO;
import model.Category;
import model.Movie;
import model.User;

/**
 * Servlet implementation class HomeServlet
 */
@WebServlet({"/HomeServlet"})
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Init DAO
		MovieDAO movieDAO = new MovieDAO();
		CategoryDAO categoryDAO = new CategoryDAO();
		UserDAO userDAO = new UserDAO();
		FavoriteDAO favDAO = new FavoriteDAO();
		VisitorDAO visitDAO = new VisitorDAO();
		// Add visitor website
		visitDAO.addVisitor((User) request.getSession().getAttribute("user"));
		// Get list
		/* Thống kê tóp 10 phim yêu thích */
			List<Movie> movies = movieDAO.topPopularMovie();
			request.setAttribute("popularMovies", movies);
		/* Xử lý highligh Phim đã Like của User*/
			List<Movie> favMoviesByUser = favDAO.getFavMovieByUser((User) request.getSession().getAttribute("user"));
			request.getSession().setAttribute("favMoviesByUser", favMoviesByUser);			
		/* Hiển thị danh mục phim vào Submenu */
			List<Category> categorys = categoryDAO.getCategorys();		
			request.getSession().setAttribute("categorysByName", categorys);		
		/* View toàn bộ phim theo danh mục */
			Map<String, List<Movie>> moviesByCategory = movieDAO.getMovieByCategory();
			request.setAttribute("categorys", moviesByCategory);			
		/* Thống kê lượt thích của từng bộ phim */		
			Map<String, Integer> moviesLike = favDAO.countLike();
			request.getSession().setAttribute("moviesLike", moviesLike);			

		// Set Attr
		request.getRequestDispatcher("/views/assets/Home.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
