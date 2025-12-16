pub fn is_valid(s: String) -> bool {
    let mut stack = Vec::with_capacity(s.len());
    for c in s.chars() {
        match c {
            // 技巧：遇到左括号，把"期待对应的右括号"压入栈
            '(' => stack.push(')'),
            '{' => stack.push('}'),
            '[' => stack.push(']'),

            // 遇到右括号
            ')' | '}' | ']' => {
                // stack.pop() 会返回 Option<char>
                // 如果栈是空的 (None)，或者弹出的字符跟当前的 c 不一样
                // 直接返回 false
                if stack.pop() != Some(c) {
                    return false;
                }
            }

            // 如果有其他字符，根据题目要求忽略或报错，这里选择忽略
            _ => {}
        }
    }
    stack.is_empty()
}

#[test]
fn test_is_valid() {
    assert_eq!(is_valid("()".to_string()), true);
    assert_eq!(is_valid("()[]{}".to_string()), true);
    assert_eq!(is_valid("(]".to_string()), false);
    assert_eq!(is_valid("([)]".to_string()), false);
    assert_eq!(is_valid("{[]}".to_string()), true);
}

pub fn remove_element(nums: &mut Vec<i32>, val: i32) -> i32 {
    let mut l = 0;
    let mut r = 0;
    while r < nums.len() {
        if nums[r] != val {
            nums[l] = nums[r];
            l += 1;
        }
        r += 1;
    }
    l as i32
}

#[test]
fn test_remove_element() {
    let mut nums = vec![3, 2, 2, 3];
    let val = 3;
    let expected = 2;
    let actual = remove_element(&mut nums, val);
    assert_eq!(actual, expected);
    assert_eq!(nums, vec![2, 2, 2, 3]);
}
