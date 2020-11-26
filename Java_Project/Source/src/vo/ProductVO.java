package vo;

//Product
//P_ID          NOT NULL NUMBER         
//M_ID          NOT NULL VARCHAR2(100)  
//C_LID         NOT NULL NUMBER         
//C_SID         NOT NULL NUMBER         
//L_ID          NOT NULL NUMBER         
//P_NAME                 VARCHAR2(200)  
//P_ADDDATE              DATE           
//P_VALUE                NUMBER         
//P_STATUS               CHAR(1)        
//P_DESCRIPTION          VARCHAR2(4000) 
//P_LIKE                 NUMBER         
//P_BRAND                VARCHAR2(100)  
//P_DEALSTATUS           CHAR(1)        
//P_DEALDATE             DATE           
//P_PREMIUM              CHAR(1)        
//P_VIEW                 NUMBER         
//P_REF                  NUMBER         
//P_RE_STEP              NUMBER         
//P_RE_LEVEL             NUMBER
//P_RE_CONTENT           VARCHAR2(200)  

public class ProductVO {
	private int p_id;
	private String m_id;
	private int c_lid;
	private int c_sid;
	private int l_id;
	private String p_name;
	private String p_adddate;
	private int p_value;
	private char p_status;
	private String p_description;
	private int p_like;
	private String p_brand;
	private char p_dealstatus;
	private String p_dealdate;
	private char p_premium;
	private int p_view;
	private int p_ref;
	private int p_re_step;
	private int p_re_level;
	private String p_re_content;
	private String l_name;
	private String m_nick;
	private String pa_img3;
	
	public ProductVO() {
	}
	
	
	
	@Override
	public String toString() {
		return "ProductVO [p_id=" + p_id + ", m_id=" + m_id + ", c_lid=" + c_lid + ", c_sid=" + c_sid + ", l_id=" + l_id
				+ ", p_name=" + p_name + ", p_adddate=" + p_adddate + ", p_value=" + p_value + ", p_status=" + p_status
				+ ", p_description=" + p_description + ", p_like=" + p_like + ", p_brand=" + p_brand + ", p_dealstatus="
				+ p_dealstatus + ", p_dealdate=" + p_dealdate + ", p_premium=" + p_premium + ", p_view=" + p_view
				+ ", p_ref=" + p_ref + ", p_re_step=" + p_re_step + ", p_re_level=" + p_re_level + ", p_re_content="
				+ p_re_content + ", l_name=" + l_name + ", m_nick=" + m_nick + ", pa_img3=" + pa_img3 + "]";
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

	public int getL_id() {
		return l_id;
	}

	public void setL_id(int l_id) {
		this.l_id = l_id;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public String getP_adddate() {
		return p_adddate;
	}

	public void setP_adddate(String p_adddate) {
		this.p_adddate = p_adddate;
	}

	public int getP_value() {
		return p_value;
	}

	public void setP_value(int p_value) {
		this.p_value = p_value;
	}

	public char getP_status() {
		return p_status;
	}

	public void setP_status(char p_status) {
		this.p_status = p_status;
	}

	public String getP_description() {
		return p_description;
	}

	public void setP_description(String p_description) {
		this.p_description = p_description;
	}

	public int getP_like() {
		return p_like;
	}

	public void setP_like(int p_like) {
		this.p_like = p_like;
	}

	public String getP_brand() {
		return p_brand;
	}

	public void setP_brand(String p_brand) {
		this.p_brand = p_brand;
	}

	public char getP_dealstatus() {
		return p_dealstatus;
	}

	public void setP_dealstatus(char p_dealstatus) {
		this.p_dealstatus = p_dealstatus;
	}

	public String getP_dealdate() {
		return p_dealdate;
	}

	public void setP_dealdate(String p_dealdate) {
		this.p_dealdate = p_dealdate;
	}

	public char getP_premium() {
		return p_premium;
	}

	public void setP_premium(char p_premium) {
		this.p_premium = p_premium;
	}

	public int getP_view() {
		return p_view;
	}

	public void setP_view(int p_view) {
		this.p_view = p_view;
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
	public String getP_re_content() {
		return p_re_content;
	}
	public void setP_re_content(String p_re_content) {
		this.p_re_content = p_re_content;
	}
	public String getL_name() {
		return l_name;
	}
	public void setL_name(String l_name) {
		this.l_name = l_name;
	}

	public String getM_nick() {
		return m_nick;
	}

	public void setM_nick(String m_nick) {
		this.m_nick = m_nick;
	}

	public String getPa_img3() {
		return pa_img3;
	}

	public void setPa_img3(String pa_img3) {
		this.pa_img3 = pa_img3;
	}
	
}


