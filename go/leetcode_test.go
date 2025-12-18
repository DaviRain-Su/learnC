package leetcode

import "testing"

func TestIsValid(t *testing.T) {
	tests := []struct {
		input    string
		expected bool
	}{
		{"()", true},
		{"()[]{}", true},
		{"(]", false},
		{"([)]", false},
		{"{[]}", true},
	}

	for _, test := range tests {
		result := isValid(test.input)
		if result != test.expected {
			t.Errorf("isValid(%q) = %v; expected %v", test.input, result, test.expected)
		}
	}
}

func TestRemoveElement(t *testing.T) {
	tests := []struct {
		nums     []int
		val      int
		expected int
	}{
		{[]int{3, 2, 2, 3}, 3, 2},
		{[]int{0, 1, 2, 2, 3, 0, 4, 2}, 2, 5},
	}

	for _, test := range tests {
		result := removeElement(test.nums, test.val)
		if result != test.expected {
			t.Errorf("removeElement(%v, %d) = %d; expected %d", test.nums, test.val, result, test.expected)
		}
	}
}
