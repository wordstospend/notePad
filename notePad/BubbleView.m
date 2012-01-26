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



#import <QuartzCore/QuartzCore.h>
#import "BubbleView.h"
#import "UIColor+NotePad.h"
@implementation BubbleView
@synthesize titleBox;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect textFrame = CGRectMake(9, 8, frame.size.width - 18, 31);
        // set the view to a color and then round it's corrner
        [self setBackgroundColor:[UIColor bubbleBackGroundColor]];
        [self.layer setCornerRadius:15.0f];
        // not required when not working with an image
        //[self.layer setMasksToBounds:YES];
        titleBox =[[[UITextField alloc] initWithFrame:textFrame] autorelease];
        [titleBox.layer setCornerRadius:9.0f];
    
        [titleBox setBackgroundColor:[UIColor bubbleTextBoxColor]];
        [titleBox setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [self addSubview:titleBox];
        [titleBox setDelegate:self];
        
        
        // add move gesture for BubbleView will need to add more later
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panBubble:)];
        [panGesture setMaximumNumberOfTouches:2];
        //[panGesture setDelegate:self];  we will need this if we have simultaneous gestures which we can add later
        [self addGestureRecognizer:panGesture];
        [panGesture release];
        
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

#pragma mark - gestures

- (void)panBubble:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *piece = [gestureRecognizer view];
    
    //[self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gestureRecognizer translationInView:[piece superview]];
        
        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y + translation.y)];
        [gestureRecognizer setTranslation:CGPointZero inView:[piece superview]];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
