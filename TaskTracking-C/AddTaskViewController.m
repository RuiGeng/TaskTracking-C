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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Style UITextView
    [self setUITextViewStyle];
    
    //Date Picker
    [self setDatePicker];
    
    // set Progress
    [self setLabProgressValue:self.sliderProgress.value];
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
    
    self.taskName = self.txtTask.text;
    self.dateTime = self.datePicker.date;
    self.progress = [NSNumber numberWithFloat: self.sliderProgress.value];

}

//Set UITextView Border
-(void) setUITextViewStyle{
    UIColor *borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
    
    //Face
    self.txtDetail.layer.borderColor = borderColor.CGColor;
    self.txtDetail.layer.borderWidth = 1.0;
    self.txtDetail.layer.cornerRadius = 5.0;
    
}

@end
