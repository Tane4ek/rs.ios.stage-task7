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

@property (weak, nonatomic) IBOutlet UIButton *oneButton;
@property (weak, nonatomic) IBOutlet UIButton *twoButton;
@property (weak, nonatomic) IBOutlet UIButton *threeButton;
@property (weak, nonatomic) IBOutlet UIStackView *secureCode;
@property (weak, nonatomic) IBOutlet UITextField *secureText;

@property UIColor *errorColor;
@property UIColor *succesColor;
@property UIColor *activeColor;
@property UIColor *buttonColor;


@end

// MARK: - Keyboard category
@interface RSViewController (KeyboardHandling)
- (void)hideWhenTappedAround;
@end

@implementation RSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    setup colors
    self.errorColor = [UIColor colorWithRed:194.0/255 green:1.0/255 blue:20.0/255 alpha:1];
    self.succesColor = [UIColor colorWithRed:145.0/255 green:199.0/255 blue:177.0/255 alpha:1];
    self.activeColor = [UIColor colorWithRed:76.0/255 green:92.0/255 blue:104.0/255 alpha:1];
    self.buttonColor = [UIColor colorWithRed:128.0/255 green:164.0/255 blue:237.0/255 alpha:1];
    
    // setup programLabel
    [self.programLabel setText:@"RSSchool"];
    //    setup loginText
    self.loginText.layer.borderColor = self.activeColor.CGColor;
    self.loginText.layer.borderWidth = 1.5;
    self.loginText.layer.cornerRadius = 5;
    
    //    setup passwordText
    self.passwordText.layer.borderColor = self.activeColor.CGColor;
    self.passwordText.layer.borderWidth = 1.5;
    self.passwordText.layer.cornerRadius = 5;
    
    //    setup authorizeButton
    self.authorizeButton.layer.borderColor = self.buttonColor.CGColor;
    self.authorizeButton.layer.borderWidth = 2;
    self.authorizeButton.layer.cornerRadius = 10;
    [self.authorizeButton setTitle:@"Authorize" forState:UIControlStateDisabled];
    [self.authorizeButton setTitleColor:self.buttonColor forState:UIControlStateDisabled];
    [self.authorizeButton setImage:[UIImage imageNamed:@"person2x"] forState:UIControlStateNormal];
    [self.authorizeButton setImage:[UIImage imageNamed:@"person-fill2x"] forState:UIControlStateHighlighted];

    //    button action
    [self.authorizeButton addTarget:self
                          action:@selector(authorizeButtonTapped:)
                          forControlEvents:UIControlEventTouchUpInside];
    [self.authorizeButton addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchDown];
    
//     textField action
    [self.loginText addTarget:self
                       action:@selector(startWritingLogin:)
             forControlEvents:UIControlEventEditingDidBegin];

    [self.passwordText addTarget:self
                       action:@selector(startWritingPassword:)
             forControlEvents:UIControlEventEditingDidBegin];
    
    // Subscrube on keyboard events
    [self hideWhenTappedAround];
   
    // Set delegates
    self.loginText.delegate = self;
    self.passwordText.delegate = self;
    self.secureText.delegate = self;
    
    //setup buttons secureCode
    self.oneButton.layer.borderColor = self.buttonColor.CGColor;
    self.oneButton.layer.borderWidth = 1.5;
    self.oneButton.layer.cornerRadius = 25;
    [self.oneButton setTitleColor:self.buttonColor forState:UIControlStateDisabled];
    self.twoButton.layer.borderColor = self.buttonColor.CGColor;
    self.twoButton.layer.borderWidth = 1.5;
    self.twoButton.layer.cornerRadius = 25;
    [self.twoButton setTitleColor:self.buttonColor forState:UIControlStateDisabled];
    self.threeButton.layer.borderColor = self.buttonColor.CGColor;
    self.threeButton.layer.borderWidth = 1.5;
    self.threeButton.layer.cornerRadius = 25;
    [self.threeButton setTitleColor:self.buttonColor forState:UIControlStateDisabled];
    
//    secureButton action
    [self.oneButton addTarget:self
                          action:@selector(oneButtonTapped:)
                          forControlEvents:UIControlEventTouchUpInside];
    [self.oneButton addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchDown];
    [self.twoButton addTarget:self
                          action:@selector(twoButtonTapped:)
                          forControlEvents:UIControlEventTouchUpInside];
    [self.twoButton addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchDown];
    [self.threeButton addTarget:self
                          action:@selector(threeButtonTapped:)
                          forControlEvents:UIControlEventTouchUpInside];
    [self.threeButton addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchDown];
    
//    setup secureCode
    self.secureCode.layer.borderColor = UIColor.whiteColor.CGColor;
    self.secureCode.layer.borderWidth = 2;
    self.secureCode.layer.cornerRadius = 10;
    
//    setup secureText
    self.secureText.enabled = NO;
    [self.secureText setText:@"_"];
}
-(void)buttonTouch:(UIButton *)sender {
//    [sender setHighlighted:false];
        sender.backgroundColor =[self.buttonColor colorWithAlphaComponent:0.2];
        if ([sender isEqual:_authorizeButton]){
            [self.authorizeButton setTitleColor:[self.buttonColor colorWithAlphaComponent:0.4] forState:UIControlStateHighlighted];

        }
}

