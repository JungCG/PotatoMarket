package vo;

public class Category_FavorVO {
	
	public int getC_lid() {
		return c_lid;
	}
	public void setC_lid(int c_lid) {
		this.c_lid = c_lid;
	}
	public int getC_sid() {
		return c_sid;
	}
	public void setC_sid(int c_sid) {
		this.c_sid = c_sid;
	}
	private String m_id;
	private int c_lid;
	private int c_sid;
	private String c_name;
	
	public String getC_name() {
		return c_name;
	}
	public void setC_name(String c_name) {
		this.c_name = c_name;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	
}
