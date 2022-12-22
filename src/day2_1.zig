const std = @import("std");
const utils = @import("utils");
const ArrayList = std.ArrayList;

// Rock > Siz
// Siz > Paper
// Paper > Rock

// A = Rock = 1 = X
// B = Paper = 2 = Y
// C = Siz = 3 = Z

// Loss = 0
// Win = 6
// Draw = 3

fn scoreOfChoice(choice: u8) usize{
    switch(choice){
        88 => return 1,
        89 => return 2,
        90 => return 3,
        else => unreachable
    }
}

fn getScore(op: u8, me: u8) usize {
    //win
    if((me-23 == 65  and op==67 ) or 
        (me-23 == 67 and  op == 66) or 
        (me-23 == 66 and op == 65)){
        return 6+scoreOfChoice(me);
    }
    //draw
    else if(op == (me-23)){
        return 3+scoreOfChoice(me);
    }
    return scoreOfChoice(me);
}

pub fn main() !void{
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Day 2 p1 solution\n", .{});
    var lines: ArrayList(ArrayList(u8)) = try utils.readLinesFromFile(100, "res/day2_1.txt");
    defer lines.deinit();

    var score: usize = 0;

    for(lines.items)|line|{
        if(line.items.len==0){
            continue;
        }
        const op = line.items[0];
        const me = line.items[2];
        const result_score = getScore(op,me);
        score += result_score;
    }
    try stdout.print("Total score is {d}\n",.{score});
}
