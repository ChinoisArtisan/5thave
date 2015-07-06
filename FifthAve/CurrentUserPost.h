//
//  CurrentUserPost.h
//  FifthAve
//
//  Created by Johnny on 5/18/15.
//  Copyright (c) 2015 emagid. All rights reserved.
//

#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface CurrentUserPost : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *postCreatedAt;
@property (strong, nonatomic) NSString *postComment;
@property (strong, nonatomic) PFFile *postImageFile;

+ (void)load;
+ (NSString *)parseClassName;

@end
