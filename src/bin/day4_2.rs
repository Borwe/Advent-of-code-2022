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
	let mut found = false;
	for i in elf1.0..elf1.1+1{
	    for j in elf2.0..elf2.1+1{
		if i == j {
		    sum_copy_pairs+=1;
		    found=true;
		    break;
		}
	    }
	    if found==true{
		break;
	    }
	}
    }

    println!("SUM: {sum_copy_pairs}");
}
