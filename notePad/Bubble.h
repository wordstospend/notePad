//
//  Bubble.h
//  notePad
//
//  Created by Administrator on 1/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Bubble;

@interface Bubble : NSManagedObject

@property (nonatomic, retain) NSNumber * xloc;
@property (nonatomic, retain) NSNumber * yloc;
@property (nonatomic, retain) NSSet *biSibling;
@property (nonatomic, retain) NSSet *fromSiblings;
@property (nonatomic, retain) NSManagedObject *note;
@property (nonatomic, retain) NSManagedObject *parentGraph;
@property (nonatomic, retain) NSManagedObject *subGraph;
@property (nonatomic, retain) NSSet *toSiblings;
@end

@interface Bubble (CoreDataGeneratedAccessors)

- (void)addBiSiblingObject:(Bubble *)value;
- (void)removeBiSiblingObject:(Bubble *)value;
- (void)addBiSibling:(NSSet *)values;
- (void)removeBiSibling:(NSSet *)values;
- (void)addFromSiblingsObject:(Bubble *)value;
- (void)removeFromSiblingsObject:(Bubble *)value;
- (void)addFromSiblings:(NSSet *)values;
- (void)removeFromSiblings:(NSSet *)values;
- (void)addToSiblingsObject:(Bubble *)value;
- (void)removeToSiblingsObject:(Bubble *)value;
- (void)addToSiblings:(NSSet *)values;
- (void)removeToSiblings:(NSSet *)values;
@end
