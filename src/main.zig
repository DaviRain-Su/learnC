//! this is main function
const std = @import("std");
const c = @cImport({
    @cInclude("foo.h");
});

var buffer: [1024]u8 = undefined;
var stdout_writer = std.fs.File.stdout().writer(&buffer);
var stdout = &stdout_writer.interface;

pub fn main() !void {
    try stdout.print("Hello from Zig!\n", .{});
    // Demonstrate C interop
    const base: c_int = 2;
    const exp: c_int = 10;
    const result = c.power(base, exp);
    try stdout.print("Power({d}, {d}) = {d}\n", .{ base, exp, result });

    try std.fs.File.stdout().writeAll("My name is DaviRain-Su!\n");
    try stdout.print("Debug message\n", .{});

    const optional_value: ?[]const u8 = null;
    std.debug.assert(optional_value == null);
    try stdout.print("\nOptional Type: {}\nvalue: {?s}\n", .{ @TypeOf(optional_value), optional_value });

    const score = 85;
    const grade = if (score >= 60) "Pass" else "Fail";
    try stdout.print("Grade: {s}\n", .{grade});

    const Role = enum { SE, DPE, DE, DA, PM, PO, KS };

    const role = Role.SE;
    var area: []const u8 = undefined;

    switch (role) {
        // 多个匹配项可以用逗号分隔
        .PM, .SE, .DPE, .PO => {
            area = "Platform";
        },
        .DE, .DA => {
            area = "Data & Analytics";
        },
        // 每个可能的值都必须被处理
        .KS => {
            area = "Sales";
        },
    }

    try stdout.print("Area: {any}, result value: {s}\n", .{ @TypeOf(area), area });

    // 定义一个包含 4 个 u32 的向量
    const a = @Vector(4, u32){ 1, 2, 3, 4 };
    const b = @Vector(4, u32){ 5, 6, 7, 8 };

    // 向量加法：并行计算 1+5, 2+6, 3+7, 4+8
    const cc = a + b;

    try stdout.print("Result: {any}\n", .{cc});
    // 输出: { 6, 8, 10, 12 }
    //
    // get current dir
    var current_dir = try std.fs.cwd().openDir("..", .{ .iterate = true });
    defer current_dir.close();

    var walker = try current_dir.walk(std.heap.c_allocator);
    defer walker.deinit();

    while (try walker.next()) |entry| {
        //try stdout.print("Current directory: {s}\n", .{entry.path});
        if (std.mem.eql(u8, entry.path, "blockchain-demo/src/main.zig")) {
            try stdout.print("Found blockchain-demo/src/main.zig\n", .{});
            // open this file
            var file = try current_dir.openFile(entry.path, .{});
            defer file.close();

            const data = try file.readToEndAlloc(std.heap.c_allocator, 40 * 1024);
            try stdout.print("File content: {s}\n", .{data});
        }
    }

    std.log.warn("print information by log", .{});
    try stdout.flush();
}
