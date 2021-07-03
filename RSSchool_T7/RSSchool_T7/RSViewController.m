//
//  RSViewController.m
//  RSSchool_T7
//
//  Created by Татьяна Лузанова on 01.07.2021.
//

#import "RSViewController.h"

@interface RSViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *programLabel;
@property (weak, nonatomic) IBOutlet UITextField *loginText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UIButton *authorizeButton;


@end

// MARK: - Keyboard category
@interface RSViewController (KeyboardHandling)
- (void)hideWhenTappedAround;
@end


@implementation RSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // setup programLabel
    [self.programLabel setText:@"RSSchool"];
    //    setup loginText
    self.loginText.layer.borderColor = UIColor.blackColor.CGColor;
    self.loginText.layer.borderWidth = 1.5;
    self.loginText.layer.cornerRadius = 5;
    
    //    setup passwordText
    self.passwordText.layer.borderColor = UIColor.blackColor.CGColor;
    self.passwordText.layer.borderWidth = 1.5;
    self.passwordText.layer.cornerRadius = 5;
    
    //    setup authorizeButton
    self.authorizeButton.layer.borderColor = UIColor.blueColor.CGColor;
    self.authorizeButton.layer.borderWidth = 2;
    self.authorizeButton.layer.cornerRadius = 10;
    [self.authorizeButton setTitle:@"Authorize" forState:UIControlStateDisabled];
    [self.authorizeButton setTitleColor:UIColor.blueColor forState:UIControlStateDisabled];
    
    
    //    button Action
    [self.authorizeButton addTarget:self
                             action:@selector(authorizeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
 
    // Subscrube on keyboard events
    [self hideWhenTappedAround];

    // Set delegates
    
    self.loginText.delegate = self;
    self.passwordText.delegate = self;
}

- (void) authorizeButtonTapped:(UIButton *)sender {
    NSString * text = self.loginText.text;
    if (text != @"username") {
        [self.loginText setText:@" "];
        self.loginText.layer.borderColor = UIColor.redColor.CGColor;
    } else {
        [self.loginText setText:text];
        self.loginText.layer.borderColor = UIColor.blackColor.CGColor;
    }
    NSLog(@"Authorize button tapped");
}
// MARK: - Delegates

// TextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)text {
    return ![text containsString:@"A"];
}

@end

// MARK: - Keyboard category

@implementation RSViewController (KeyboardHandling)

- (void)hideWhenTappedAround {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
        action:@selector(hide)];
    [self.view addGestureRecognizer:gesture];
}

- (void)hide {
    [self.view endEditing:true];
}

@end

