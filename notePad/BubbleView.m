//
//  BubbleView.m
//  notePad
//
//  Created by Administrator on 1/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//// the purposs of the to act as the view in which bubble data is show.
// it will be a subview of the  GraphViewController
// still not sure how I'll go about controlling these or what will
// be in them... are they just plain views. that is to be seen
//  For now the gerneral idea is that they will be a way for me 
// to model out how there is a basic need for a container class.



#import "BubbleView.h"

@implementation BubbleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // lets just pick a basic color for default :)
        [self setBackgroundColor:[UIColor blueColor]];
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
