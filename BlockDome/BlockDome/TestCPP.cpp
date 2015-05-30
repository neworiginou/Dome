//
//  TestCPP.cpp
//  BlockDome
//
//  Created by lbencs on 15/5/27.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#include "TestCPP.h"

void MyClass::method(int arg){
    printf("hello world!");
}


void __ZN7Myclass6methodEi(MyClass *this_, int arg){
    this_->method(2);
}