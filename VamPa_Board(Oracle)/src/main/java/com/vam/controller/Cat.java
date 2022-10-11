package com.vam.controller;

import lombok.Data;


@Data
public class Cat {
	private String name;
	private int age;
	private double weight;
	private double height;
	//Cat클래스를 만들어서 변수넣고 클래스위에 @Data
	//프로젝트익스플로러에서 해당 클래스 들어가서 getter/setter만들어졌는지 확인
}
