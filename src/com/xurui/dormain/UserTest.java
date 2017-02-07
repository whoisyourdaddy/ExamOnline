package com.xurui.dormain;

public class UserTest {
	
	private String id;
	private String name;
	private String course;
	private String test_time;
	public String getId() {
		return id;
	}
	@Override
	public String toString() {
		return "UserTest [id=" + id + ", name=" + name + ", course=" + course
				+ ", test_time=" + test_time + "]";
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCourse() {
		return course;
	}
	public void setCourse(String course) {
		this.course = course;
	}
	public String getTest_time() {
		return test_time;
	}
	public UserTest() {
		super();
		
	}
	public UserTest(String id, String name, String course, String test_time) {
		super();
		this.id = id;
		this.name = name;
		this.course = course;
		this.test_time = test_time;
	}
	public void setTest_time(String test_time) {
		this.test_time = test_time;
	}

}
