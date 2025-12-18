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
    try stdout.flush();
}
