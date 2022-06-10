package model;

import java.io.Serializable;
import javax.persistence.*;


import java.util.List;


/**
 * The persistent class for the Category database table.
 * 
 */
@NamedQueries({
	@NamedQuery(name= "Category.findMovie", 
			query="SELECT c From Category c WHERE c.categoryId IN"
					+ " (SELECT DISTINCT m.category.categoryId From Movie m)"),
	
	@NamedQuery(name= "Category.findMovieById",
	query = "SELECT m From Movie m WHERE m.category.categoryId = :id AND m.active = true"),
	
	@NamedQuery(name = "Category.searchMovie",
	query = "SELECT DISTINCT m.category FROM Movie m WHERE m.title LIKE :title AND m.active = true"),
	
	@NamedQuery(name = "Category.findById",
	query = "SELECT c From Category c WHERE c.categoryId = :id"),
	
	@NamedQuery(name = "Category.findByUserId",
	query = "SELECT DISTINCT f.movie.category From Favorite f WHERE f.user.userId = :uid AND f.isLike = :isLike")
})
@NamedNativeQueries({
	@NamedNativeQuery(
			name = "Category.newMovie",
			query = "SELECT DISTINCT C_Main.* FROM dbo.Category AS C_Main INNER JOIN "
					+ "(SELECT TOP 10 C.CategoryId FROM dbo.Movie AS M INNER JOIN dbo.Category AS C"
					+ " ON C.CategoryId = M.CategoryId"
					+ " ORDER BY M.DatePost DESC ) AS C_Temp"
					+ " ON C_Temp.CategoryId = C_Main.CategoryId ",
			resultClass = Category.class
	)
})
@Entity
@Table(name = "Category")
@NamedQuery(name="Category.findAll", query="SELECT c FROM Category c")
public class Category implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="CategoryId")
	private String categoryId;

	@Column(name="NameCategory")
	private String nameCategory;

	//bi-directional many-to-one association to Movie
	@OneToMany(mappedBy="category")
	private List<Movie> movies;

	public Category() {
	}

	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	public String getNameCategory() {
		return nameCategory;
	}

	public void setNameCategory(String nameCategory) {
		this.nameCategory = nameCategory;
	}

	public List<Movie> getMovies() {
		return movies;
	}

	public void setMovies(List<Movie> movies) {
		this.movies = movies;
	}

	

//	public Movie addMovy(Movie movy) {
//		getMovies().add(movy);
//		movy.setCategory(this);
//
//		return movy;
//	}
//
//	public Movie removeMovy(Movie movy) {
//		getMovies().remove(movy);
//		movy.setCategory(null);
//
//		return movy;
//	}


}