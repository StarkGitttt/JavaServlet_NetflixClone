package model;

import java.io.Serializable;
import javax.persistence.*;

import utils.JpaUtils;

import java.util.List;


/**
 * The persistent class for the User database table.
 * 
 */
/* STORE PROCEDURE*/
@NamedStoredProcedureQueries({
		@NamedStoredProcedureQuery(
				name = "User.changePassword",
				procedureName = "sp_changePassword",
				parameters = {
						@StoredProcedureParameter(name = "userId", type = String.class),
						@StoredProcedureParameter(name = "password", type = String.class),
				}
			),
		@NamedStoredProcedureQuery(
				name = "User.statisticsUser",
				procedureName = "sp_StatisticsUsers"
				),
		@NamedStoredProcedureQuery(
				name = "User.loginGoogle",
				procedureName = "sp_loginGoogle",
				parameters = {
						@StoredProcedureParameter(name = "userId", type = String.class),
						@StoredProcedureParameter(name = "fullname", type = String.class),
						@StoredProcedureParameter(name = "email", type = String.class)
				}
			),
})
@NamedQueries({
		@NamedQuery( name = "User.countUser",
				query = "SELECT count(u) From User u ")	
		})
@Entity
@Table(name = "[User]")
@NamedQuery(name="User.findAll", query="SELECT u FROM User u")
public class User implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="UserId")
	private String userId;

	@Column(name="Admin")
	private boolean admin;

	@Column(name="Email")
	private String email;

	@Column(name="Fullname")
	private String fullname;

	@Column(name="Password")
	private String password;

	//bi-directional many-to-one association to Share
	@OneToMany(mappedBy="user")
	private List<Share> shares;

	//bi-directional many-to-one association to Visitor
	@OneToMany(mappedBy="user")
	private List<Visitor> visitors;

	//bi-directional many-to-one association to Favorite
	@OneToMany(mappedBy="user")
	private List<Favorite> favorites;

	//bi-directional many-to-one association to Comment
	@OneToMany(mappedBy="user")
	private List<Comment> comments;

	public User() {
	}

	public String getUserId() {
		return this.userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public boolean getAdmin() {
		return this.admin;
	}

	public void setAdmin(boolean admin) {
		this.admin = admin;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFullname() {
		return this.fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public List<Share> getShares() {
		return this.shares;
	}

	public void setShares(List<Share> shares) {
		this.shares = shares;
	}

	public Share addShare(Share share) {
		getShares().add(share);
		share.setUser(this);

		return share;
	}

	public Share removeShare(Share share) {
		getShares().remove(share);
		share.setUser(null);

		return share;
	}

	public List<Visitor> getVisitors() {
		return this.visitors;
	}

	public void setVisitors(List<Visitor> visitors) {
		this.visitors = visitors;
	}

	public Visitor addVisitor(Visitor visitor) {
		getVisitors().add(visitor);
		visitor.setUser(this);

		return visitor;
	}

	public Visitor removeVisitor(Visitor visitor) {
		getVisitors().remove(visitor);
		visitor.setUser(null);

		return visitor;
	}

	public List<Favorite> getFavorites() {
		return this.favorites;
	}

	public void setFavorites(List<Favorite> favorites) {
		this.favorites = favorites;
	}

	public Favorite addFavorite(Favorite favorite) {
		getFavorites().add(favorite);
		favorite.setUser(this);

		return favorite;
	}

	public Favorite removeFavorite(Favorite favorite) {
		getFavorites().remove(favorite);
		favorite.setUser(null);

		return favorite;
	}

	public List<Comment> getComments() {
		return this.comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public Comment addComment(Comment comment) {
		getComments().add(comment);
		comment.setUser(this);

		return comment;
	}

	public Comment removeComment(Comment comment) {
		getComments().remove(comment);
		comment.setUser(null);

		return comment;
	}
	public static void main(String[] args) {
		EntityManager em = JpaUtils.getEntityManager();
		String jpql = "SELECT u From User u";
		TypedQuery<User> query = em.createQuery(jpql, User.class);
		List<User> users = query.getResultList();
		for (User user : users) {
			System.out.println(user.getFullname());
		}
	}
}	