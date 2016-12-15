//
//  FilterViewController.m
//  TMDbDubizzle
//
//  Created by Priyanka on 2016-12-15.
//  Copyright © 2016 Ranjan. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *minYearTextField;
@property (weak, nonatomic) IBOutlet UITextField *maxYearTextField;

@property (nonatomic, strong) UIDatePicker *datePicker;
@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupDatePicker];
    [self.minYearTextField setInputView:self.datePicker];
    [self.maxYearTextField setInputView:self.datePicker];

}

#pragma mark - Setup

- (void)setupDatePicker {
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 250, 325, 300)];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.hidden = NO;
    [self.datePicker setMaximumDate:[NSDate date]];

    [self.datePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
}


#pragma mark - Delegates

-(void)dateTextField:(id)sender {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = self.datePicker.date;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    
    if ([self.minYearTextField isFirstResponder]) {
        self.minYearTextField.text = [NSString stringWithFormat:@"%@",dateString];
    } else {
        self.maxYearTextField.text = [NSString stringWithFormat:@"%@",dateString];
    }
}

#pragma mark - IBActions

- (IBAction)doneButtonTapped:(id)sender {
    if ([self.delegate conformsToProtocol:@protocol(FilterViewControllerProtocol)]) {
        [self.delegate filteredWithMinYear:self.minYearTextField.text maxYear:self.maxYearTextField.text];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
