use std::fs::File;
use std::io::{BufReader, BufRead};

fn main(){
    let mut cals_total = 0;
    let mut elvs = Vec::default();
    for l in BufReader::new(File::open("./day1_1.txt").unwrap()).lines(){
	let line = l.unwrap();
	if line.is_empty(){
	    //meaning next line would be for a new elf, reset cals_total here
	    elvs.push(cals_total);
	    cals_total=0;
	    continue;
	}
	let cal: usize = line.parse().unwrap();
	cals_total+=cal;
    }

    elvs.sort();
    println!("MOST callories elve is: {}",elvs.last().unwrap());
}