- (void)authorizeButtonTapped:(UIButton *)sender {
//    [sender setHighlighted:false];
    sender.backgroundColor = UIColor.whiteColor;
    [self.authorizeButton setTitleColor:self.buttonColor forState:UIControlStateHighlighted];
    NSString * loginText = self.loginText.text;
    NSString * passwordText = self.passwordText.text;
    if ((![loginText  isEqual: @"username"]) && (![passwordText isEqual:@"password"])) {
            self.loginText.layer.borderColor = self.errorColor.CGColor;
            self.passwordText.layer.borderColor = self.errorColor.CGColor;
        }
        else if ((![loginText  isEqual: @"username"]) && ([passwordText isEqual:@"password"])){
            self.loginText.layer.borderColor = self.errorColor.CGColor;
            self.passwordText.layer.borderColor = self.succesColor.CGColor;;
        }
        else if (([loginText  isEqual: @"username"]) && (![passwordText isEqual:@"password"])){
            self.loginText.layer.borderColor = self.succesColor.CGColor;;
            self.passwordText.layer.borderColor = self.errorColor.CGColor;
        }
        else if (([loginText  isEqual: @"username"]) && ([passwordText  isEqual: @"password"])){
            self.loginText.layer.borderColor = self.succesColor.CGColor;
            self.passwordText.layer.borderColor = self.succesColor.CGColor;
        
            self.loginText.alpha = 0.5;
            self.passwordText.alpha = 0.5;
            
            self.authorizeButton.alpha = 0.5;
        
            self.loginText.enabled = NO;
            self.passwordText.enabled = NO;
        
            self.secureCode.hidden = NO;
            self.authorizeButton.enabled = NO;
    }
}

- (void)startWritingLogin:(UITextField *)sender {
    self.loginText.layer.borderColor = self.activeColor.CGColor;
    [self.loginText setText:@""];
}
- (void)startWritingPassword:(UITextField *)sender {
    self.passwordText.layer.borderColor = self.activeColor.CGColor;
    [self.passwordText setText:@""];
}

-(void)oneButtonTapped:(UIButton *)sender {
    sender.backgroundColor = UIColor.whiteColor;
    NSString *secureText = self.secureText.text;
    if ([secureText isEqual:@"_"]) {
        [self.secureText setText:@"1 "];
        
    }
    if (!([secureText isEqual:@"_"]) && secureText.length < 6) {
        [self.secureText setText:[secureText stringByAppendingString:@"1 "]];
}
    if (secureText.length == 4) {
        self.secureCode.layer.borderColor = self.errorColor.CGColor;
        [self.secureText setText:@"_"];
    }
}
-(void)twoButtonTapped:(UIButton *)sender {
    sender.backgroundColor = UIColor.whiteColor;
    NSString *secureText = self.secureText.text;
    if ([secureText isEqual:@"_"]) {
        [self.secureText setText:@"2 "];
        
    }
    if (!([secureText isEqual:@"_"]) && secureText.length <= 4) {
        [self.secureText setText:[secureText stringByAppendingString:@"2 "]];
}
    if (secureText.length == 4 && (![secureText isEqual: @"1 3 "])) {
        self.secureCode.layer.borderColor = self.errorColor.CGColor;
        [self.secureText setText:@"_"];
    }
     if (secureText.length == 4 && ([secureText isEqual: @"1 3 "])) {
        self.secureCode.layer.borderColor = self.succesColor.CGColor;
        [self.secureText setText:[secureText stringByAppendingString:@"2 "]];
         
         // setup alert
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Welcome!" message:@"You are successfuly authorized!" preferredStyle:UIAlertControllerStyleAlert];

         __weak typeof(self) weakSelf = self;
         UIAlertAction *refresh = [UIAlertAction actionWithTitle:@"Refresh" style:UIAlertActionStyleDestructive  handler:^(UIAlertAction * _Nonnull action) {
             [weakSelf resetUI];
         }];
         [alert addAction:refresh];
         [self presentViewController:alert animated:YES completion:nil];
     }
}

-(void)threeButtonTapped:(UIButton *)sender {
    sender.backgroundColor = UIColor.whiteColor;
    NSString *secureText = self.secureText.text;
    if ([secureText isEqual:@"_"]) {
        [self.secureText setText:@""];
        [self.secureText setText:@"3 "];
    }
    if (!([secureText isEqual:@"_"]) && secureText.length < 6) {
        [self.secureText setText:[secureText stringByAppendingString:@"3 "]];
}
    if (secureText.length == 4) {
        self.secureCode.layer.borderColor = self.errorColor.CGColor;
        [self.secureText setText:@"_"];
    }
}

- (void)resetUI
{
    self.secureCode.hidden = YES;
    
    self.authorizeButton.enabled = YES;
    self.authorizeButton.alpha = 1.0;
    
    self.loginText.alpha = 1.0;
    self.passwordText.alpha = 1.0;
    
    self.loginText.enabled = YES;
    self.passwordText.enabled = YES;
    
    self.loginText.layer.borderColor = self.activeColor.CGColor;
    self.passwordText.layer.borderColor = self.activeColor.CGColor;
    self.loginText.text = @"";
    self.passwordText.text = @"";
    self.secureText.text = @"_";
    self.secureCode.layer.borderColor = UIColor.clearColor.CGColor;
}
// MARK: - Delegates

// TextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)text {
    if ([textField isEqual:self.loginText]){
    NSCharacterSet *letters = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrsruvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
            BOOL valid = [[text stringByTrimmingCharactersInSet:letters] isEqualToString:@""];
            return valid;
        } else {
            return true;
        }
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


