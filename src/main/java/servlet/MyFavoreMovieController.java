package servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.FavoriteDAO;
import dao.UserDAO;
import model.Movie;
import model.User;

/**
 * Servlet implementation class MyFavoreMovieController
 */
@WebServlet("/MyFavoreMovieController")
public class MyFavoreMovieController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		UserDAO uDAO =new UserDAO();
		FavoriteDAO favDAO = new FavoriteDAO();
		User u = (User) request.getSession().getAttribute("user");
		Map<String, List<Movie>> movies = uDAO.myFavMovies(u.getUserId());
		/* Xử lý highligh Phim đã Like của User*/
		List<Movie> favMoviesByUser = favDAO.getFavMovieByUser((User) request.getSession().getAttribute("user"));
		request.getSession().setAttribute("favMoviesByUser", favMoviesByUser);	
		/* Thống kê lượt thích của từng bộ phim */		
		Map<String, Integer> moviesLike = favDAO.countLike();
		request.getSession().setAttribute("moviesLike", moviesLike);
		request.setAttribute("movies", movies);
		request.getRequestDispatcher("/views/assets/MyFavMovie.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
