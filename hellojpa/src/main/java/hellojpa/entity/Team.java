package hellojpa.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Team {
	@Id @GeneratedValue
	private Long id;
	private String  name;
	
	@OneToMany(mappedBy = "team")
	private List<Member> members =new ArrayList<>();

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Member> getMembers() {
		return members;
	}

	public void setMembers(List<Member> members) {
		this.members = members;
	}

	

	public Team(Long id, String name, List<Member> members) {
		super();
		this.id = id;
		this.name = name;
		this.members = members;
	}
	
	public Team() {
		// TODO Auto-generated constructor stub
	}
	

}
