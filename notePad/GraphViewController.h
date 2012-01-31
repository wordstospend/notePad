//
//  GraphViewController.h
//  notePad
//
//  Created by Administrator on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionTypeTableView.h"
#import "BubbleView.h"

@interface GraphViewController : UIViewController{
    UIPopoverController * _bubbleJoinPopOver;
}

@property (nonatomic, retain) IBOutlet UIScrollView * scrollView;
@property (nonatomic, retain) IBOutlet UIGestureRecognizer * doubleTapGesture;
@property (nonatomic, retain) IBOutlet UIGestureRecognizer * bubbleJoiner;
@property (nonatomic, retain) UIPopoverController * bubbleJoinPopOver;

-(IBAction)createBubbleTap:(UIGestureRecognizer *)sender;
-(IBAction)bubbleJoin:(UIGestureRecognizer *)sender;
-(void)testBubbleGestures:(BubbleView*)resigner;
@end
