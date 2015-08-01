//
//  ObjcCBlocksTests.h
//  ObjcCBlocksTests
//
//  Created by Ruslan Samsonov on 8/1/15.
//  Copyright (c) 2015 Ruslan Samsonov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjcCBlocksSyntax : NSObject

typedef int (^block_type)(int var);
@property (nonatomic, copy) block_type blockAsTypedefProperty;

@property (nonatomic, copy) void (^blockAsProperty)(int var);

- (void (^)(int))blockAsReturnAndParam:(void (^)(int))blockAsParameter;
@end
