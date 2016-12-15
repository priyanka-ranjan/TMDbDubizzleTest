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
@property (weak, nonatomic) IBOutlet UIView *centreView;

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) NSDate *minYearDate;
@property (nonatomic, strong) NSDate *maxYearDate;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDatePicker];
    [self.minYearTextField setInputView:self.datePicker];
    [self.maxYearTextField setInputView:self.datePicker];
    self.centreView.layer.cornerRadius = 10.0f;
    self.centreView.layer.borderColor = [UIColor blackColor].CGColor;
    self.centreView.layer.borderWidth = 1.0f;
    self.errorLabel.textColor = [UIColor redColor];
    
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
        self.minYearDate = eventDate;
    } else {
        self.maxYearTextField.text = [NSString stringWithFormat:@"%@",dateString];
        self.maxYearDate = eventDate;
    }
}

#pragma mark - IBActions

- (IBAction)doneButtonTapped:(id)sender {
    if ([self.maxYearDate compare:self.minYearDate] == NSOrderedAscending) {
        self.errorLabel.hidden = NO;
        self.errorLabel.text = @"Please make sure the max date is larger than the min date.";
    } else if (self.maxYearDate == nil || self.minYearDate == nil) {
        self.errorLabel.hidden = NO;
        self.errorLabel.text = @"Please enter a valid min date and max date.";
    } else if ([self.delegate conformsToProtocol:@protocol(FilterViewControllerProtocol)]) {
        [self.delegate filteredWithMinYear:self.minYearDate maxYear:self.maxYearDate];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)cancelButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
