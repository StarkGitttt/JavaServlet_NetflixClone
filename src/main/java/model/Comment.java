package model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityManager;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.NamedStoredProcedureQueries;
import javax.persistence.NamedStoredProcedureQuery;
import javax.persistence.StoredProcedureParameter;
import javax.persistence.StoredProcedureQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import utils.JpaUtils;
@NamedStoredProcedureQueries(
		@NamedStoredProcedureQuery(
				name = "Comment.Insert",
				procedureName = "sp_InsertComment",
				parameters = {
						@StoredProcedureParameter(name = "userId", type=String.class),
						@StoredProcedureParameter(name = "movieId", type=String.class),
						@StoredProcedureParameter(name = "content", type=String.class)
								}
				)
		)
@NamedQueries({
	@NamedQuery(name="Comment.findAllSort",
			query = "SELECT c FROM Comment c WHERE c.movie.movieId = :mid  ORDER BY c.dateComment DESC"),
	@NamedQuery(name = "Comment.countCmt",
			query = "SELECT COUNT(c) FROM Comment c WHERE c.movie.movieId = :mid")
})
@Entity
@Table(name = "Comment")
@NamedQuery(name="Comment.findAll", query="SELECT c FROM Comment c")
public class Comment implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name = "CommentId")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int commentId;
	
	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="UserId")
	private User user;
	
	//bi-directional many-to-one association to Movie
	@ManyToOne
	@JoinColumn(name="MovieId")
	private Movie movie;
	
	@Column(name="Content")
	private String content;
	
	@Temporal(TemporalType.DATE)
	@Column(name="DateComment")
	private Date dateComment;
	
	public Comment() {
	}

	public int getCommentId() {
		return commentId;
	}

	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Movie getMovie() {
		return movie;
	}

	public void setMovie(Movie movie) {
		this.movie = movie;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getDateComment() {
		return dateComment;
	}

	public void setDateComment(Date dateComment) {
		this.dateComment = dateComment;
	}
	public static void main(String[] args) {
		EntityManager em = JpaUtils.getEntityManager();
		StoredProcedureQuery query = em.createNamedStoredProcedureQuery("Comment.Insert");
		query.setParameter("userId", "lcphan512@gmail.com");
		query.setParameter("movieId", "MI005");
		query.setParameter("content", "Phim hay");
		try {
			em.getTransaction().begin();
			int result = query.executeUpdate();
			if(result>0) {
				System.out.println("Success");
			}
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
		}
	}
}
