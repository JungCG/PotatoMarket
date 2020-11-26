package vo;
//P_ID NOT NULL NUMBER        
//M_ID NOT NULL VARCHAR2(500) 
public class PlikeVO {
	private int p_id;
	private String m_id;
	
	
	public int getP_id() {
		return p_id;
	}
	public void setP_id(int p_id) {
		this.p_id = p_id;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
}
