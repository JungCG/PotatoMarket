package vo;

import java.sql.Date;
import java.sql.Timestamp;

public class BoardVO {


	
	
	private int b_id;
	private String m_id;
	private char b_type;
	private String b_title;
	private Timestamp b_timestamp;
	private int b_view;
	private int b_like;
	private int b_count;
	private String b_content;
	private char b_secret;
	private int b_secretnumber;
	private int b_ref;
	private int b_re_step;
	private int b_re_level;
	
	public int getB_id() {
		return b_id;
	}
	public void setB_id(int b_id) {
		this.b_id = b_id;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public char getB_type() {
		return b_type;
	}
	public void setB_type(char b_type) {
		this.b_type = b_type;
	}
	public String getB_title() {
		return b_title;
	}
	public void setB_title(String b_title) {
		this.b_title = b_title;
	}
	public Timestamp getB_timestamp() {
		return b_timestamp;
	}
	public void setB_timestamp(Timestamp timestamp) {
		this.b_timestamp = timestamp;
	}
	public int getB_view() {
		return b_view;
	}
	public void setB_view(int b_view) {
		this.b_view = b_view;
	}
	public int getB_like() {
		return b_like;
	}
	public void setB_like(int b_like) {
		this.b_like = b_like;
	}
	public int getB_count() {
		return b_count;
	}
	public void setB_count(int b_count) {
		this.b_count = b_count;
	}
	public String getB_content() {
		return b_content;
	}
	public void setB_content(String b_content) {
		this.b_content = b_content;
	}
	public char getB_secret() {
		return b_secret;
	}
	public void setB_secret(char b_secret) {
		this.b_secret = b_secret;
	}
	public int getB_secretnumber() {
		return b_secretnumber;
	}
	public void setB_secretnumber(int b_secretnumber) {
		this.b_secretnumber = b_secretnumber;
	}
	public int getB_ref() {
		return b_ref;
	}
	public void setB_ref(int b_ref) {
		this.b_ref = b_ref;
	}
	public int getB_re_step() {
		return b_re_step;
	}
	public void setB_re_step(int b_re_step) {
		this.b_re_step = b_re_step;
	}
	public int getB_re_level() {
		return b_re_level;
	}
	public void setB_re_level(int b_re_level) {
		this.b_re_level = b_re_level;
	}
	
}
