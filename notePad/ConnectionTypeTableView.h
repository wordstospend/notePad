//
//  ConnectionTypeTableView.h
//  notePad
//
//  Created by Nathan Fair on 1/30/12.
//  Copyright (c) 2012 computer science undergraduate association. All rights reserved.
//

#import <UIKit/UIKit.h>
// redefine this protocol to include more usefull set of methods
@protocol ConnectionPickerDelegate
- (void)colorSelected:(NSString *)color;
@end

@interface ConnectionTypeTableView : UITableViewController {
    NSMutableArray *_connectionTypes;
    id<ConnectionPickerDelegate> _delegate;
}

@property (nonatomic, retain) NSMutableArray *connectionTypes;
@property (nonatomic, assign) id<ConnectionPickerDelegate> delegate;


@end
