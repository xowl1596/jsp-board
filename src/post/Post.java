package post;

public class Post {
	private int postID;
	private String title;
	private String userID;
	private String writeDate;
	private String content;
	private int postAvailable;
	
	//getters & setters
	public int getPostID() {
		return postID;
	}
	public void setPostID(int postID) {
		this.postID = postID;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public int getPostAvailable() {
		return postAvailable;
	}
	public void setPostAvailable(int postAvailable) {
		this.postAvailable = postAvailable;
	}
	
	
	
}
