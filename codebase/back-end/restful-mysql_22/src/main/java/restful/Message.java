package restful;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Data
@Entity // This tells Hibernate to make a table out of this class
public class Message {
    @Id @GeneratedValue(strategy=GenerationType.AUTO)
    private Integer id;

    private Integer posterId;

    private Integer receiverId;

    private String text;

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

	public Integer getReceiverId() {
		return receiverId;
	}

	public void setReceiverId(Integer receiverId) {
		this.receiverId = receiverId;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public Long getTimeStamp() {
		return timeStamp;
	}

	public void setTimeStamp(Long timeStamp) {
		this.timeStamp = timeStamp;
	}

	Message(Integer posterId, Integer receiverId, String text, Long timeStamp) {
		this.posterId = posterId;
		this.receiverId = receiverId;
		this.text = text;
		this.timeStamp = timeStamp;
	}

}

