package vo;
//P_ID    NOT NULL NUMBER         
//PA_IMG1          VARCHAR2(4000) 
//PA_IMG2          VARCHAR2(4000) 
//PA_IMG3          VARCHAR2(4000) 

public class PaddVO {
	private int p_id;
	private String pa_img1;
	private String pa_img2;
	private String pa_img3;
	
	@Override
	public String toString() {
		return "PaddVO [p_id=" + p_id + ", pa_img1=" + pa_img1 + ", pa_img2=" + pa_img2 + ", pa_img3=" + pa_img3 + "]";
	}
	
	public int getP_id() {
		return p_id;
	}
	public void setP_id(int p_id) {
		this.p_id = p_id;
	}
	public String getPa_img1() {
		return pa_img1;
	}
	public void setPa_img1(String pa_img1) {
		this.pa_img1 = pa_img1;
	}
	public String getPa_img2() {
		return pa_img2;
	}
	public void setPa_img2(String pa_img2) {
		this.pa_img2 = pa_img2;
	}
	public String getPa_img3() {
		return pa_img3;
	}
	public void setPa_img3(String pa_img3) {
		this.pa_img3 = pa_img3;
	}
}
