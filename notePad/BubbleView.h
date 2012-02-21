//
//  BubbleView.h
//  notePad
//
//  Created by Administrator on 1/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BubbleView : UIView <UITextFieldDelegate> {
    
}
@property (assign, nonatomic) UITapGestureRecognizer * singleTapGesture;
@property (retain, nonatomic) UITextField * titleBox;
@property (retain, nonatomic) NSMutableArray * connectionsArray;

- (void)panBubble:(UIPanGestureRecognizer *)gestureRecognizer;

- (void)startLink:(UITapGestureRecognizer *)gestureRecognizer;
- (void)removeTextGestureRecognizers;
- (void)titleBoxToFirstResponder:(UITapGestureRecognizer *)gestureRecognizer;
@end
