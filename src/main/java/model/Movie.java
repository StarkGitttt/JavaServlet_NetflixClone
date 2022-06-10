package model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.NamedStoredProcedureQueries;
import javax.persistence.NamedStoredProcedureQuery;
import javax.persistence.OneToMany;
import javax.persistence.StoredProcedureParameter;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
@NamedStoredProcedureQueries({
	@NamedStoredProcedureQuery(
			name ="Movie.riseView",
			procedureName = "sp_riseView",
			parameters = {
					@StoredProcedureParameter(name = "movieId", type = String.class)
				}
			),
	@NamedStoredProcedureQuery(
			name = "Movie.addMovie",
			procedureName = "sp_addMovie",
			parameters = {
					@StoredProcedureParameter(name = "categoryId", type = String.class),
					@StoredProcedureParameter(name = "title", type = String.class),
					@StoredProcedureParameter(name = "codeMovie", type = String.class),
					@StoredProcedureParameter(name = "description", type = String.class)
			}
			),
	@NamedStoredProcedureQuery(
			name = "Movie.updateMovie",
			procedureName = "sp_UpdateMovie",
			parameters = {
					@StoredProcedureParameter(name = "movieId", type = String.class),
					@StoredProcedureParameter(name = "title", type = String.class),
					@StoredProcedureParameter(name = "poster", type = String.class),
					@StoredProcedureParameter(name = "linkEmbed", type = String.class),
					@StoredProcedureParameter(name = "description", type = String.class),
					@StoredProcedureParameter(name = "views", type = Integer.class)
			}
			),
	@NamedStoredProcedureQuery(
			name = "Movie.deleteMovie",
			procedureName = "sp_setStatusMovie",
			parameters = {
					@StoredProcedureParameter(name = "movieId", type = String.class),
			}
			),
	@NamedStoredProcedureQuery(
			name = "Movie.newMovie",
			procedureName = "sp_newMovie",
			parameters = {
					@StoredProcedureParameter(name = "categoryId", type = String.class),
			},
			resultClasses = {Movie.class}
			)
})
@NamedNativeQueries({
	@NamedNativeQuery(
			name = "Movie.topPopularMovie",
			query = "SELECT TOP 10 m.* From Movie  AS m WHERE m.active = 'true' ORDER BY m.Views DESC",
			resultClass = Movie.class
	)
})
@NamedQueries({
	
	@NamedQuery(name ="Movie.findByCategory",
			query = "SELECT m FROM Movie m WHERE m.category.categoryId = :idCategory AND m.active = true "),
	
	@NamedQuery(name ="Movie.findById",
	query = "SELECT m FROM Movie m WHERE m.movieId = :idMovie AND m.active = true"),
	
	@NamedQuery(name = "Movie.searchMovie", 
	query = "SELECT m FROM Movie m WHERE m.title LIKE :title AND m.category.categoryId = :cid AND m.active = true"),
	
	@NamedQuery(name = "Movie.suggestMovie",
	query = "SELECT m FROM Movie m WHERE m.movieId NOT LIKE :mid AND m.active = true AND  m.category.categoryId IN "
			+ " ( SELECT m.category.categoryId FROM Movie m WHERE m.movieId = :mid AND m.active = true)"),
	
	@NamedQuery(name = "Movie.countMovie",
	query ="SELECT count(m) FROM Movie m WHERE m.active= true"),
	
	@NamedQuery(name = "Movie.countMovieToday",
	query ="SELECT count(m) FROM Movie m WHERE m.active= true AND m.datePost = :today"),
	
	@NamedQuery(name = "Movie.findAllByTitle",
	query = "SELECT m FROM Movie m WHERE m.active = true AND m.title LIKE :title"),
	
	@NamedQuery(name = "Movie.findMovieRemoved",
	query = "SELECT m FROM Movie m WHERE m.active = false AND m.title LIKE :title")
})
@Entity
@Table(name = "Movie")
@NamedQuery(name="Movie.findAll", query="SELECT m FROM Movie m WHERE m.active = true")
public class Movie implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name = "MovieId")
	private String movieId;
	
	@Column(name="Description")
	private String description;

	@Column(name="Poster")
	private String poster;
	
	@Column(name="Title")
	private String title;
	
	@Column(name="LinkEmbed")
	private String linkEmbed;
	
	@Column(name="Active")
	private boolean active;
	
	@Column(name="Views")
	private int views;
	
	@Temporal(TemporalType.DATE)
	@Column(name="DatePost")
	private Date datePost;
	
	//bi-directional many-to-one association to Category
	@ManyToOne
	@JoinColumn(name = "CategoryId")
	private Category category;
	
	//bi-directional many-to-one association to Favorite
	@OneToMany(mappedBy="movie")
	private List<Favorite> favorites;
	
	//bi-directional many-to-one association to Comment
	@OneToMany(mappedBy="movie")
	private List<Comment> comments;
	
	//bi-directional many-to-one association to Share
	@OneToMany(mappedBy="movie")
	private List<Share> shares;
	
	public Movie() {
	}

	public String getMovieId() {
		return movieId;
	}

	public void setMovieId(String movieId) {
		this.movieId = movieId;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPoster() {
		return poster;
	}

	public void setPoster(String poster) {
		this.poster = poster;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getLinkEmbed() {
		return linkEmbed;
	}

	public void setLinkEmbed(String linkEmbed) {
		this.linkEmbed = linkEmbed;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public Date getDatePost() {
		return datePost;
	}

	public void setDatePost(Date datePost) {
		this.datePost = datePost;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public List<Favorite> getFavorites() {
		return favorites;
	}

	public void setFavorites(List<Favorite> favorites) {
		this.favorites = favorites;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public List<Share> getShares() {
		return shares;
	}

	public void setShares(List<Share> shares) {
		this.shares = shares;
	}

	@Override
	public String toString() {
		return  title;
	}
	
}
