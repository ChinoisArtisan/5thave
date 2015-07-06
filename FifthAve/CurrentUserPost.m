//
//  CurrentUserPost.m
//  FifthAve
//
//  Created by Johnny on 5/18/15.
//  Copyright (c) 2015 emagid. All rights reserved.
//

#import "CurrentUserPost.h"
#import <Parse/PFObject+Subclass.h>

@implementation CurrentUserPost

@dynamic postComment;
@dynamic postImageFile;
@dynamic postCreatedAt;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    
    return @"Post";
}

@end
