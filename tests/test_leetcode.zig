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
