const std = @import("std");
const ArrayList = std.ArrayList;

fn add_day_exercise(b: *std.build.Builder, mode: std.builtin.Mode, target: std.zig.CrossTarget,comptime day:[]const u8,
    comptime file: []const u8) !void{
    const exe = b.addExecutable(day,file);
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.addPackagePath("utils","src/utils.zig");
    exe.install();

    var buf: [1024]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buf);
    const alloc = fba.allocator();

    var day_info = ArrayList(u8).init(alloc);
    try day_info.writer().print("Run {s}, solution", .{day});
    const run_cmd = exe.run();
    const run_step = b.step(day, day_info.items);
    run_step.dependOn(&run_cmd.step);
    day_info.deinit();
}

pub fn build(b: *std.build.Builder) !void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("advent_of_code_2022", "src/main.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
    try add_day_exercise(b, mode, target, "day1_1", "src/day1_1.zig");
    try add_day_exercise(b, mode, target, "day1_2", "src/day1_2.zig");
}
