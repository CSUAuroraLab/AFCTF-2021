#ifndef __Base64__

#define __Base64__

class Base64{
#define BAD_BASE64_CODE 0xBADB64
#define BAD_BASE32_CODE 0xBADB32
#define BAD_BASE16_CODE 0xBADB16
#define BAD_BASE8_CODE  0xBADB8

#define BAD_BASE8_TABLE 0xBADB8B
public:
    static unsigned char* b64decode(unsigned char*);
    static unsigned char* b64encode(unsigned char*,int);
    static unsigned char* b16decode(unsigned char*);
    static unsigned char* b16encode(unsigned char*,int);
    static unsigned char* b8decode(unsigned char*);
    static unsigned char* b8encode(unsigned char*,int);
    static void setBase8Table(const char*);
private:
    static unsigned char  b64table[];//base64用的表
    static unsigned char  b16table[];//base16用的表
    static unsigned char  b8table[]; //base8用的表
}; 

#include "Base64.cpp"

#endif