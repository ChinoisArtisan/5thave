//
//  FollowUser.m
//  FifthAve
//
//  Created by WANG Michael on 27/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

#import "FollowUser.h"
#import <Parse/PFObject+Subclass.h>

@implementation FollowUser

@dynamic from;
@dynamic to;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    
    return @"FollowUser";
}

@end
