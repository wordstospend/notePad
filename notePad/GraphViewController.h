//
//  GraphViewController.h
//  notePad
//
//  Created by Administrator on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphViewController : UIViewController{
    UIScrollView * _graphView;

}

@property (nonatomic, retain) UIScrollView * IBOutlet graphView;

-(IBAction)createBubbleTap:(id)sender;

@end
