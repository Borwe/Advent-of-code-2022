const std = @import("std");
const utils = @import("utils");
const ArrayList = std.ArrayList;
const EmptyLineError = utils.ParsingErrors.EmptyLineError;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Day 1 p1 solution\n", .{});
    var lines: ArrayList(ArrayList(u8)) = try utils.readLinesFromFile(100, "res/day1_1.txt");
    defer lines.deinit();

    var current_elf_load: usize = 0;
    var biggest_elf_load: usize = 0;

    for (lines.items) |line| {
        if (utils.arrayListU8ToNumber(usize, line)) |val| {
            current_elf_load += val;

            if (current_elf_load > biggest_elf_load) {
                biggest_elf_load = current_elf_load;
            }
        } else |err| {
            switch (err) {
                EmptyLineError => current_elf_load = 0,
                else => return err,
            }
        }
    }

    try stdout.print("Elf with largest load has load of: {d}\n", .{biggest_elf_load});
}
