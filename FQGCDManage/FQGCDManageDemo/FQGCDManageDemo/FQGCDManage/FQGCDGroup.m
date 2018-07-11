//
//  FQGCDGroup.m
//  FQGCDManageDemo
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FQGCDGroup.h"

@interface FQGCDGroup()

/** <#name#> */
@property (nonatomic, strong, readwrite) dispatch_group_t dispatchGroup;


@end

@implementation FQGCDGroup

- (instancetype)init
{
    if (self = [super init]) {
        self.dispatchGroup = dispatch_group_create();
    }
    
    return self;
}

- (void)fq_enter {
    
    dispatch_group_enter(self.dispatchGroup);
}

- (void)fq_leave {
    
    dispatch_group_leave(self.dispatchGroup);
}

- (void)fq_wait {
    
    dispatch_group_wait(self.dispatchGroup, DISPATCH_TIME_FOREVER);
}

- (BOOL)fq_wait:(int64_t)delta {
    
    return dispatch_group_wait(self.dispatchGroup, dispatch_time(DISPATCH_TIME_NOW, delta)) == 0;
}


@end
