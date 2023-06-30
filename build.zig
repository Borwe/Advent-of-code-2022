const std = @import("std");
const ArrayList = std.ArrayList;
const Module = std.build.Module;
const Compile = std.build.CompileStep;

fn add_day_exercise(b: *std.Build, optimize: std.builtin.OptimizeMode, target: std.zig.CrossTarget, comptime day: []const u8, comptime file: []const u8) !void {
    const exe: *Compile = b.addExecutable(.{ .target = target, .root_source_file = .{ .path = file }, .optimize = optimize, .name = day });
    const utils = b.addModule("utils", .{ .source_file = .{ .path = "./src/utils.zig" } });
    exe.addModule("utils", utils);
    b.installArtifact(exe);

    var buf: [5024]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buf);
    const alloc = fba.allocator();

    var day_info = ArrayList(u8).init(alloc);
    try day_info.writer().print("Run {s}, solution", .{day});
    const run_cmd = b.addRunArtifact(exe);
    const run_step = b.step(day, day_info.items);
    run_step.dependOn(&run_cmd.step);
    day_info.deinit();
}

pub fn build(b: *std.Build) !void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const optimize = b.standardOptimizeOption(.{});

    var exe = b.addExecutable(.{ .name = "advent_of_code_2022", .root_source_file = .{ .path = "src/main.zig" }, .optimize = optimize, .target = target });
    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Show info");
    run_step.dependOn(&run_cmd.step);
    try add_day_exercise(b, optimize, target, "day1_1", "src/day1_1.zig");
    try add_day_exercise(b, optimize, target, "day1_2", "src/day1_2.zig");
    try add_day_exercise(b, optimize, target, "day2_1", "src/day2_1.zig");
    try add_day_exercise(b, optimize, target, "day2_2", "src/day2_2.zig");
    try add_day_exercise(b, optimize, target, "day3_1", "src/day3_1.zig");
    try add_day_exercise(b, optimize, target, "day3_2", "src/day3_2.zig");
}
