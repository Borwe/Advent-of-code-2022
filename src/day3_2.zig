const std = @import("std");
const utils = @import("utils");
const ArrayList = std.ArrayList;

fn get_similar(group: [3][]const u8) u8 {
    for (group[0]) |char1| {
        var match_1 = false;
        var match_2 = false;
        for (group[1]) |char2| {
            if (char1 == char2) {
                match_1 = true;
            }
        }

        for (group[2]) |char2| {
            if (char1 == char2) {
                match_2 = true;
            }
        }

        if (match_1 and match_2) {
            return char1;
        }
    }
    unreachable;
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Day 3 p2 solution\n", .{});
    var lines: ArrayList(ArrayList(u8)) = try utils.readLinesFromFile(100, "res/day3_1.txt");
    defer lines.deinit();

    const a = 'a';
    const z = 'z';
    const A = 'A';
    const Z = 'Z';

    var sum_priorities: usize = 0;
    var group: [3][]const u8 = undefined;

    for (lines.items, 0..) |line, i| {
        if (line.items.len <= 0) {
            continue;
        }

        if ((i + 1) % 3 == 0) {
            //we have found a group set
            group[2] = lines.items[i].items;
            group[1] = lines.items[i - 1].items;
            group[0] = lines.items[i - 2].items;
            const val = get_similar(group);
            if (val >= a and val <= z) {
                //small chars = 1 -> 26
                sum_priorities += val - a + 1;
            } else if (val >= A and val <= Z) {
                //small chars = 1 -> 26
                sum_priorities += val - A + 27;
            }
        }
    }
    try stdout.print("Sum of priorities: {d}\n", .{sum_priorities});
}
