const std = @import("std");
const utils = @import("utils");
const ArrayList = std.ArrayList;

const Range = struct { start: usize, end: usize };

fn splitComma(line: *const ArrayList(u8)) !ArrayList(ArrayList(u8)) {
    var comma_loc: usize = 0;
    for (line.items) |*item| {
        if (item.* == ',') {
            break;
        }
        comma_loc += 1;
    }
    const right = line.items[0..comma_loc];
    const left = line.items[comma_loc + 1 ..];

    var return_list = ArrayList(ArrayList(u8)).init(std.heap.page_allocator);
    try return_list.append(ArrayList(u8).fromOwnedSlice(std.heap.page_allocator, right));
    try return_list.append(ArrayList(u8).fromOwnedSlice(std.heap.page_allocator, left));

    return return_list;
}

fn getRanges(split: ArrayList(ArrayList(u8))) !ArrayList(Range) {
    var ranges = ArrayList(Range).init(std.heap.page_allocator);
    for (split.items) |*side| {
        var dash: usize = 0;
        for (side.items) |*ch| {
            if (ch.* == '-') {
                break;
            }
            dash += 1;
        }
        const start = try std.fmt.parseInt(usize, side.items[0..dash], 10);
        const end = try std.fmt.parseInt(usize, side.items[dash + 1 ..], 10);
        try ranges.append(.{ .start = start, .end = end });
    }
    return ranges;
}

fn isInside(ranges: *ArrayList(Range)) !bool {
    const first = ranges.items[0];
    const second = ranges.items[1];

    if (first.start <= second.start and first.end >= second.end) {
        try std.io.getStdOut().writer().print("{d}-{d},{d}-{d}\n", .{ first.start, first.end, second.start, second.end });
        return true;
    } else if (second.start <= first.start and second.end >= first.start) {
        try std.io.getStdOut().writer().print("{d}-{d},{d}-{d}\n", .{ first.start, first.end, second.start, second.end });
        return true;
    }

    return false;
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Solution Day 4 part 1!\n", .{});

    var sum_of_overlaps: usize = 0;
    var lines: ArrayList(ArrayList(u8)) = try utils.readLinesFromFile(100, "res/day4_1.txt");
    defer lines.deinit();

    for (lines.items) |line| {
        var split = try splitComma(&line);
        var ranges = try getRanges(split);
        if (try isInside(&ranges)) {
            sum_of_overlaps += 1;
        }
    }

    try stdout.print("Repeats: {d}", .{sum_of_overlaps});
}
