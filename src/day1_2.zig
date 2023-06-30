const std = @import("std");
const utils = @import("utils");
const ArrayList = std.ArrayList;
const EmptyLineError = utils.ParsingErrors.EmptyLineError;

fn sort(scores: *[3]usize) void {
    var index: u8 = 0;
    while (index < 3) {
        var comp: u8 = 0;
        while (comp < 3) {
            if (scores[comp] > scores[index]) {
                var tmp = scores[comp];
                scores[comp] = scores[index];
                scores[index] = tmp;
            }
            comp += 1;
        }
        index += 1;
    }
}

fn checkIfElfTop3AndAdd(elf_score: usize, scores: *[3]usize) void {
    sort(scores);
    for (scores) |*score| {
        if (score.* < elf_score) {
            score.* = elf_score;
            break;
        }
    }
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Day 1 p2 solution\n", .{});
    var lines: ArrayList(ArrayList(u8)) = try utils.readLinesFromFile(100, "res/day1_1.txt");
    defer lines.deinit();

    var current_elf_load: usize = 0;
    var biggest_elf_load: [3]usize = .{ 0, 0, 0 };

    for (lines.items) |line| {
        if (utils.arrayListU8ToNumber(usize, line)) |val| {
            current_elf_load += val;
        } else |err| {
            //reset meaning next is a new elf
            switch (err) {
                EmptyLineError => {
                    checkIfElfTop3AndAdd(current_elf_load, &biggest_elf_load);
                    current_elf_load = 0;
                },
                else => return err,
            }
        }
    }

    var biggest_load_sum: usize = 0;
    for (&biggest_elf_load) |*load| {
        biggest_load_sum += load.*;
    }

    try stdout.print("Elfs with largest loads sum : {d}\n", .{biggest_load_sum});
}
