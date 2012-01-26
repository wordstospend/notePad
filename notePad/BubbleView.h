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
@property (retain, nonatomic) UITextField * titleBox;

- (void)panBubble:(UIPanGestureRecognizer *)gestureRecognizer;
@end
