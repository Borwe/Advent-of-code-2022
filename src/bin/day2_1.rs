use std::fs::File;
use std::io::{BufReader, BufRead};

const ROCK: usize = 1;
const PAPER: usize = 2;
const SIZ: usize = 3;

fn get_score_of_shape(shape: &str)-> usize{
    if shape == "A" || shape == "X" {
	ROCK
    }else if shape == "B" || shape == "Y" {
	PAPER
    }else if shape == "C" || shape == "Z" {
	SIZ
    }else {
	panic!("Should never reach here");
    }
}

fn get_score(them: &str, me: &str)-> usize{
    if me == "X" && them == "A" || me == "Y" && them == "B" || me == "Z" && them == "C" {
	return 3 + get_score_of_shape(them)
    }
    if me == "X" && them == "C"{
	return 6 + get_score_of_shape(me);
    }else if me == "Z" && them == "A"{
	return 0 + get_score_of_shape(me);
    }

    if me == "Z" && them == "B"{
	return 6 + get_score_of_shape(me);
    }else if me == "Y" && them == "C"{
	return 0 + get_score_of_shape(me);
    }

    if me == "Y" && them == "A"{
	return 6 + get_score_of_shape(me);
    }else if me == "X" && them == "B"{
	return 0 + get_score_of_shape(me);
    }
    println!("WTF!!! {} {}",me, them);
    0
}

fn main(){
    let mut score: usize = 0;
    for l in BufReader::new(File::open("./day2_1.txt").unwrap()).lines(){
	let line = l.unwrap();
	let vals = line.split(' ').collect::<Vec<&str>>();
	let (them,me) = (vals[0],vals[1]);
	score+=get_score(them,me);
    }
    println!("Total: {score}");
}
