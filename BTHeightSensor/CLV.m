//
//  CLV.m
//  BTHeightSensor
//
//  Created by Albertino Padin on 4/7/13.
//  Copyright (c) 2013 Albertino Padin. All rights reserved.
//

#import "CLV.h"

@implementation CLV

@synthesize actualFrame;

- (id)initWithFrame:(CGRect)frame
{
    //self = [super initWithFrame:frame];
    self = [super initWithFrame:actualFrame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
