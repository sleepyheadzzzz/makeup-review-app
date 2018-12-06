package restful;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Data
@Entity // This tells Hibernate to make a table out of this class
public class Comment {
    @Id @GeneratedValue(strategy=GenerationType.AUTO)
    private Integer id;

    private Integer posterId;

    private Integer postId;

    private String comment;

    private Long timeStamp;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getPosterId() {
		return posterId;
	}

	public void setPosterId(Integer posterId) {
		this.posterId = posterId;
	}

	public Integer getPostId() {
		return postId;
	}

	public void setPostId(Integer postId) {
		this.postId = postId;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Long getTimeStamp() {
		return timeStamp;
	}

	public void setTimeStamp(Long timeStamp) {
		this.timeStamp = timeStamp;
	}

	Comment(Integer posterId, Integer postId, String comment, Long timeStamp) {
		this.posterId = posterId;
		this.postId = postId;
		this.comment = comment;
		this.timeStamp = timeStamp;
	}

}

