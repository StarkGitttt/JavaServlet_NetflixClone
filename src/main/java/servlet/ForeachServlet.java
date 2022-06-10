package servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Category;
import model.Movie;
import utils.JpaUtils;

/**
 * Servlet implementation class ForeachServlet
 */
@WebServlet("/ForeachServlet")
public class ForeachServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		getMovies(request, response);
//		getCategory(request, response);
//		getMoviesByCategory(request, response);
		request.getRequestDispatcher("/views/ForeachServlet.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
	public void getMovies(HttpServletRequest request, HttpServletResponse response) {
		EntityManager em = JpaUtils.getEntityManager();
		TypedQuery<Movie> query = em.createNamedQuery("Movie.findAll", Movie.class);
		List<Movie> movies = query.getResultList();
		request.setAttribute("movies",movies);
	}
	public void getCategory(HttpServletRequest request, HttpServletResponse response) {
		EntityManager em = JpaUtils.getEntityManager();
		TypedQuery<Category> query = em.createNamedQuery("Category.findAll", Category.class);
		List<Category> categorys = query.getResultList();
		request.setAttribute("categorys", categorys);
	}
	public void getMoviesByCategory(HttpServletRequest request, HttpServletResponse response) {
		EntityManager em = JpaUtils.getEntityManager();
		TypedQuery<Category> query = em.createNamedQuery("Category.findAll", Category.class);
		List<Category> categorys = query.getResultList();
		Map<String, List<Movie>> movies = new HashMap<>();
		for (Category category : categorys) {
			String idCategory = category.getCategoryId();
			String jpql = "SELECT m FROM Movie m WHERE m.category.categoryId = :idCategory";
			TypedQuery<Movie> query2 = em.createQuery(jpql, Movie.class);
			query2.setParameter("idCategory", idCategory);
			List<Movie> movies2 = query2.getResultList();
			movies.put(category.getNameCategory(), movies2);
		}
		request.setAttribute("movies", movies);
	}
}
