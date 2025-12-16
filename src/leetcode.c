#include "leetcode.h"
#include <stdlib.h>
#include <string.h>

#define BOOL int
#define FALSE 0
#define TRUE 1

int add(int a, int b) {
    return a + b;
}

BOOL isValid(char* s) {
   int n = strlen(s);
    // 如果字符串为空，通常认为是有效的
    if (n == 0) return TRUE;

    // 1. 分配栈内存
    // 栈的大小最大也就是字符串的长度
    char* stack = (char*)malloc(sizeof(char) * (n + 1));
    int top = 0; // 栈顶指针，指向下一个可写入的位置

    int i = 0;
    while (s[i] != '\0') {
        char current = s[i];

        // 2. 遇到左括号：入栈 (Push)
        if (current == '(' || current == '{' || current == '[') {
            stack[top] = current;
            top++;
        }
        // 3. 遇到右括号：尝试出栈 (Pop) 并匹配
        else {
            // 如果栈已经空了，说明没有对应的左括号，无效
            if (top == 0) {
                free(stack);
                return FALSE;
            }

            // 获取栈顶元素（上一个入栈的左括号）
            char last_open = stack[top - 1];

            // 检查是否匹配
            if ((current == ')' && last_open == '(') ||
                (current == '}' && last_open == '{') ||
                (current == ']' && last_open == '[')) {
                // 匹配成功，弹出栈顶
                top--;
            } else {
                // 匹配失败（例如 (] ）
                free(stack);
                return FALSE;
            }
        }
        // 别忘了移动到下一个字符！
        i++;
    }

    // 4. 检查栈是否为空
    // 如果 top 为 0，说明所有左括号都找到了归宿，返回 true
    BOOL result = (top == 0);

    // 释放内存
    free(stack);

    return result;
}
