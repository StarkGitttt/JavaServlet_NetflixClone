package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.FavoriteDAO;
import dao.MovieDAO;
import model.Movie;
import model.User;

/**
 * Servlet implementation class ControllerMovieServlet
 */
@WebServlet({"/movie/like/*", "/movie/fav/like", "/movie/new"})
public class MovieControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getRequestURI();
		FavoriteDAO fDAO = new FavoriteDAO();
		MovieDAO mDAO = new MovieDAO();
		if(uri.contains("fav/like")) {
			String getIdMovie = request.getParameter("id");
			Movie movie = mDAO.findMovieById(getIdMovie);
			User user = (User) request.getSession().getAttribute("user");
			fDAO.addFav(user, movie);
			request.getRequestDispatcher("/MyFavoreMovieController").forward(request, response);	
		} else if(uri.contains("/movie/like")) {
			String getIdMovie = uri.substring(uri.lastIndexOf("/") + 1);
			Movie movie = mDAO.findMovieById(getIdMovie);
			User user = (User) request.getSession().getAttribute("user");
			boolean isSuccess = fDAO.addFav(user, movie);
			if(isSuccess) {
				request.getRequestDispatcher("/HomeServlet").forward(request, response);
				return;
			} else {
				System.out.println("Error");
			}	
		} else if(uri.contains("movie/new")) {
			request.setAttribute("movies", mDAO.newMovie());
			request.getRequestDispatcher("/views/assets/PopularMovie.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
