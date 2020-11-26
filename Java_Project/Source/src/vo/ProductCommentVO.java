package vo;
//P_RE_ID      NOT NULL NUMBER        
//P_ID         NOT NULL NUMBER        
//M_ID         NOT NULL VARCHAR2(100) 
//P_RE_COMMENT          VARCHAR2(200) 
//P_REF                 NUMBER        
//P_RE_STEP             NUMBER        
//P_RE_LEVEL            NUMBER        
//P_RE_ADDDATE          DATE            



public class ProductCommentVO {
	private int p_re_id;
	private int p_id;
	private String m_id;
	private String p_re_comment;
	private int p_ref;
	private int p_re_step;
	private int p_re_level;
	private String p_re_adddate;
	private String m_nick;
	
	
	public int getP_re_id() {
		return p_re_id;
	}
	public void setP_re_id(int p_re_id) {
		this.p_re_id = p_re_id;
	}
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
	public String getP_re_comment() {
		return p_re_comment;
	}
	public void setP_re_comment(String p_re_comment) {
		this.p_re_comment = p_re_comment;
	}
	public int getP_ref() {
		return p_ref;
	}
	public void setP_ref(int p_ref) {
		this.p_ref = p_ref;
	}
	public int getP_re_step() {
		return p_re_step;
	}
	public void setP_re_step(int p_re_step) {
		this.p_re_step = p_re_step;
	}
	public int getP_re_level() {
		return p_re_level;
	}
	public void setP_re_level(int p_re_level) {
		this.p_re_level = p_re_level;
	}
	public String getP_re_adddate() {
		return p_re_adddate;
	}
	public void setP_re_adddate(String p_re_adddate) {
		this.p_re_adddate = p_re_adddate;
	}
	public String getM_nick() {
		return m_nick;
	}
	public void setM_nick(String m_nick) {
		this.m_nick = m_nick;
	}
}
