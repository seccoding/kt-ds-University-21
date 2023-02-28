package board;

/**
 * 게시글 데이터 객체
 * 
 * @author mcjang
 */
public class BoardVO {

	/**
	 * 순번
	 */
	private int number;
	
	/**
	 * 제목
	 */
	private String subject;
	
	/**
	 * 작성자
	 */
	private String writer;
	
	/**
	 * 조회수
	 */
	private int readCount;

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

}
