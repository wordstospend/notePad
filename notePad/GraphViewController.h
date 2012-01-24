//
//  GraphViewController.h
//  notePad
//
//  Created by Administrator on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphViewController : UIViewController{

}

@property (nonatomic, retain) IBOutlet UIScrollView * scrollView;
@property (nonatomic, retain) IBOutlet UIGestureRecognizer * doubleTapGesture;

-(IBAction)createBubbleTap:(id)sender;

@end
