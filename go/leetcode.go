package leetcode

func isValid(s string) bool {
	stack := []int32{}
	for _, c := range s {
		switch c {
		case '(':
			stack = append(stack, ')')
		case '{':
			stack = append(stack, '}')
		case '[':
			stack = append(stack, ']')
		case ')', '}', ']':
			if len(stack) == 0 || stack[len(stack)-1] != c {
				return false
			}
			stack = stack[:len(stack)-1]
		default:
			return false
		}
	}
	return len(stack) == 0
}

func removeElement(nums []int, val int) int {
    l := 0;
    r := 0;
    for r < len(nums) {
        if nums[r] != val {
            nums[l] = nums[r];
            l += 1;
        }
        r += 1;
    }
    return l;
}
