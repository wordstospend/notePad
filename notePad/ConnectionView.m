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
@synthesize bubble1=_bubble1, bubble2=_bubble2;

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

- (id)initWithBubble1:(BubbleView *)bubble1 andBubble2:(BubbleView *)bubble2 inside:(GraphViewController *)graph{
    CGFloat pathWidth = 8.0;
    CGFloat pathBuffer = pathWidth/2;
    CGPoint origin = CGPointMake(fminf(bubble1.frame.origin.x, bubble2.frame.origin.x), fminf(bubble1.frame.origin.y, bubble2.frame.origin.y));
    CGFloat width = fmaxf(bubble1.frame.origin.x+bubble1.frame.size.width, bubble2.frame.origin.x+bubble2.frame.size.width) - origin.x;
    CGFloat height = fmaxf(bubble1.frame.origin.y+bubble1.frame.size.height, bubble2.frame.origin.y+bubble2.frame.size.height) - origin.y;
    
    CGRect newFrame = CGRectMake(origin.x, origin.y,
                                 width, height);
    self = [super initWithFrame:newFrame];
    if (self) {
        [self setBubble1:bubble1];
        [self setBubble2:bubble2];
        [self calculatePoints];
        [self setBackgroundColor:[UIColor clearColor]];  
    }
    return self;
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


#pragma mark - drawing helpers

- (void)calculatePoints{
    // now find the midpoints of each side
    CGFloat Xmeridian = self.bubble1.frame.origin.x + self.bubble1.frame.size.width/2;
    CGFloat Ymeridian = self.bubble1.frame.origin.y + self.bubble1.frame.size.height/2;
    CGPoint midPoints1[] = {
        CGPointMake(Xmeridian, self.bubble1.frame.origin.y),
        CGPointMake(self.bubble1.frame.origin.x, Ymeridian),
        CGPointMake(Xmeridian, self.bubble1.frame.origin.y + self.bubble1.frame.size.height),
        CGPointMake(self.bubble1.frame.origin.x + self.bubble1.frame.size.width, Ymeridian),
    };
    
    Xmeridian = self.bubble2.frame.origin.x + self.bubble2.frame.size.width/2;
    Ymeridian = self.bubble2.frame.origin.y + self.bubble2.frame.size.height/2;
    CGPoint midPoints2[] = {
        CGPointMake(Xmeridian, self.bubble2.frame.origin.y),
        CGPointMake(self.bubble2.frame.origin.x, Ymeridian),
        CGPointMake(Xmeridian, self.bubble2.frame.origin.y + self.bubble2.frame.size.height),
        CGPointMake(self.bubble2.frame.origin.x + self.bubble2.frame.size.width, Ymeridian),
    };
    NSLog(@"quick test %f =4", powf(2.0, 2.0));
    int minIndex1 = 0;
    int minIndex2 = 0;
    CGFloat minDistance = powf(midPoints1[0].x - midPoints2[0].x, 2) + powf(midPoints1[0].y - midPoints2[0].y, 2);
    for (int i = 0 ; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            CGFloat newDistance = powf(midPoints1[i].x - midPoints2[j].x, 2) + powf(midPoints1[i].y - midPoints2[j].y, 2);
            NSLog(@"old min %f, xnewdist %f at index 1: %d index: 2 %d", newDistance, minDistance, i, j);
            if (newDistance < minDistance) {
                minDistance = newDistance;
                minIndex1 = i;
                minIndex2 = j;
            }
        }
    }
    // holy shit that is ugly. lets hope we don't need to debug it :)
    
    // a bit of a magic number stuff here the first number is the min distance the control point is from the
    // edge of the bubble.  This should be computed based on what is needed so the line sweeps around the edge of the bubble
    // but computing that is hard so we will just cheat for now. with a bit of experiminations and magic
    CGFloat dx = fmaxf(10.0, fabsf(midPoints1[minIndex1].x - midPoints2[minIndex2].x)/2);
    CGFloat dy = fmaxf(10.0, fabsf(midPoints1[minIndex1].y - midPoints2[minIndex2].y)/2);
    NSLog(@"The real dx is %f, dx is set to %f", fabsf(midPoints1[minIndex1].x - midPoints2[minIndex2].x)/2, dx);
    NSLog(@"The real dy is %f, dy is set to %f", fabsf(midPoints1[minIndex1].y - midPoints2[minIndex2].y)/2, dy);
    NSLog(@"MinIndex 1 is %d", minIndex1);
    NSLog(@"MinIndex 2 is %d", minIndex2);
    
    self.point1 = CGPointMake(midPoints1[minIndex1].x,
                                 midPoints1[minIndex1].y);
    
    if (minIndex1 == 2 || minIndex1 == 0) {
        // we are changing the y value
        if(minIndex1  == 0){
            self.controlPoint1 = CGPointMake(self.point1.x, self.point1.y - dy);
        }
        else{
            self.controlPoint1 = CGPointMake(self.point1.x, self.point1.y + dy);
        }
    }
    else{
        // ok we are changing the x
        if (minIndex1 == 1) {
            self.controlPoint1 = CGPointMake(self.point1.x - dx, self.point1.y);
        }
        else{
            self.controlPoint1 = CGPointMake(self.point1.x + dx, self.point1.y);
        }
    }
    
    // this is a repeat of the above for the seccond control point
    self.point2 =CGPointMake(midPoints2[minIndex2].x,
                                midPoints2[minIndex2].y);
    if (minIndex2 == 2 || minIndex2 == 0) {
        // we are changing the y value
        if(minIndex2  == 0){
            self.controlPoint2 = CGPointMake(self.point2.x, self.point2.y - dy);
        }
        else{
            self.controlPoint2 = CGPointMake(self.point2.x, self.point2.y + dy);
        }
    }
    else{
        // ok we are changing the x
        if (minIndex2 == 1) {
            self.controlPoint2 = CGPointMake(self.point2.x - dx, self.point2.y);
        }
        else{
            self.controlPoint2 = CGPointMake(self.point2.x + dx, self.point2.y);
        }
    }

    // an adjustment must be made to the control points because they are currently in the reference of the parent frame
    self.controlPoint1 = CGPointMake(self.controlPoint1.x - self.frame.origin.x , self.controlPoint1.y - self.frame.origin.y);
    self.controlPoint2 = CGPointMake(self.controlPoint2.x - self.frame.origin.x , self.controlPoint2.y - self.frame.origin.y);
    self.point1 = CGPointMake(self.point1.x - self.frame.origin.x, self.point1.y - self.frame.origin.y);
    self.point2 = CGPointMake(self.point2.x - self.frame.origin.x, self.point2.y - self.frame.origin.y);

}

@end
