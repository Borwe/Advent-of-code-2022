use std::fs::File;
use std::io::{BufReader, BufRead};

fn main(){
    let a = u32::from('a')-1;//get value of 'a' on pc
    let cap_a = u32::from('A');
    let cap_z = u32::from('Z');

    let mut racs_3: Vec<String> = Vec::default();
    let mut badges_3: Vec<char> = Vec::default();

    for l in BufReader::new(File::open("./day3_1.txt").unwrap()).lines(){

	let line = l.unwrap();
	racs_3.push(line);
	if racs_3.len()==3{
	    //we have gotten all 3 racks
	    let r1 = racs_3[0].clone();
	    let r2 = racs_3[1].clone();
	    let r3 = racs_3[2].clone();

	    for c in r1.chars(){
		if r2.contains(c) && r3.contains(c){
		    badges_3.push(c);
		    racs_3.clear();
		    break;
		}
	    }
	    racs_3.clear();
	}
    }

    let score: u32 = badges_3.into_iter().map(|c|{
	let char_v = u32::from(c);
	if char_v>=cap_a && char_v <= cap_z{
	    let result = u32::from(c)-cap_a+27;
	    result
	}else{
	    let result = char_v -a;
	    result
	}
    }).sum();
    println!("Total: {score}");
}
