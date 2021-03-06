//
//  AddTaskViewController.h
//  TaskTracking-C
//
//  Created by GengRui on 2016-12-08.
//  Copyright © 2016 GengRui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task+CoreDataProperties.h"

@interface AddTaskViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtTask;

@property (weak, nonatomic) IBOutlet UITextField *txtDateTime;

@property (weak, nonatomic) IBOutlet UILabel *labProgress;

@property (weak, nonatomic) IBOutlet UISlider *sliderProgress;

@property (weak, nonatomic) IBOutlet UITextView *txtDetail;

@property (strong, nonatomic) Task *task;

@property NSString *taskName;
@property NSDate *dateTime;
@property NSNumber *progress;
@property NSString *taskDetail;
@property BOOL editFlag;
@property NSInteger rowNumber;

- (void)editTask:(Task *)currentTask;

@end
