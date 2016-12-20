//
//  AddTaskViewController.m
//  TaskTracking-C
//
//  Created by GengRui on 2016-12-08.
//  Copyright © 2016 GengRui. All rights reserved.
//

#import "AddTaskViewController.h"

@interface AddTaskViewController ()

@property UIDatePicker *datePicker;

@end

@implementation AddTaskViewController


- (void)configureView {
    // Update the user interface for the detail item.
    if (self.task) {
        
        self.txtTask.text = self.task.taskName;
        
        self.txtDateTime.text = [self formatDate:self.task.dueDate];
        
        self.sliderProgress.value = [self.task.progress floatValue];
        
        [self setLabProgressValue:self.sliderProgress.value];
        
        self.txtDetail.text = self.task.taskDetail;
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Style UITextView
    [self setUITextViewStyle];
    
    //Date Picker
    [self setDatePicker];
    
    // set Progress
    [self setLabProgressValue:self.sliderProgress.value];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)chageProgress:(id)sender {
    // set Progress
    [self setLabProgressValue:self.sliderProgress.value];
}

-(void)setLabProgressValue: (double)progressValue{
    // set Progress
    self.labProgress.text = [NSString stringWithFormat:@"%.f %%", progressValue];
}

- (void)setDatePicker{
    //data Picker
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [self.datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    [self.datePicker addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.txtDateTime.inputView = self.datePicker;
    [self setTxtDateTimeValue:self.datePicker.date];
    
}

- (void)onDatePickerValueChanged:(UIDatePicker *)datePicker
{
    [self setTxtDateTimeValue:datePicker.date];
}

-(void)setTxtDateTimeValue:(NSDate *)date{
    NSDateFormatter __autoreleasing *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    self.txtDateTime.text = [dateFormat stringFromDate:date];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if (self.editFlag){
        NSLog(@"editFlag is true.");

    }else{
        NSLog(@"editFlag is not true.");
    }
   
    self.taskName = self.txtTask.text;
    
    self.dateTime = self.datePicker.date;
    
    self.progress = [NSNumber numberWithFloat:lroundf(self.sliderProgress.value)];
    
    self.taskDetail = self.txtDetail.text;
    
}

//Set UITextView Border
-(void) setUITextViewStyle{
    UIColor *borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
    
    //Face
    self.txtDetail.layer.borderColor = borderColor.CGColor;
    self.txtDetail.layer.borderWidth = 1.0;
    self.txtDetail.layer.cornerRadius = 5.0;
    
}

-(void)editTask:(Task *)currentTask {
    
    if (self.task != currentTask) {
        
        self.task = currentTask;
        // Update the view.
        [self configureView];
    }
}

- (NSString *)formatDate: (NSDate *) DateTime{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:DateTime];
    
    return formattedDateString;
}

@end
