//
//  ConnectionView.m
//  notePad
//
//  Created by Nathan Fair on 2/15/12.
//  Copyright (c) 2012 computer science undergraduate association. All rights reserved.
//

#import "ConnectionView.h"

@implementation ConnectionView
@synthesize controlPoint1=_controlPoint1, controlPoint2=_controlPoint2, point1=_point1, point2=_point2;

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

- (id)initWithPoint1:(CGPoint)point1 Point2:(CGPoint)point2 Control1:(CGPoint)control1 AndControl2:(CGPoint)control2{
    CGFloat pathWidth = 8.0;
    CGFloat pathBuffer = pathWidth/2;
    // a buffer will be added to keep our path on the canvas
    CGRect newFrame = CGRectMake(fminf(point1.x, point2.x)-pathBuffer, fminf(point1.y, point2.y)-pathBuffer, fabsf(point1.x - point2.x) +pathWidth, fabsf(point1.y - point2.y) +pathWidth);
    self = [super initWithFrame:newFrame];
    if (self) {
        // an adjustment must be made to the control points because they are currently in the reference of the parent frame
        self.controlPoint1 = CGPointMake(control1.x - newFrame.origin.x , control1.y - newFrame.origin.y);
        self.controlPoint2 = CGPointMake(control2.x - newFrame.origin.x , control2.y - newFrame.origin.y);
        self.point1 = CGPointMake(point1.x - newFrame.origin.x, point1.y - newFrame.origin.y);
        self.point2 = CGPointMake(point2.x - newFrame.origin.x, point2.y - newFrame.origin.y);
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
    UIBezierPath *path;
    
    path = [UIBezierPath bezierPath];
	[path setLineWidth:4.0];
	[[UIColor blueColor] setStroke];
    [path moveToPoint:self.point1];
	[path addCurveToPoint:self.point2 controlPoint1:[self controlPoint1] controlPoint2:[self controlPoint2]];		
	//[path moveToPoint:CGPointMake(0, 0)];
    //[path addCurveToPoint:CGPointMake(self.frame.size.width, self.frame.size.height) controlPoint1:CGPointMake(0, 0) controlPoint2:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [path stroke];
}


@end
