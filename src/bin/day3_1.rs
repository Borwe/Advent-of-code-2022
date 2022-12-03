use std::fs::File;
use std::io::{BufReader, BufRead};
use std::collections::HashSet;

fn main(){
    let mut score: u32 = 0;
    let a = u32::from('a')-1;//get value of 'a' on pc
    let cap_a = u32::from('A');
    let cap_z = u32::from('Z');
    for l in BufReader::new(File::open("./day3_1.txt").unwrap()).lines(){
	let line = l.unwrap();
	let middle = line.len()/2;
	let first = &line[0..middle];
	let last = &line[middle..];

	let mut matches = HashSet::new();
	for c in first.chars(){
	    if last.contains(c) {
		matches.insert(c);
	    }
	}

	let sum: u32 = matches.into_iter().map(|c|{
	    let char_v = u32::from(c);
	    if char_v>=cap_a && char_v <= cap_z{
		let result = u32::from(c)-cap_a+27;
		result
	    }else{
		let result = char_v -a;
		result
	    }
	}).sum();
	score+=sum;
    }
    println!("Total: {score}");
}
