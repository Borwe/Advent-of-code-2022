use std::fs::File;
use std::io::{BufReader, BufRead};
use std::collections::{HashSet, VecDeque};

fn main(){
    for l in BufReader::new(File::open("./day6_1.txt").unwrap()).lines(){
	let mut vals_4: VecDeque<char> = VecDeque::new();
	let mut char_pos=0;
	let line = l.unwrap();

	let mut unique = HashSet::with_capacity(4);
	for c in line.chars(){
	    if vals_4.len() < 4{
		vals_4.push_back(c);
		char_pos+=1;
		continue;
	    }
	    unique.clear();
	    for i in vals_4.iter(){
		unique.insert(i.clone());
	    }
	    println!("VALS: {:?}",vals_4);
	    if unique.len() == 4 {
		println!("VALS: {:?} CHAR LOC IS: {char_pos}",vals_4);
		break;
	    }
	    vals_4.pop_front().unwrap();
	    vals_4.push_back(c);
	    char_pos+=1;
	}
    }
}
