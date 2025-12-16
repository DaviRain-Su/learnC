const std = @import("std");
const expect = std.testing.expect;

// 1. 导入 C 头文件
const c = @cImport({
    @cInclude("leetcode.h");
});

// 2. 编写测试用例
test "simple addition from C" {
    // 直接调用 C 函数
    const result = c.add(10, 20);

    // 使用 Zig 的断言库
    try expect(result == 30);
}

test "negative addition" {
    const result = c.add(-5, 5);
    try std.testing.expectEqual(@as(c_int, 0), result);
}

test "matching" {
    // convert from zig string to c string
    const zig_str = "()";
    const c_str: [*c]u8 = @ptrCast(@constCast(zig_str));
    const result = c.isValid(c_str);
    try std.testing.expectEqual(@as(c_int, 1), result);
}

test "parentheses matching" {
    // convert from zig string to c string
    const zig_str = "())";
    const c_str: [*c]u8 = @ptrCast(@constCast(zig_str));
    const result = c.isValid(c_str);
    try std.testing.expectEqual(@as(c_int, 0), result);
}

test "parentheses matching with invalid input" {
    const zig_str = "([)]";
    const c_str: [*c]u8 = @ptrCast(@constCast(zig_str));
    const result = c.isValid(c_str);
    try std.testing.expectEqual(@as(c_int, 0), result);
}

test "parentheses matching with nested parentheses" {
    const zig_str = "({[]})";
    const c_str: [*c]u8 = @ptrCast(@constCast(zig_str));
    const result = c.isValid(c_str);
    try std.testing.expectEqual(@as(c_int, 1), result);
}
