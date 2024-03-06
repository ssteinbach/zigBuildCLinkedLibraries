const std = @import("std");
const lib_that_calls_c = @import("lib_that_calls_c.zig");

test "call adds two" {
    const result = lib_that_calls_c.add_four(-1);
    try std.testing.expectEqual(@as(i32, 3), result); 
}

pub fn main() void {
    const input = 3;
    const result = lib_that_calls_c.add_four(input);
    std.debug.print(
        "{d} + 2 = {d} ",
        .{ 
            input,
            result,
        },
    );
}
