package restful;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Data
@Entity // This tells Hibernate to make a table out of this class
public class Post {
    @Id @GeneratedValue(strategy=GenerationType.AUTO)
    private Integer id;

    private Integer posterId;

    private String title;

    private String image;

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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public void setTimeStamp(Long timeStamp) {
		this.timeStamp = timeStamp;
	}

	public Long getTimeStamp() {
		return timeStamp;
	}

	Post(Integer posterId, String title, String image, Long timeStamp) {
		this.posterId = posterId;
		this.title = title;
		this.image = image;
		this.timeStamp = timeStamp;
	}

}

