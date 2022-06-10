package model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;


/**
 * The persistent class for the Favorites database table.
 * 
 */

@NamedStoredProcedureQueries({
	@NamedStoredProcedureQuery(
			name = "Favorite.spInserFav",
			procedureName = "sp_setNotLike",
			parameters = {
					@StoredProcedureParameter(name = "movieId", type = String.class),
					@StoredProcedureParameter(name = "userId", type =  String.class)}
	),
	@NamedStoredProcedureQuery(
			name = "Favorite.spMyFav",
			procedureName = "sp_myFavMovie",
			parameters = {
					@StoredProcedureParameter(name = "userId", type = String.class),
					@StoredProcedureParameter(name = "categoryId", type = String.class),
				},
			resultClasses = {Movie.class}
			)

})
@NamedQueries({
	@NamedQuery( name = "Favorite.countLike",
			query = "SELECT f.movie.movieId, count(f) From Favorite f WHERE f.isLike = :isLike AND f.movie.active = true"
					+ " GROUP BY f.movie.movieId"),
	@NamedQuery( name = "Favorite.findByUser",
			query = "SELECT f.movie From Favorite f WHERE f.user.userId = :uid AND f.isLike = :isLike"),
	@NamedQuery( name = "Favorite.findUserAndMovie",
			query = "SELECT f.movie From Favorite f WHERE f.user.userId = :uid AND f.movie.movieId = :mid"),
	@NamedQuery( name = "Favorite.countLikeById",
	        query = "SELECT f.movie.movieId, count(f) From Favorite f WHERE f.isLike = :isLike "
			+ " AND f.movie.movieId = :mid GROUP BY f.movie.movieId"),
	@NamedQuery(name = "Favorite.countsLike",
			query = "SELECT count(f) From Favorite f WHERE f.movie.active = true AND f.isLike = true"
			),
	@NamedQuery(name = "Favorite.countsLikeToday",
	query = "SELECT count(f) From Favorite f WHERE f.movie.active = true AND f.isLike = true AND f.likeDate = :today"
	)
})

@NamedQuery(name="Favorite.findAll", query="SELECT f FROM Favorite f WHERE f.isLike = 1")
@Entity
@Table(name="Favorite", uniqueConstraints = {
		@UniqueConstraint(columnNames = {"MovieId", "UserID"})
})
public class Favorite implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="FavId")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int favId;
	
	@Temporal(TemporalType.DATE)
	@Column(name="LikeDate")
	private Date likeDate;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="UserID")
	private User user;

	//bi-directional many-to-one association to Movie
	@ManyToOne
	@JoinColumn(name="MovieId")
	private Movie movie;
	
	@Column(name="IsLike")
	private Boolean isLike;
	
	public Favorite() {
	}

	public int getFavId() {
		return this.favId;
	}

	public void setFavId(int favId) {
		this.favId = favId;
	}

	public Date getLikeDate() {
		return this.likeDate;
	}

	public void setLikeDate(Date likeDate) {
		this.likeDate = likeDate;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Boolean getIsLike() {
		return isLike;
	}

	public void setIsLike(Boolean isLike) {
		this.isLike = isLike;
	}

	public Movie getMovie() {
		return this.movie;
	}

	public void setMovie(Movie movie) {
		this.movie = movie;
	}
	
}