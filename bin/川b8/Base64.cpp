#include <cstdlib>
#include <cstring>
#include <cctype>
#include <iostream>

#include "Base64.h"
// base64解码函数，表在类static变量中
// 抛出异常：如果target不是有效的base64字符串，则抛出异常BAD_BASE64_CODE
unsigned char* Base64::b64decode(unsigned char* target){
    unsigned int targetLength = strlen((const char*)target) , temp = 0;
    unsigned char* result = new unsigned char[targetLength+1];
    memset(result,0,targetLength+1);
    for(int i = 0 ; i < targetLength ; i += 4 , temp = 0){
        for(int n = 0,check = 0 ; n <= 64 ; ++n){
            if(target[i] == b64table[n]){
                temp = temp ^ ((n&0b111111) << 18);
                ++check;
            }
            if(target[i+1] == b64table[n]){
                temp = temp ^ ((n&0b111111) << 12);
                ++check;
            }
            if(target[i+2] == b64table[n]){
                temp = temp ^ ((n&0b111111) << 6);
                ++check;
            }
            if(target[i+3] == b64table[n]){
                temp = temp ^ (n&0b111111);
                ++check;
            }
            if(n == 64 && check != 4){
                throw BAD_BASE64_CODE;
            }
        }
        for (int n = 0 ; n < 3 ;++n){
            result[(i/4*3)+n] = (temp >> (16 - n * 8)) & 0b11111111;
        }
    }
    return result;
}

// base64解码函数，表在类static变量中
// 因为strlen可能被\x00截断，所以这个函数需要被解码target的长度作为编码依据 
unsigned char* Base64::b64encode(unsigned char* target , int targetLength){
    unsigned char* result = new unsigned char[targetLength/3*5];
    for(int i = 0 ,temp = 0; i < targetLength ; i+=3){
        temp = (target[i]<<16) | (target[i+1] << 8) | (target[i+2]);
        for(int n = 0;n < 4;++n){
            result[i/3*4+n] = b64table[(temp >> (18 - 6*n)) & 0b111111];
        }
    }
    int end = targetLength / 3;
    switch(targetLength % 3){
        case 1:{
            result[end*4+2] = b64table[64];
        }
        case 2:{
            result[end*4+3] = b64table[64];
            ++end;
        }
        default:{
        	result[end*4] = 0;
		}
    }
    return result;
}

// base16解码函数，表在类static变量中
// 抛出异常：如果target不是有效的base16字符串，则抛出异常BAD_BASE16_CODE
unsigned char* Base64::b16decode(unsigned char* target){
    int targetLength = strlen((const char*)target);
    if(targetLength & 1){
        throw BAD_BASE16_CODE ;
    }
    unsigned char* result = new unsigned char[(targetLength>>1)+0x10];
    for(int i = 0 ; i < targetLength ; i += 2){
        unsigned char temp = 0;
        for (int n = 0 ; n < 2 ; ++n){
            if(isdigit(target[i+n])){
                temp = (temp << 4) + target[i+n] - '0';
            }
            else if(isupper(target[i+n]) && target[i+n] <= 'F'){
                temp = (temp << 4) + target[i+n] - 'A' + 10;
            }
            else if(islower(target[i+n]) && target[i+n] <= 'f'){
                temp = (temp << 4) + target[i+n] - 'a' + 10;
            }
            else throw BAD_BASE16_CODE;
        }
        result[i>>1] = temp;
    }
    return result;
}

// base64函数，表在类static变量中
// 因为strlen可能被\x00截断，所以这个函数需要被解码target的长度作为编码依据
unsigned char* Base64::b16encode(unsigned char* target , int targetLength){
    unsigned char* result = new unsigned char[targetLength*2 + 0x10];
    
    for(int i = 0 ; i < targetLength ; ++i){
        result[i<<1] = b16table[target[i]>>4];
        result[(i<<1)+1] = b16table[target[i] & 0b1111];
    }

    return result;
}

unsigned char* Base64::b8encode(unsigned char* target,int targetLength){
    unsigned char* result = new unsigned char[(targetLength / 3 + 2) * 8 + 1];
    for(int i = 0; i < targetLength; i+=3 ){
        int temp = target[i]<<16 | target[i+1] <<8 | target[i+2];
        for(int n = 0 ; n < 8 ; ++n){
            result[i/3*8 + n] = b8table[(temp >> (21 - 3*n)) & 0b111];
        }
    }
    int end = targetLength / 3;
    switch (targetLength % 3){
        case 1:{
            result[end * 8 + 4] = result[end * 8+ 5] = b8table[8];
        }
        case 2:{
            result[end * 8 + 6] = result [end * 8 + 7] = b8table[8];
            ++end;
        }
        case 0:{
            result[end*8] = 0;
        }
    }
    return result;
}

unsigned char* Base64::b8decode(unsigned char* target){
    int targetLength = strlen((const char*)target);

    if(targetLength % 8 != 0) throw BAD_BASE8_CODE;

    unsigned char* result = new unsigned char[targetLength/8*3+0x10];

    for(int i = 0 ; i < targetLength ; i+=8){
        int temp = 0,count = 0;
        for(int n = 0 ; n<=8 ; ++n){
            if(target[i+0]==b8table[n]){
                ++count;
                temp |= ((n&0b111)<<21);
            }
            if(target[i+1]==b8table[n]){
                ++count;
                temp |= ((n&0b111)<<18);
            }
            if(target[i+2]==b8table[n]){
                ++count;
                temp |= ((n&0b111)<<15);
            }
            if(target[i+3]==b8table[n]){
                ++count;
                temp |= ((n&0b111)<<12);
            }
            if(target[i+4]==b8table[n]){
                ++count;
                temp |= ((n&0b111)<<9);
            }
            if(target[i+5]==b8table[n]){
                ++count;
                temp |= ((n&0b111)<<6);
            }
            if(target[i+6]==b8table[n]){
                ++count;
                temp |= ((n&0b111)<<3);
            }
            if(target[i+7]==b8table[n]){
                ++count;
                temp |= (n&0b111);
            }
        }
        if(count != 8) {
            throw BAD_BASE8_CODE;
        }
        result[(i>>3)*3] = temp >> 16;
        result[(i>>3)*3+1] = (temp >> 8) & 0b11111111;
        result[(i>>3)*3+2] = temp & 0b11111111;
    }
    return result;
}

void Base64::setBase8Table(const char* newTable){
    int newTableLength = strlen(newTable);
    if(!newTable || newTableLength < 8){
        throw BAD_BASE8_TABLE;
    }
    for(int i = 0 ; i < 8 ; ++i){
        b8table[i] = newTable[i];
    }
}

unsigned char Base64::b64table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
unsigned char Base64::b16table[] = "0123456789ABCDEF";
unsigned char Base64::b8table[] = "01234567!";