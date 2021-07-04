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
    self.loginText.layer.borderColor = [UIColor colorWithRed:76.0/255 green:92.0/255 blue:104.0/255 alpha:1].CGColor;
    self.loginText.layer.borderWidth = 1.5;
    self.loginText.layer.cornerRadius = 5;
    
    //    setup passwordText
    self.passwordText.layer.borderColor = [UIColor colorWithRed:76.0/255 green:92.0/255 blue:104.0/255 alpha:1].CGColor;
    self.passwordText.layer.borderWidth = 1.5;
    self.passwordText.layer.cornerRadius = 5;
    
    //    setup authorizeButton
    self.authorizeButton.layer.borderColor = [UIColor colorWithRed:128.0/255 green:164.0/255 blue:237.0/255 alpha:1].CGColor;
    self.authorizeButton.layer.borderWidth = 2;
    self.authorizeButton.layer.cornerRadius = 10;
    [self.authorizeButton setTitle:@"Authorize" forState:UIControlStateDisabled];
    [self.authorizeButton setTitleColor:[UIColor colorWithRed:128.0/255 green:164.0/255 blue:237.0/255 alpha:1] forState:UIControlStateDisabled];
    
    
    //    button action
    [self.authorizeButton addTarget:self
                          action:@selector(authorizeButtonTapped:)
                          forControlEvents:UIControlEventTouchUpInside];
//     textField action
//    здесь хотела прописать очистку поля и возват изначального цвета рамки
//    [self.loginText addTarget:self
//                       action:@selector(startWriting:)
//             forControlEvents:UIControlEventEditingDidBegin];
//
//    [self.passwordText addTarget:self
//                       action:@selector(startWriting:)
//             forControlEvents:UIControlEventEditingDidBegin];
    
    // Subscrube on keyboard events
    [self hideWhenTappedAround];
    // Set delegates
    
    self.loginText.delegate = self;
    self.passwordText.delegate = self;
    
    //setup buttons secureCode
    self.oneButton.layer.borderColor = [UIColor colorWithRed:128.0/255 green:164.0/255 blue:237.0/255 alpha:1].CGColor;
    self.oneButton.layer.borderWidth = 1.5;
    self.oneButton.layer.cornerRadius = 25;
    [self.oneButton setTitleColor:[UIColor colorWithRed:128.0/255 green:164.0/255 blue:237.0/255 alpha:1] forState:UIControlStateDisabled];
    self.twoButton.layer.borderColor = [UIColor colorWithRed:128.0/255 green:164.0/255 blue:237.0/255 alpha:1].CGColor;
    self.twoButton.layer.borderWidth = 1.5;
    self.twoButton.layer.cornerRadius = 25;
    [self.twoButton setTitleColor:[UIColor colorWithRed:128.0/255 green:164.0/255 blue:237.0/255 alpha:1] forState:UIControlStateDisabled];
    self.threeButton.layer.borderColor = [UIColor colorWithRed:128.0/255 green:164.0/255 blue:237.0/255 alpha:1].CGColor;
    self.threeButton.layer.borderWidth = 1.5;
    self.threeButton.layer.cornerRadius = 25;
    [self.threeButton setTitleColor:[UIColor colorWithRed:128.0/255 green:164.0/255 blue:237.0/255 alpha:1] forState:UIControlStateDisabled];
    
//    secureButton action
    [self.oneButton addTarget:self
                          action:@selector(oneButtonTapped:)
                          forControlEvents:UIControlEventTouchUpInside];
    [self.twoButton addTarget:self
                          action:@selector(twoButtonTapped:)
                          forControlEvents:UIControlEventTouchUpInside];
    [self.threeButton addTarget:self
                          action:@selector(threeButtonTapped:)
                          forControlEvents:UIControlEventTouchUpInside];
    
//    setup secureCode
    self.secureCode.layer.borderColor = UIColor.blackColor.CGColor;
    self.secureCode.layer.borderWidth = 2;
    self.secureCode.layer.cornerRadius = 10;
}

- (void)authorizeButtonTapped:(UIButton *)sender {
    
    [self.authorizeButton setTitleColor:[UIColor colorWithRed:128.0/255 green:164.0/255 blue:237.0/255 alpha:0.4] forState:UIControlStateHighlighted];
    NSString * loginText = self.loginText.text;
    NSString * passwordText = self.passwordText.text;
    if ((![loginText  isEqual: @"username"]) || (![passwordText isEqual:@"password"])){
        self.loginText.layer.borderColor = [UIColor colorWithRed:194.0/255 green:1.0/255 blue:20.0/255 alpha:1].CGColor;
        self.passwordText.layer.borderColor = [UIColor colorWithRed:194.0/255 green:1.0/255 blue:20.0/255 alpha:1].CGColor;
    } else if (([loginText  isEqual: @"username"]) && ([passwordText  isEqual: @"password"])){
        self.loginText.layer.borderColor = [UIColor colorWithRed:145.0/255 green:199.0/255 blue:177.0/255 alpha:0.5].CGColor;
        self.passwordText.layer.borderColor = [UIColor colorWithRed:145.0/255 green:199.0/255 blue:177.0/255 alpha:0.5].CGColor;
        

    }
    NSLog(@"Authorize button tapped");
}

//- (void)startWriting:(UITextField *)sender {
//    if (![_loginText  isEqual: @"username"]) {
//    self.loginText.layer.borderColor = [UIColor colorWithRed:76.0/255 green:92.0/255 blue:104.0/255 alpha:1].CGColor;
//    [self.loginText setText:nil];
//    }
//    self.passwordText.layer.borderColor = [UIColor colorWithRed:76.0/255 green:92.0/255 blue:104.0/255 alpha:1].CGColor;
//    [self.passwordText setText:nil];
//
//}


-(void)oneButtonTapped:(UIButton *)sender {
    [self.secureText setText:@"1" ];
}
-(void)twoButtonTapped:(UIButton *)sender {
    [self.secureText setText: @"2"];
}
-(void)threeButtonTapped:(UIButton *)sender {
    [self.secureText setText: @"3"];
}

// MARK: - Delegates

// TextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}



//здесь хотела указать ограничения на маленькие буквы и только английскую клавиатуру, но пока не получается
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

