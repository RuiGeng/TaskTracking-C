//
//  Task+CoreDataProperties.m
//  TaskTracking-C
//
//  Created by GengRui on 2016-12-19.
//  Copyright © 2016 GengRui. All rights reserved.
//

#import "Task+CoreDataProperties.h"

#import "Task+CoreDataProperties.h"

@implementation Task (CoreDataProperties)

+ (NSFetchRequest<Task *> *)fetchRequest {
    return [[NSFetchRequest alloc] initWithEntityName:@"Task"];
}

@dynamic taskName;
@dynamic dueDate;
@dynamic progress;
@dynamic taskDetail;

@end
