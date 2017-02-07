package com.xurui.dormain;

public class Test {
	private String Uid= "";
	private int Qid = 0;
	private int type=0;
	private int tnumber=0;
	private String course="";
	private String stuAnswer="";
	private float score = 0;
	private String test_time;
	public String getUid() {
		return Uid;
	}
	public void setUid(String uid) {
		Uid = uid;
	}
	public int getQid() {
		return Qid;
	}
	public void setQid(int qid) {
		Qid = qid;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getTnumber() {
		return tnumber;
	}
	public void setTnumber(int tnumber) {
		this.tnumber = tnumber;
	}
	public String getCourse() {
		return course;
	}
	public void setCourse(String course) {
		this.course = course;
	}
	public String getStuAnswer() {
		return stuAnswer;
	}
	public void setStuAnswer(String stuAnswer) {
		this.stuAnswer = stuAnswer;
	}
	public float getScore() {
		return score;
	}
	public void setScore(float score) {
		this.score = score;
	}
	public String getTest_time() {
		return test_time;
	}
	public void setTest_time(String test_time) {
		this.test_time = test_time;
	}
	

}
