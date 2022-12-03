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

fn get_loosing_shape(shape: &str)->String{
    if shape == "A" {
	return "C".to_string();
    }
    if shape == "B" {
	return "A".to_string();
    }
    if shape == "C" {
	return "B".to_string();
    }
    return "-".to_string();//feed back failure
}

fn get_drawing_shape(shape: &str)-> String{
    return shape.clone().to_string()
}

fn get_winning_shape(shape: &str)-> String{
    if shape == "A" {
	return "B".to_string();
    }
    if shape == "B" {
	return "C".to_string();
    }
    if shape == "C" {
	return "A".to_string();
    }
    return "-".to_string();//feed back failure
}

fn get_score(them: &str, me: &str)-> usize{
    if me == "X" {
	let loose = get_loosing_shape(them);
	return 0+get_score_of_shape(&loose);
    }
    if me == "Y" {
	let draw = get_drawing_shape(them);
	return 3+get_score_of_shape(&draw);
    }
    if me == "Z" {
	let win = get_winning_shape(them);
	return 6+get_score_of_shape(&win);
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
