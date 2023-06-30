const std = @import("std");
const ArrayList = std.ArrayList;
const OpenFlags = std.fs.File.OpenFlags;

pub const ParsingErrors = error{EmptyLineError};

pub fn readLinesFromFile(comptime line_size: comptime_int, file_loc: []const u8) !ArrayList(ArrayList(u8)) {
    const file = try std.fs.cwd().openFile(file_loc, OpenFlags{});
    defer file.close();
    var buffer_reader = std.io.bufferedReader(file.reader());
    var buf: [line_size]u8 = undefined;
    var lines = ArrayList(ArrayList(u8)).init(std.heap.page_allocator);
    var in_stream = buffer_reader.reader();

    while (result: {
        var line = in_stream.readUntilDelimiterOrEof(&buf, '\n') catch break :result false;
        if (line) |line_a| {
            var line_arraylist = ArrayList(u8).init(std.heap.page_allocator);
            try line_arraylist.writer().print("{s}", .{line_a[0 .. line_a.len - 1]});
            try lines.append(line_arraylist);
            break :result true;
        } else {
            break :result false;
        }
    }) {}
    return lines;
}

pub fn arrayListU8ToNumber(comptime T: type, array_list: ArrayList(u8)) !T {
    var last_val: usize = 0;
    for (array_list.items) |v| {
        if (v == undefined or v == 13) {
            break;
        }
        last_val += 1;
    }
    if (last_val == 0) {
        return ParsingErrors.EmptyLineError;
    }
    return try std.fmt.parseInt(T, array_list.items[0..last_val], 10);
}
