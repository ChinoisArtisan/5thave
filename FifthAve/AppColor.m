//
//  AppColor.m
//  5thAve
//
//  Created by Alexei Ilin on 2/7/15.
//  Copyright (c) 2015 KUU.org. All rights reserved.
//

#import "AppColor.h"

@implementation AppColor

+(UIColor *)grayColorApp{
    return  [self colorWithRed:0.176 green:0.176 blue:0.176 alpha:1];
}
+(UIColor *)lightBlueColorApp{
    return  [self colorWithRed:0.259 green:0.631 blue:0.78 alpha:1];
}
+(UIColor *)mainCellColor{
    return [UIColor colorWithRed:0.086 green:0.086 blue:0.086 alpha:1];
}

+ (UIColor *)darkBlackColor {
    
    return [UIColor colorWithRed:0.023 green:0.023 blue:0.023 alpha:1];
}

+ (UIColor *)fifthGrayColor {
    
    return [UIColor colorWithRed:0.045 green:0.046 blue:0.045 alpha:0.8];
}

+ (UIColor *)fbBlueColor {
    
    return [UIColor colorWithRed:60/255.0 green:90/255.0 blue:154/255.0 alpha:1];
}

+ (UIColor *)instaBlueColor {
    
    return [UIColor colorWithRed:83/255.0 green:128/255.0 blue:165/255.0 alpha:1];
}

+ (UIColor *)connectEmailColor {
    
    return [UIColor colorWithRed:120/255.0 green:146/255.0 blue:163/255.0 alpha:1];
}

+ (UIColor *)instaBlackColor {
    
    return [UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1];
}


@end
