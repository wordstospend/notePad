//
//  ConnectionView.h
//  notePad
//
//  Created by Nathan Fair on 2/15/12.
//  Copyright (c) 2012 computer science undergraduate association. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConnectionView : UIView{
    CGPoint _controlPoint1;
    CGPoint _controlPoint2;
}

@property (nonatomic, readwrite) CGPoint controlPoint1;
@property (nonatomic, readwrite) CGPoint controlPoint2;

@end
