//
//  GraphViewController.m
//  notePad
//
//  Created by Administrator on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphViewController.h"
#import "BubbleView.h"
#import "UIColor+NotePad.h"

@implementation GraphViewController
@synthesize scrollView, doubleTapGesture;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIScrollView *tempScrollView=(UIScrollView *)self.scrollView;
    tempScrollView.contentSize=CGSizeMake(868,1011);
    [tempScrollView setBackgroundColor:[UIColor graphColor]];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - gestures
- (IBAction)createBubbleTap:(UIGestureRecognizer*)sender{
    // attached to the |scrollView| double tap gesture for creation of a |bubbleView|
    NSLog(@"createBubblleTap");
    CGPoint touch = [sender locationInView:[sender view]];
    CGFloat standardWidth = 234;
    CGFloat standardHight = 47;
    CGRect standardFrame = CGRectMake(touch.x- standardWidth/2, touch.y - standardHight/2, standardWidth, standardHight);

    BubbleView * newBubbleView = [[[BubbleView alloc] initWithFrame:standardFrame] autorelease];
    
    [[self scrollView] addSubview:newBubbleView];
    
}

@end