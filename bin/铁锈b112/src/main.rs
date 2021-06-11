
struct Base64{
    b64_table : String,
    b32_table : String,
    b16_table : String,
}

impl Base64{
    fn new() -> Base64{
        Base64 {
            b64_table: String::from("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz01234567890+/="),
            b32_table: String::from("ABCDEFGHIJKLMNOPQRSTUVWXYZ234567="),
            b16_table: String::from("0123456789ABCDEF"),
        }
    }
    
    pub fn b16encode(&self,target: &[u8]) -> String{
        let mut result = String::new();
        let tab = self.b16_table.as_bytes();
        let tar = target;
        let mut i :usize = 0;
        let len = target.len();
        while i < len{
            result.push(tab[(tar[i] >> 4)as usize] as char);
            result.push(tab[(tar[i] & 0b1111) as usize] as char);
            i+=1;
        }
        return result;
    }

    pub fn b32encode(&self,target: &[u8]) ->String{
        let mut result = String::new();
        let tab = self.b32_table.as_bytes();
        let tar = target;
        let mut i :usize = 0;
        let len = target.len();
        while i + 5 < len {
            let temp :u64 = 
                ((target[i] as u64) << 32) |
                ((target[i+1] as u64) << 24) |
                ((target[i+2] as u64) << 16) |
                ((target[i+3] as u64) << 8) |
                (target[i+4] as u64) ;
            result.push(tab[((temp >> 35) & 0b0001_1111) as usize]as char);
            result.push(tab[((temp >> 30) & 0b0001_1111) as usize]as char);
            result.push(tab[((temp >> 25) & 0b0001_1111) as usize]as char);
            result.push(tab[((temp >> 20) & 0b0001_1111) as usize]as char);
            result.push(tab[((temp >> 15) & 0b0001_1111) as usize]as char);
            result.push(tab[((temp >> 10) & 0b0001_1111) as usize]as char);
            result.push(tab[((temp >> 5) & 0b0001_1111) as usize]as char);
            result.push(tab[(temp & 0b0001_1111) as usize]as char);
            i += 5;
        }
        if i == len {
            return result;
        }
        let mut temp : u64= 0;
        while i < len {
            temp = (temp << 8) + tar[i] as u64;
            i += 1;
        }
        while i % 5 != 0{
            temp = temp << 8;
            i += 1;
        }
        result.push(tab[((temp >> 35) & 0b0001_1111) as usize]as char);
        result.push(tab[((temp >> 30) & 0b0001_1111) as usize]as char);
        if len % 5 == 1{
            for i in 0..6{
                result.push(tab[32] as char);
            }
            return result;
        }
        result.push(tab[((temp >> 25) & 0b0001_1111) as usize]as char);
        result.push(tab[((temp >> 20) & 0b0001_1111) as usize]as char);
        if len % 5 == 2{
            for i in 0..4{
                result.push(tab[32] as char);
            }
            return result;
        }
        result.push(tab[((temp >> 15) & 0b0001_1111) as usize]as char);
        if len % 5 == 3{
            for i in 0..3{
                result.push(tab[32] as char);
            }
            return result;
        }
        result.push(tab[((temp >> 10) & 0b0001_1111) as usize]as char);
        result.push(tab[((temp >> 5) & 0b0001_1111) as usize]as char);
        result.push(tab[32] as char);
        return result;
    }

    pub fn b64encode(&self,target: &[u8]) -> String {
        let mut result = String::new();
        let tab = self.b64_table.as_bytes();
        let tar = target;
        let mut i : usize = 0;
        let len : usize = target.len();
        while i+2  < len {
            let temp : usize = (((tar[i] as u32) << 16) + ((tar[i+1] as u32) << 8) + (tar[i+2] as u32)) as usize ;
            result.push(tab[temp >> 18] as char);
            result.push(tab[(temp >> 12) & 0b0011_1111] as char);
            result.push(tab[(temp >> 6) & 0b0011_1111] as char);
            result.push(tab[temp & 0b0011_1111] as char);
            i+=3;
        }
        if i == len {
            return result;
        }
        else {
            let mut temp : usize = 0;
            while i < len{
                temp = (temp << 8) + tar[i] as usize;
                i += 1;
            }
            while i % 3 != 0{
                temp = temp << 8;
                i += 1;
            }
            result.push(tab[temp >> 18] as char);
            result.push(tab[(temp >> 12) & 0b0011_1111] as char);
            if len % 3 == 2{
                result.push(tab[(temp >> 6) & 0b0011_1111] as char);
            }
            else if len % 3 == 1{
                result.push(tab[65] as char);
            }
            result.push(tab[65] as char);
        }
        return result;
    }
}

//aurora{base64_base32_base16_encode___}
fn main(){
    let args : Vec<String> = std::env::args().collect();
    if args.len() != 2 {
        panic!("No enough ARGS!");
    }
    let a = Base64::new();
    let result = 
        a.b64encode(
            a.b32encode(
                a.b16encode(
                    args[1].as_bytes()
                ).as_bytes()
            ).as_bytes()
        );
    if result != "R1lZVE9OSlhHSTNFTU5aU0dZWVRPUVJXR0kzRENOWlRHWTJUR05SVEdRMlVNTlJTR1lZVE9NWldHVVpUR01aU0dWRERNTVJXR0UzVEdOUlZHTVlUR05SVklZM0RLTlNGR1laVE1SUldHUTNES05LR0dWRERLUlJYSVE9PT09PT0="{
        println!("Error!");
    }
    else{
        println!("Success!");
    }
    return;
}