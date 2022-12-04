use std::fs::File;
use std::io::{BufReader, BufRead};

fn get_range(elf: &str)->(usize,usize){
    let _vals:Vec<usize> = elf.split('-').map(|c| c.parse().unwrap()).collect();
    (_vals[0],_vals[1])
}

fn main(){
    let mut sum_copy_pairs = 0;
    for l in BufReader::new(File::open("./day4_1.txt").unwrap()).lines(){
	let line = l.unwrap();
	let elfs: Vec<&str> = line.split(',').collect();
	let elf1 = get_range(elfs[0]);
	let elf2 = get_range(elfs[1]);
	if elf1.0 <= elf2.0 && elf1.1 >= elf2.1{
	    //meaning elf2 should be inside elf1
	    sum_copy_pairs+=1;
	    continue;
	}
	if elf2.0 <= elf1.0 && elf2.1 >= elf1.1{
	    //meaning elf1 should be inside elf2
	    sum_copy_pairs+=1;
	}
    }

    println!("SUM: {sum_copy_pairs}");
}
