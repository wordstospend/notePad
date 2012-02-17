//
//  ConnectionView.m
//  notePad
//
//  Created by Nathan Fair on 2/15/12.
//  Copyright (c) 2012 computer science undergraduate association. All rights reserved.
//

#import "ConnectionView.h"

@implementation ConnectionView
@synthesize controlPoint1=_controlPoint1, controlPoint2=_controlPoint2;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame ControlPoint1:(CGPoint)point1 AndControlPoint2:(CGPoint)point2{
    self = [super initWithFrame:frame];
    if (self) {
        self.controlPoint1 = point1;
        self.controlPoint2 = point2;
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame Bubble1:(UIView *)bubble1 andBubble2:(UIView *)bubble2 inside:(GraphViewController *)graph{
    self = [super initWithFrame:frame];
    if (self) {
        // now we need to set control points and all to do this the right way
    }
}
- (void)drawRect:(CGRect)rect
{
    [self setBackgroundColor:[UIColor brownColor]];
    UIBezierPath *path;
    
    path = [UIBezierPath bezierPath];
	[path setLineWidth:4.0];
	[[UIColor blueColor] setStroke];
    [path moveToPoint:CGPointMake(0, 0)];
	[path addCurveToPoint:CGPointMake(self.frame.size.width, self.frame.size.height) controlPoint1:[self controlPoint1] controlPoint2:[self controlPoint2]];		
	
    [path stroke];
}


@end
