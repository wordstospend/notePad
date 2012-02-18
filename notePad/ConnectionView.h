//
//  ConnectionView.h
//  notePad
//
//  Created by Nathan Fair on 2/15/12.
//  Copyright (c) 2012 computer science undergraduate association. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphViewController.h"
#import "BubbleView.h"

@interface ConnectionView : UIView{
    CGPoint _controlPoint1;
    CGPoint _controlPoint2;
    CGPoint _point1;
    CGPoint _point2;
}

@property (nonatomic, readwrite) CGPoint controlPoint1;
@property (nonatomic, readwrite) CGPoint controlPoint2;
@property (nonatomic, readwrite) CGPoint point1;
@property (nonatomic, readwrite) CGPoint point2;
@property (nonatomic, retain) BubbleView * bubble1;
@property (nonatomic, retain) BubbleView * bubble2;

- (id)initWithFrame:(CGRect)frame ControlPoint1:(CGPoint)point1 AndControlPoint2:(CGPoint)point2;
- (id)initWithBubble1:(UIView *)bubble1 andBubble2:(UIView *)bubble2 inside:(GraphViewController *)graph;

- (id)initWithPoint1:(CGPoint)point1 Point2:(CGPoint)point2 Control1:(CGPoint)control1 AndControl2:(CGPoint)control2;
- (void)calculatePoints;
@end
