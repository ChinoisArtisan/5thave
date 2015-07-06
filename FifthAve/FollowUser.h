//
//  FollowUser.h
//  FifthAve
//
//  Created by WANG Michael on 27/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//


#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface FollowUser : PFObject <PFSubclassing>

@property (strong, nonatomic) PFUser *from;
@property (strong, nonatomic) PFUser *to;


+ (void)load;
+ (NSString *)parseClassName;

@end