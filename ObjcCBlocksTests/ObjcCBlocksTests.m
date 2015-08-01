//
//  ObjcCBlocksTestsARC.m
//  ObjcCBlocksTests
//
//  Created by Ruslan Samsonov on 8/1/15.
//  Copyright (c) 2015 Ruslan Samsonov. All rights reserved.
//

#import "ObjcCBlocksTests.h"

//Powerful command to look at blocks implementation in c++
//clang -rewrite-objc -ObjC ObjcCBlocksTests.m -o ObjcCBlocksTests.cpp

@implementation ObjcCBlocksTests

- (void)test
{
    // MRC, use -fno-objc-arc
    // ARC
    int tmp = 666;
    NSLog(@"blocks1: %@", @[^() {
        NSLog(@"block1");
    }, ^() {
        NSLog(@"block2 %d", tmp);
    }]);
    // MRC:  __NSGlobalBlock__, __NSStackBlock__
    // ARC:  __NSGlobalBlock__, __NSMallocBlock__ (difference between @[...] and [NSArray arrayWithObjects:...], ARC retains block in first case)
    
    NSLog(@"blocks2: %@", [NSArray arrayWithObjects:^() {
        NSLog(@"block1");
    }, ^() {
        NSLog(@"block2 %d", tmp);
    }, nil]);
    // MRC:  __NSGlobalBlock__, __NSStackBlock__
    // ARC:  __NSGlobalBlock__, __NSStackBlock__
    
    __block int tmpBlock = 666;
    void (^block1)() = ^() {
        tmpBlock++;
    };
    block1();
    NSLog(@"block1 %@", block1);
    // MRC: __NSStackBlock__
    // ARC: __NSMallocBlock__ (ARC internaly call _objc_retainBlock in which it copies to __NSMallocBlock__)
    
    NSLog(@"%p", &tmpBlock);
    // MRC: 0x7fff4fc47a00
    // ARC: 0x7fff4fc47a00
    
    void (^block2)() = [block1 copy];
    NSLog(@"block2 %@", block2);
    // MRC: <__NSMallocBlock__: 0x7fe533424f00> (copy call for __NSStackBlock__)
    // ARC: __NSMallocBlock__
    
    NSLog(@"%p", &tmpBlock);
    // MRC: 0x7fe533424098 (dereference variable, while copying)
    // ARC: 0x7fff4fc47a00
    
    void (^block3)() = [block2 copy];
    NSLog(@"block3 %@", block3);
    // MRC: <__NSMallocBlock__: 0x7fe533424f00> (retain actually, because of __NSMallocBlock__ type)
    // ARC: __NSMallocBlock__
    
    block2();
    block3();
    NSLog(@"%d", tmpBlock);
    // MRC: 669
    // ARC: 669
    
    // MRC: Crash, while releasing array with __NSStackBlock__ inside
}

@end
