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
@synthesize scrollView, doubleTapGesture, bubbleJoiner, bubbleJoinPopOver=_bubbleJoinPopOver;

// for testing
-(void)testBubbleGestures:(BubbleView*)resigner{
    NSLog(@"bubbleView Just resigned");
}

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
    [[newBubbleView singleTapGesture] requireGestureRecognizerToFail:[self bubbleJoiner]];
    [[self scrollView] addSubview:newBubbleView];
    
    
}

-(IBAction)bubbleJoin:(UIGestureRecognizer*)sender{
    NSLog(@"bubbleJoin");
    // I need to fail this if we don't hit two bubbles
    NSMutableArray * bubbles = [[NSMutableArray alloc] initWithCapacity:2]; 
    // now I need to go through it and check each one for collission
    
    for (int i = 0; i < 2; i++) {
        NSEnumerator *e = [[[self scrollView] subviews] objectEnumerator];
        id object;
        while (object = [e nextObject]) {
            if ([object isKindOfClass:[BubbleView class]]) {
                CGPoint touch = [sender locationOfTouch:i inView:(UIView*)object];
                // if a bubble contains the touch then add it to the array;
                if ([(UIView*)object pointInside:touch withEvent:nil]){
                    [bubbles addObject:object];
                }
            }
        }
    }
    if ([bubbles count] != 2) {
        NSLog(@"Fail this joinBubbles");
        [sender setEnabled:NO];
        // this will cause this gesture to fail
        [sender setEnabled:YES];

    }
    else{
        NSLog(@"we've got 2 bubbles");
        // if we don't yet have a popOve create one
        if (_bubbleJoinPopOver == nil) {
            ConnectionTypeTableView * typeTable = [[[ConnectionTypeTableView alloc] initWithStyle:UITableViewStylePlain] autorelease];
            [self setBubbleJoinPopOver:[[[UIPopoverController alloc] initWithContentViewController:typeTable] autorelease]];
        }
        // compute where to place the popOver
        // for now just place it at touch 1
        CGPoint popPoint1 = [sender locationOfTouch:0 inView:[self scrollView]];
        CGPoint popPoint2 = [sender locationOfTouch:1 inView:[self scrollView]];
        CGPoint popPoint = CGPointMake(.5*(popPoint1.x + popPoint2.x), .5*(popPoint1.y+popPoint2.y));
        CGPoint offset = [[self scrollView] contentOffset];
        NSLog(@"offset %f, %f", offset.x, offset.y);
        NSLog(@"popPoint %f, %f", popPoint.x, popPoint.y);
        CGRect popPlace = CGRectMake(popPoint.x, popPoint.y, 0, 0);
        [self.bubbleJoinPopOver presentPopoverFromRect:popPlace inView:[self scrollView] permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

    }
    
}

@end