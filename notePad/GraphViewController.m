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
#import "ConnectionView.h"

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
        
        CGPoint popPoint1 = [sender locationOfTouch:0 inView:[self scrollView]];
        CGPoint popPoint2 = [sender locationOfTouch:1 inView:[self scrollView]];
        //[self placePopOverBetween:popPoint1 And:popPoint2];
        [self placeConnectionBetween:bubbles];
 
    }
    
}

-(void) placePopOverBetween:(CGPoint)point1 And:(CGPoint)point2{
    if (_bubbleJoinPopOver == nil) {
        ConnectionTypeTableView * typeTable = [[[ConnectionTypeTableView alloc] initWithStyle:UITableViewStylePlain] autorelease];
        [self setBubbleJoinPopOver:[[[UIPopoverController alloc] initWithContentViewController:typeTable] autorelease]];
    }
    // compute where to place the popOver
    // for now just place it at touch 1
    CGPoint popPoint1 = point1;
    CGPoint popPoint2 = point2;
    CGPoint popPoint = CGPointMake(.5*(popPoint1.x + popPoint2.x), .5*(popPoint1.y+popPoint2.y));
    CGPoint offset = [[self scrollView] contentOffset];
    NSLog(@"offset %f, %f", offset.x, offset.y);
    NSLog(@"popPoint %f, %f", popPoint.x, popPoint.y);
    CGRect popPlace = CGRectMake(popPoint.x, popPoint.y, 0, 0);
    [self.bubbleJoinPopOver presentPopoverFromRect:popPlace inView:[self scrollView] permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    

}

-(void) placeConnectionBetween:(NSArray*) bubbles{
    
    UIView * bubble1 = [bubbles objectAtIndex:0];
    UIView * bubble2 = [bubbles objectAtIndex:1];
    
    // now find the midpoints of each side
    CGFloat Xmeridian = (bubble1.frame.origin.x + bubble1.frame.size.width)/2;
    CGFloat Ymeridian = (bubble1.frame.origin.y + bubble1.frame.size.height)/2;
    CGPoint midPoints1[] = {
        CGPointMake(Xmeridian, bubble1.frame.origin.y),
        CGPointMake(bubble1.frame.origin.x, Ymeridian),
        CGPointMake(Xmeridian, bubble1.frame.origin.y + bubble1.frame.size.height),
        CGPointMake(bubble1.frame.origin.x + bubble1.frame.size.width, Ymeridian),
    };
    
    Xmeridian = (bubble2.frame.origin.x + bubble2.frame.size.width)/2;
    Ymeridian = (bubble2.frame.origin.y + bubble2.frame.size.height)/2;
    CGPoint midPoints2[] = {
        CGPointMake(Xmeridian, bubble2.frame.origin.y),
        CGPointMake(bubble2.frame.origin.x, Ymeridian),
        CGPointMake(Xmeridian, bubble2.frame.origin.y + bubble2.frame.size.height),
        CGPointMake(bubble2.frame.origin.x + bubble1.frame.size.width, Ymeridian),
    };
    int minIndex1 = 0;
    int minIndex2 = 0;
    CGFloat minDistance = powf(midPoints1[0].x - midPoints2[0].x, 2) + powf(midPoints1[0].y - midPoints2[0].y, 2);
    for (int i = 1 ; i < 4; i++) {
        for (int j = 1; j < 4; j++) {
            CGFloat newDistance = powf(midPoints1[i].x - midPoints2[j].x, 2) + powf(midPoints1[i].y - midPoints2[j].y, 2);
            if (newDistance < minDistance) {
                minDistance = newDistance;
                minIndex1 = i;
                minIndex2 = j;
            }
        }
    }
    
    // a bit of a magic number stuff here the first number is the min distance the control point is from the
    // edge of the bubble.  This should be computed based on what is needed so the line sweeps around the edge of the bubble
    // but computing that is hard so we will just cheat for now. with a bit of experiminations and magic
    CGFloat dx = fminf(10.0, fabsf(midPoints1[minIndex1].x - midPoints2[minIndex2].x));
    CGFloat dy = fminf(10.0, fabsf(midPoints1[minIndex1].y - midPoints2[minIndex2].x));
    
    CGPoint point1 = CGPointMake(midPoints1[minIndex1].x +self.scrollView.contentOffset.x,
                                 midPoints1[minIndex1].y+self.scrollView.contentOffset.y);
    CGPoint control1;
    if (minIndex1 == 2 || 0) {
        // we are changing the y value
        if(minIndex1  == 0){
            control1 = CGPointMake(point1.x, point1.y + dy);
        }
        else{
            control1 = CGPointMake(point1.x, point1.y - dy);
        }
    }
    else{
        // ok we are changing the x
        if (minIndex1 == 1) {
            control1 = CGPointMake(point1.x - dx, point1.y);
        }
        else{
            control1 = CGPointMake(point1.x + dx, point1.y);
        }
    }
    
    // this is a repeat of the above for the seccond control point
    CGPoint point2 =CGPointMake(midPoints2[minIndex2].x +self.scrollView.contentOffset.x,
                                midPoints2[minIndex2].y+self.scrollView.contentOffset.y);
    CGPoint control2;
    if (minIndex2 == 2 || 0) {
        // we are changing the y value
        if(minIndex2  == 0){
            control2 = CGPointMake(point2.x, point2.y + dy);
        }
        else{
            control2 = CGPointMake(point2.x, point2.y - dy);
        }
    }
    else{
        // ok we are changing the x
        if (minIndex2 == 1) {
            control2 = CGPointMake(point2.x - dx, point2.y);
        }
        else{
            control2 = CGPointMake(point2.x + dx, point2.y);
        }
    }
    
    ConnectionView * newconnection = [[ConnectionView alloc] initWithPoint1:point1 Point2:point2 Control1:control1 AndControl2:control2];
    [self.scrollView addSubview:newconnection];
    [newconnection release];


}


@end