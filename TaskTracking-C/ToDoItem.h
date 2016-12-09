//
//  ToDoItem.h
//  TaskTracking-C
//
//  Created by GengRui on 2016-12-08.
//  Copyright © 2016 GengRui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property NSString *itemName;
@property BOOL completed;
@property NSDate *creationDate;

@end
