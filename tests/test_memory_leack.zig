const std = @import("std");

test "example memory leak" {
    var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
    defer std.debug.assert(general_purpose_allocator.deinit() == .ok);

    const gpa = general_purpose_allocator.allocator();

    const u32_ptr = try gpa.create(u32);
    defer gpa.destroy(u32_ptr);

    const value = u32_ptr; // silences unused variable error
    std.log.info("Value: {}", .{value});
    // oops I forgot to free!
}
