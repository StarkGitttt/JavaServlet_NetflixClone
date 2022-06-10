package model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;


/**
 * The persistent class for the Share database table.
 * 
 */
@Entity
@NamedQuery(name="Share.findAll", query="SELECT s FROM Share s")
public class Share implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="ShareId")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int shareId;
	
	@Temporal(TemporalType.DATE)
	@Column(name="DateShare")
	private Date dateShare;

	@Column(name="Email")
	private String email;

	//bi-directional many-to-one association to Movie
	@ManyToOne
	@JoinColumn(name="MovieId")
	private Movie movie;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="UserId")
	private User user;

	public Share() {
	}

	public int getShareId() {
		return this.shareId;
	}

	public void setShareId(int shareId) {
		this.shareId = shareId;
	}

	public Date getDateShare() {
		return this.dateShare;
	}

	public void setDateShare(Date dateShare) {
		this.dateShare = dateShare;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Movie getMovie() {
		return this.movie;
	}

	public void setMovie(Movie movie) {
		this.movie = movie;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}