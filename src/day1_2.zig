const std = @import("std");
const utils = @import("utils");
const ArrayList = std.ArrayList;

fn checkIfElfTop3AndAdd(elf_score: usize, scores: *[3]usize) void{
    for(scores) |*score|{
        if(scores[0]==0){
            scores[0]= elf_score;
            break;
        }else if(scores[1]==0){
            scores[1]= elf_score;
            break;
        }else if(scores[2]==0){
            scores[2]= elf_score;
            break;
        }else{
            //meaning all field are filled so we replace any with largest
            if(score.* < elf_score){
                score.* = elf_score;
                break;
            }
        }
    }
    std.sort.sort(usize, scores, {}, std.sort.asc(usize));
}

pub fn main() !void{
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Day 1 p2 solution\n", .{});
    var lines: ArrayList(ArrayList(u8)) = try utils.readLinesFromFile(100, "res/day1_1.txt");
    defer lines.deinit();

    var current_elf_load: usize = 0;
    var biggest_elf_load: [3]usize = .{0,0,0};

    for(lines.items) |line|{
        if(line.items.len > 0){
            const val = try utils.arrayListU8ToNumber(usize,line);
            current_elf_load+=val;
        }else{
            //reset meaning next is a new elf
            checkIfElfTop3AndAdd(current_elf_load, &biggest_elf_load);
            current_elf_load = 0;
        }
    }

    var biggest_load_sum: usize = 0;
    for(biggest_elf_load)|load|{
        biggest_load_sum+=load;
    }

    try stdout.print("Elfs with largest loads sum : {d}\n",.{biggest_load_sum});
}
