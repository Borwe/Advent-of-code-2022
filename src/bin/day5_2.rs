use std::fs::File;
use std::io::{BufReader, BufRead};
use std::collections::VecDeque;

fn main(){
    let mut stacks: Vec<VecDeque<char>> = Vec::default();
    for l in BufReader::new(File::open("./day5_1.txt").unwrap()).lines(){
	let line = l.unwrap();
	if line.contains("move") {
	    let mut val = line.split("move ").collect::<Vec<_>>().concat();
	    val = val.split("from ").collect::<Vec<_>>().concat();
	    val = val.split(" to").collect::<Vec<_>>().concat();
	    let vals: Vec<usize> = val.split(' ')
		.map(|s| s.parse().unwrap()).collect();
	    assert!(vals.len()==3);//make sure we only got 3 vals
	    let amount = vals[0];
	    let mut tmp: VecDeque<char> = VecDeque::new();
	    {
		let from = stacks.get_mut(vals[1]-1).unwrap();
		for _ in 0..amount{
		    let v = from.pop_back().unwrap();
		    tmp.push_back(v);
		}
	    }
	    let to = stacks.get_mut(vals[2]-1).unwrap();
	    for _ in 0..amount{
		let v = tmp.pop_back().unwrap();
		to.push_back(v);
	    }
	    continue;
	}
	for (i, c) in line.chars().enumerate(){
	    if i==1 && c.is_digit(10){
		break;
	    }
	    if i == 1 || i > 1 && (i-1) % 4 == 0 {
		if c == ' '{
		    continue;
		}

		//get stack to push onto
		let pos: usize = match i {
		    2 => 0,
		    x => {(x-1)/4}
		};

		// create the stack if it doesn't already exist
		if None == stacks.get(pos){
		    println!("POS: {pos}");
		    for _ in 0..pos+1{
			if None == stacks.get(pos) {
			    stacks.push(VecDeque::new());
			}
		    }
		}

		stacks.get_mut(pos).unwrap().push_front(c);
	    }
	}
    }
    println!("STACKS {:?} SIZE: {}",stacks,stacks.len());
}
