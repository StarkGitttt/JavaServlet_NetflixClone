package model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;


/**
 * The persistent class for the Visitor database table.
 * 
 */
@NamedQueries({
			@NamedQuery(
					name="Visitor.countVisit",
					query="SELECT count(v) FROM Visitor v"
					),
			@NamedQuery(
					name="Visitor.countVisitToday",
					query="SELECT count(v) FROM Visitor v WHERE v.dateVisit = :today"
					)
})
@Entity
@NamedQuery(name="Visitor.findAll", query="SELECT v FROM Visitor v")
public class Visitor implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="VisitId")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int visitId;

	@Temporal(TemporalType.DATE)
	@Column(name="DateVisit")
	private Date dateVisit;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="UserId")
	private User user;

	public Visitor() {
	}

	public int getVisitId() {
		return this.visitId;
	}

	public void setVisitId(int visitId) {
		this.visitId = visitId;
	}

	public Date getDateVisit() {
		return this.dateVisit;
	}

	public void setDateVisit(Date dateVisit) {
		this.dateVisit = dateVisit;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}