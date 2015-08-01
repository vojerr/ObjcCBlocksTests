//
//  ObjcCBlocksTests.m
//  ObjcCBlocksTests
//
//  Created by Ruslan Samsonov on 8/1/15.
//  Copyright (c) 2015 Ruslan Samsonov. All rights reserved.
//

#import "ObjcCBlocksSyntax.h"

@implementation ObjcCBlocksSyntax

- (void (^)(int))blockAsReturnAndParam:(void (^)(int))blockAsParameter
{
    void (^simpleLocalBlock)(int) = ^(int var) {
        NSLog(@"simpleLocalBlock %d", var);
    };
    simpleLocalBlock(666);
    
    void (^localBlock)(void (^)(int var)) = ^(void (^block)(int var)) {
        NSLog(@"%@", block);
    };
    localBlock(blockAsParameter);
    return nil;
}

@end
