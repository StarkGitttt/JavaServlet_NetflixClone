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
import dao.MovieDAO;
import model.Movie;

/**
 * Servlet implementation class MovieCategoryController
 */
@WebServlet({"/movies/view/*", "/search/movie"})
public class MovieCategoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int maxPageSize = 8;
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String uri = request.getRequestURI();
		if(uri.contains("/view")) {
			String getIdCategory = uri.substring(uri.lastIndexOf("/") +1);
			String pageNumber = request.getParameter("page");
			MovieDAO mDAO = new MovieDAO();
			CategoryDAO cDAO = new CategoryDAO();
			List<Movie> countMovie = mDAO.getMovies(getIdCategory);
			List<Movie> movies;
			if(pageNumber == null) {
				movies = mDAO.findMovieByCategory(getIdCategory, 0, maxPageSize);
				request.setAttribute("currentPage", 1);
			} else {
//				int currentIndex = (int) request.getAttribute("currentPage");
				movies = mDAO.findMovieByCategory(getIdCategory, Integer.parseInt(pageNumber), maxPageSize);
				request.setAttribute("currentPage", Integer.parseInt(pageNumber));
			}
			int maxPage =(int) Math.ceil( countMovie.size() / (double) maxPageSize);
			request.setAttribute("cid", getIdCategory);
			request.setAttribute("movies", movies);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("category", cDAO.getCategoryById(getIdCategory));
		}
		request.getRequestDispatcher("/views/assets/MovieCategory.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getRequestURI();
		if(uri.contains("/search/movie")) {
			String getTitlte = request.getParameter("nameMovie");
			MovieDAO mDAO = new MovieDAO();
			Map<String, List<Movie>> movies = mDAO.searchMovie(getTitlte);
			request.setAttribute("categorys", movies);
			request.getRequestDispatcher("/views/assets/MovieSearch.jsp").forward(request, response);
			return;
		}
		doGet(request, response);
	}

}
