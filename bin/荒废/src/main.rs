//aurora{rust_is_safety!Try_to_reverse_it!}

fn main() {
    println!("Welc0me,Please Input");
    let mut das = String::new();
    std::io::stdin().read_line(&mut das).expect("Failed to read line");
    let mut input = das.split_off(7);
    {
        let right_kuohao = input.split_off(input.len() - 3);
        if das != "aurora{" || right_kuohao != "}\r\n"{
            panic!("Invalid Input!");
        }
    }
    let b_input = input.as_bytes();
    let mut enc :Vec<u8> = Vec::new();
    for i in 0..input.len() {
        enc.push(b_input[i] ^ ((i as u8) + 0xaf));
    }
    let result = vec![221, 197, 194, 198, 236, 221, 198, 233, 196, 217, 223, 223, 207, 197, 156, 234, 
    205, 185, 158, 182, 172, 155, 183, 163, 177, 173, 187, 185, 174, 147, 164, 186, 238];
    
    assert_eq!(enc,result,"Input Error");
    println!("Success!");
    return
}
