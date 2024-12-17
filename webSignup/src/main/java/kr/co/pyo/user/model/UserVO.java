package kr.co.pyo.user.model;

public class UserVO {
    private String id;
    private String pwd;
    private String name;
    private String birth;
    private String phone1;
    private String phone2;
    private String phone3;
    private String email;
    private String zipcode;
    private String address1;
    private String address2;

    // 기본 생성자
    public UserVO() {}

    // 모든 필드를 초기화하는 생성자
    public UserVO(String id, String pwd, String name, String birth, 
                  String phone1, String phone2, String phone3, 
                  String email, String zipcode, String address1, String address2) {
        this.id = id;
        this.pwd = pwd;
        this.name = name;
        this.birth = birth;
        this.phone1 = phone1;
        this.phone2 = phone2;
        this.phone3 = phone3;
        this.email = email;
        this.zipcode = zipcode;
        this.address1 = address1;
        this.address2 = address2;
    }

    // Getter 및 Setter 메서드
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getPwd() { return pwd; }
    public void setPwd(String pwd) { this.pwd = pwd; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getBirth() { return birth; }
    public void setBirth(String birth) { this.birth = birth; }

    public String getPhone1() { return phone1; }
    public void setPhone1(String phone1) { this.phone1 = phone1; }

    public String getPhone2() { return phone2; }
    public void setPhone2(String phone2) { this.phone2 = phone2; }

    public String getPhone3() { return phone3; }
    public void setPhone3(String phone3) { this.phone3 = phone3; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getZipcode() { return zipcode; }
    public void setZipcode(String zipcode) { this.zipcode = zipcode; }

    public String getAddress1() { return address1; }
    public void setAddress1(String address1) { this.address1 = address1; }

    public String getAddress2() { return address2; }
    public void setAddress2(String address2) { this.address2 = address2; }
}
