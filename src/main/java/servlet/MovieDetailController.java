package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CommentDAO;
import dao.FavoriteDAO;
import dao.MovieDAO;
import dao.ShareDAO;
import model.Comment;
import model.Movie;
import model.User;
import utils.SendMail;

/**
 * Servlet implementation class MovieDetailController
 */
@WebServlet({ "/movie/view/*", "/like/movie/*", "/comment/movie/*", "/share/movie/*" })
public class MovieDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getRequestURI();
		String getIdMovie = uri.substring(uri.lastIndexOf("/") + 1);
		MovieDAO mDAO = new MovieDAO();
		FavoriteDAO fDAO = new FavoriteDAO();
		CommentDAO cDAO = new CommentDAO();
		Movie m = new Movie();
		m = mDAO.findMovie(getIdMovie);
		if(uri.contains("/like/movie")) {
			Movie movie = mDAO.findMovieById(getIdMovie);
			User user = (User) request.getSession().getAttribute("user");
			fDAO.addFav(user, movie);
		}
		if(uri.contains("/movie/view")) {
			mDAO.riseView(getIdMovie);
		}
		if(uri.contains("/share/movie")) {
			ShareDAO sDAO= new ShareDAO();
			String getMailCC = request.getParameter("emailCC");
			User user = (User) request.getSession().getAttribute("user");
			boolean isShare = sDAO.addShare(user, m, getMailCC);
			if(isShare) {
				SendMail.shareMovie(m, getMailCC);
				request.setAttribute("isSuccess", "Chia sẻ thành công");
			}
			
		}
		List<Object[]> objs = fDAO.countLikeByIdMovie(getIdMovie);
		String countLike = "";
		for (Object[] objects : objs) {
			countLike = objects[1].toString();
		}
		if (countLike.equals("")) {
			countLike = "0";
		}
		/* Kiểm tra User nếu thích phim sẽ Highlight nút Like */
		List<Movie> movies = fDAO.getFavMovieByUser((User) request.getSession().getAttribute("user"));
		/* Gợi ý phim */
		List<Movie> moviesSuggestion = mDAO.suggesstionMovie(getIdMovie);
		/* Load Comment */
		List<Comment> cmts = cDAO.getComents(m.getMovieId());
		/* Count Comment */
		Long countCmt = cDAO.countComment(m.getMovieId());
		request.setAttribute("countLike", countLike);
		request.setAttribute("movie", m);
		request.setAttribute("movies", movies);
		request.setAttribute("moviesSugesstion", moviesSuggestion);
		request.setAttribute("objs", objs);
		request.setAttribute("cmts", cmts);
		request.setAttribute("countCmt", countCmt);
		request.getRequestDispatcher("/views/assets/MovieDetail.jsp").forward(request,response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getRequestURI();
		CommentDAO cDAO = new CommentDAO();
		/* Lay gia tri tu form*/
		String getIdMovie = uri.substring(uri.lastIndexOf("/") + 1); 
		User u = (User) request.getSession().getAttribute("user");
		String content = request.getParameter("comment");
		cDAO.addComment(u.getUserId(), getIdMovie, content);
		doGet(request, response);
	}

}
