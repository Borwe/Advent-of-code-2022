const std = @import("std");
const utils = @import("utils");
const ArrayList = std.ArrayList;

pub fn main() !void{
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Day 1 p1 solution\n", .{});
    var lines: ArrayList(ArrayList(u8)) = try utils.readLinesFromFile(100, "res/day1_1.txt");
    defer lines.deinit();

    var current_elf_load: usize = 0;
    var biggest_elf_load: usize = 0;

    for(lines.items) |line|{
        if(line.items.len > 0){
            const val = try utils.arrayListU8ToNumber(usize,line);
            current_elf_load+=val;

            if(current_elf_load>biggest_elf_load){
                biggest_elf_load=current_elf_load;
            }
        }else{
            //reset meaning next is a new elf
            current_elf_load = 0;
        }
    }

    try stdout.print("Elf with largest load has load of: {d}\n",.{biggest_elf_load});
}
