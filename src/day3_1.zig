const std = @import("std");
const utils = @import("utils");
const ArrayList = std.ArrayList;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Day 3 p1 solution\n", .{});
    var lines: ArrayList(ArrayList(u8)) = try utils.readLinesFromFile(100, "res/day2_1.txt");
    defer lines.deinit();
}
