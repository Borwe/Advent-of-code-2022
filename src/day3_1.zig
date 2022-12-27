const std = @import("std");
const utils = @import("utils");
const ArrayList = std.ArrayList;

fn get_similar(a1: []const u8, a2: []const u8) u8 {
    for (a1) |x| {
        for (a2) |x2| {
            if (x == x2) {
                return x;
            }
        }
    }
    unreachable;
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Day 3 p1 solution\n", .{});
    var lines: ArrayList(ArrayList(u8)) = try utils.readLinesFromFile(100, "res/day3_1.txt");
    defer lines.deinit();

    const a = 'a';
    const z = 'z';
    const A = 'A';
    const Z = 'Z';

    var sum_priorities: usize = 0;

    for (lines.items) |line| {
        if (line.items.len <= 0) {
            continue;
        }
        const mid = line.items.len / 2;
        const p1 = line.items[0..mid];
        const p2 = line.items[mid..];
        const val = get_similar(p1, p2);
        if (val >= a and val <= z) {
            //small chars = 1 -> 26
            sum_priorities += val - a + 1;
        } else if (val >= A and val <= Z) {
            //small chars = 1 -> 26
            sum_priorities += val - A + 27;
        }
    }
    try stdout.print("Sum of priorities: {d}\n", .{sum_priorities});
}
