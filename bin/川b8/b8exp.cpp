#include<iostream>
#include<cstring>
#include"Base64.h"
using namespace std;


static unsigned char enc_flag[] = "302725623367114136663146304610641446154530461071150304613126114131432062306314603103454215431141142334663720!!!!";

//aurora{ffbb42cebb9411ebaf42c30d9b62a176}
int main(){
    string buffer;
    cout << "welcome to actf 2021\nplease input:";
    cin >> buffer;
    auto* result = Base64::b8encode((unsigned char*)buffer.data(),buffer.length());
    if(strcmp((char*)enc_flag,(char*)result) == 0){
        cout << "succ!";
    } else {
        cout << "error!";
    }
    return 0;
}
