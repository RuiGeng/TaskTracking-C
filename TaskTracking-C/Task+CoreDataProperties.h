//
//  Task+CoreDataProperties.h
//  TaskTracking-C
//
//  Created by GengRui on 2016-12-19.
//  Copyright © 2016 GengRui. All rights reserved.
//

#import "Task+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Task (CoreDataProperties)

+ (NSFetchRequest<Task *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *taskName;
@property (nullable, nonatomic, copy) NSDate *dueDate;
@property (nullable, nonatomic, copy) NSNumber *progress;
@property (nullable, nonatomic, copy) NSString *taskDetail;

@end

NS_ASSUME_NONNULL_END
