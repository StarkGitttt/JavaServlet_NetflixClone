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
import model.Category;
import model.Movie;
import utils.XForm;

/**
 * Servlet implementation class ManagerMovieController
 */
@WebServlet({ "/movie/add", "/movie/update", "/movie/delete", "/movie/restore" })
public class ManagerMovieController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String title;
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getRequestURI();
		title = request.getParameter("search");
		if(title == null) {
			title = "";
		}
		if(uri.contains("add")) {
			CategoryDAO cDAO = new CategoryDAO();
			List<Category> categorys = cDAO.getCategoryAll();
			request.setAttribute("categorys", categorys);
			request.getRequestDispatcher("/views/assets/pages/forms/AddMovie.jsp").forward(request, response);
			return;
		} else if(uri.contains("update")) {
			MovieDAO mDAO = new MovieDAO();
			FavoriteDAO fDAO = new FavoriteDAO();
			// Xử lý đếm lượt thích cho từng Phim
			Map<String, Integer> movieLike = fDAO.countLike();
			// Lấy phim theo tiêu đề (Mặc định là lấy tất cả)
			List<Movie> movies = mDAO.getMoviesAll(title);
			String getIdMovie = request.getParameter("mid");
			if(getIdMovie != null) {
				Movie m  = mDAO.findMovie(getIdMovie);
				request.setAttribute("movie", m);
			}
			request.setAttribute("movies", movies);
			request.setAttribute("movieLike",movieLike);
			request.getRequestDispatcher("/views/assets/pages/tables/UpdateMovie.jsp").forward(request, response);
			return;
		} else if(uri.contains("delete")) {
			MovieDAO mDAO = new MovieDAO();
			FavoriteDAO fDAO = new FavoriteDAO();
			Map<String, Integer> movieLike = fDAO.countLike();
			List<Movie> movies = mDAO.getMoviesAll(title);
			request.setAttribute("movies", movies);
			request.setAttribute("movieLike",movieLike);
			request.getRequestDispatcher("/views/assets/pages/tables/UpdateMovie.jsp").forward(request, response);
		} else if(uri.contains("restore")) {
			MovieDAO mDAO = new MovieDAO();
			FavoriteDAO fDAO = new FavoriteDAO();
			// Xử lý phục hồi phim
			String getIdMovie = request.getParameter("mid");
			if(getIdMovie != null) {
				mDAO.deleteMovie(getIdMovie);
			}
			// Xử lý đếm lượt thích cho từng Phim
			Map<String, Integer> movieLike = fDAO.countLike();
			// Lấy những phim đã xóa
			List<Movie> movies = mDAO.getMovieRemoved(title);
			request.setAttribute("movies", movies);
			request.setAttribute("movieLike",movieLike);
			request.getRequestDispatcher("/views/assets/pages/tables/RestoreMovie.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getRequestURI();
		if(uri.contains("add")) {
			// Lấy thông tin
			String getCategoryId = request.getParameter("category");
			String getTitle = request.getParameter("namemovie");
			String getCodeMovie = request.getParameter("codeembed");
			String getDescription = request.getParameter("description");
			boolean isValid = true;
			if(getTitle.equals("")) {
				request.setAttribute("emptyTitle", "Vui lòng nhập trường này");
				isValid = false;			
			}
			if(getCodeMovie.equals("")) {
				request.setAttribute("emptyCodeMovie", "Vui lòng nhập trường này");
				isValid = false;
			}
			if(isValid) {
				// Thêm phim
				MovieDAO mDAO = new MovieDAO();
				mDAO.addMovie(getCategoryId, getTitle, getCodeMovie, getDescription);
				request.setAttribute("isSuccess", "Thêm phim thành công");				
			}
		} else if(uri.contains("update")) {
			Movie m = XForm.getBean(Movie.class, request, response);
			boolean isValid = true;
			if(m.getMovieId().equals("")) {
				request.setAttribute("emptyMovieId", "Vui lòng nhập trường này");
				isValid = false;
			}
			if(m.getTitle().equals("")) {
				request.setAttribute("emptyTitle", "Vui lòng nhập trường này");
				isValid = false;						
			}
			if(m.getPoster().equals("")) {			
				request.setAttribute("emptyPoster", "Vui lòng nhập trường này");
				isValid = false;
			}
			if(m.getLinkEmbed().equals("")) {
				request.setAttribute("emptyLinkEmbed", "Vui lòng nhập trường này");
				isValid = false;				
			}
			if(isValid) {
				MovieDAO mDAO = new MovieDAO();
				mDAO.updateMovie(m);
				request.setAttribute("isSuccess", "Cập nhập thành công");
			}
		} else if(uri.contains("delete")) {
			String idMovie = request.getParameter("movieId");
			if(!idMovie.equals("")) {
				MovieDAO mDAO = new MovieDAO();
				mDAO.deleteMovie(idMovie);
				request.setAttribute("isSuccess", "Xóa thành công");
			} else {
				request.setAttribute("emptyMovieId", "Vui lòng nhập trường này");
			}
		}
		doGet(request, response);
	}

}
