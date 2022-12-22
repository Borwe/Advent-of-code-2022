const std = @import("std");

pub fn main() !void {
    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Welcome to Advent of code 2022, with Zig solution\n", .{});
    try stdout.print("Run zig build --help for info to see how to run the daay solutions\n", .{});

    try bw.flush(); // don't forget to flush!
}
