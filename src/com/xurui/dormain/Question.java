package com.xurui.dormain;

public class Question {
	private int id = 0;
	private int type = 0;
	private String course="";
	private String ques = "";
	private String keyA = "";
	private String keyB = "";
	private String keyC = "";
	private String keyD = "";
	private String answer="";
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getQues() {
		return ques;
	}
	public void setQues(String ques) {
		this.ques = ques;
	}
	public String getKeyA() {
		return keyA;
	}
	public void setKeyA(String keyA) {
		this.keyA = keyA;
	}
	public String getKeyB() {
		return keyB;
	}
	public void setKeyB(String keyB) {
		this.keyB = keyB;
	}
	public String getKeyC() {
		return keyC;
	}
	public void setKeyC(String keyC) {
		this.keyC = keyC;
	}
	public String getKeyD() {
		return keyD;
	}
	public void setKeyD(String keyD) {
		this.keyD = keyD;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getCourse() {
		return course;
	}
	public void setCourse(String course) {
		this.course = course;
	}
	@Override
	public String toString() {
		return "Question [id=" + id + ", type=" + type + ", course=" + course
				+ "]";
	}
	
	

}
