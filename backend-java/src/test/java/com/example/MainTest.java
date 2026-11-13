
package com.example;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

class MainTest {

    @Test
    void testAddition() {
        assertEquals(15, Main.add(10, 5));
    }

    @Test
    void testSubtraction() {
        assertEquals(5, Main.subtract(10, 5));
    }

    @Test
    void testMultiplication() {
        assertEquals(50, Main.multiply(10, 5));
    }

    @Test
    void testGreeting() {
        assertEquals(
            "Hello, Developer! Welcome to Java CI/CD.",
            Main.greet("Developer")
        );
    }
}
