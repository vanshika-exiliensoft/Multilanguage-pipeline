
package com.example;

public class Main {

    public static int add(int a, int b) {
        return a + b;
    }

    public static int subtract(int a, int b) {
        return a - b;
    }

    public static int multiply(int a, int b) {
        return a * b;
    }

    public static String greet(String name) {
        return "Hello, " + name + "! Welcome to Java CI/CD.";
    }

    public static void main(String[] args) {

        System.out.println("Java CI/CD Demo");

        System.out.println("Addition: " + add(10, 5));

        System.out.println("Subtraction: " + subtract(10, 5));

        System.out.println("Multiplication: " + multiply(10, 5));

        System.out.println(greet("Developer"));
    }
}
