package kr.co.pyo.signup.model;

public class SignupVO {
    private String id;				//아이디 (4~12자의 영문 대소문자와 숫자)
    private String pwd; 			//비밀번호 (4~12자의 영문 대소문자와 숫자)
    private String email; 			//이메일 주소
    private String name; 			//이름
    private int birth; 				//생년월일 
    
	public SignupVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public SignupVO(String id, String pwd, String email, String name, int birth) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.email = email;
		this.name = name;
		this.birth = birth;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getBirth() {
		return birth;
	}
	public void setBirth(int birth) {
		this.birth = birth;
	}
	@Override
	public String toString() {
		return "SignupVO [id=" + id + ", pwd=" + pwd + ", email=" + email + ", name=" + name + ", birth=" + birth + "]";
	}
}