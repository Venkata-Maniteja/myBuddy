//
//  LoginViewController.m
//  myBuddy
//
//  Created by Venkata Maniteja on 2015-12-01.
//  Copyright © 2015 Venkata Maniteja. All rights reserved.
//

#import "LoginViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "StackView.h"
#import <AudioToolbox/AudioToolbox.h> 
#import "TabBarController.h"
#import "BuddyManager.h"
#import <FMDatabase.h>

@interface LoginViewController ()<UITextFieldDelegate>{
    
    BOOL answered;
    BOOL savedKey;
    BOOL isSecondRegister;
}

@property (nonatomic,weak)IBOutlet StackView *stackView;
@property (nonatomic,weak) IBOutlet UITextField *oneField;
@property (nonatomic,weak) IBOutlet UITextField *twoField;
@property (nonatomic,weak) IBOutlet UITextField *threeField;
@property (nonatomic,weak) IBOutlet UITextField *fourField;

@property (nonatomic,strong) NSMutableString *answerString;
@property (nonatomic,strong) NSMutableString *savedKeyString;
@property (nonatomic,strong) NSMutableString *secondTimePasscodeString;
@property (nonatomic,strong) NSMutableString *firstTimePasscodeString;

@property (nonatomic,weak) IBOutlet UILabel *statusLabel;

@property (nonatomic,strong) NSString *databasePath;
@property (nonatomic,strong) BuddyManager *manager;
@property (nonatomic,strong) FMDatabase *database;
@property (nonatomic,strong) FMResultSet *results;



@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _manager=[BuddyManager sharedManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"buddyDatabase.sqlite"];
    _database = [FMDatabase databaseWithPath:path];
    
    
    _answerString=[[NSMutableString alloc]init];
    _savedKeyString=[[NSMutableString alloc]init];
    _firstTimePasscodeString=[[NSMutableString alloc]init];
    _secondTimePasscodeString=[[NSMutableString alloc]init];
    
    savedKey=[self getIsPasswordSaved];
    
    [self addTextFieldObservers];
    
    if (savedKey) {
        
        _statusLabel.text=@"Enter passcode";
        
    }else{
        
        _statusLabel.text=@"Register your passcode";
        
    }
   
}

-(BOOL)getIsPasswordSaved{
    
    BOOL saved=NO;
        [_database open];
        _results = [_database executeQuery:@"select * from user"];
        while([_results next]) {
            saved=[_results boolForColumn:@"passCreated"];
            _manager.password=[_results stringForColumn:@"password"];
            [_manager setPasswordSaved:saved];
        }
        [_database close];
    
    return saved;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self customiseTextFields];
    
    [self authenticateUser];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [_oneField becomeFirstResponder];
    
    
    
}

-(void)addTextFieldObservers{
    
    
    [_oneField addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];
    [_twoField addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];
    [_threeField addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];
    [_fourField addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];
    
}



-(void)checkForAnswer{
    
    _oneField.text=@"";
    _twoField.text=@"";
    _threeField.text=@"";
    _fourField.text=@"";
    
    NSString *answer=_manager.password;//[[NSUserDefaults standardUserDefaults]objectForKey:@"savedPasscode"];
    
    if ([_answerString isEqualToString:answer]) {
        
        _oneField.backgroundColor=[UIColor colorWithRed:99/255.0 green:214/255.0 blue:74/255.0 alpha:1]; //green color
        _twoField.backgroundColor=[UIColor colorWithRed:99/255.0 green:214/255.0 blue:74/255.0 alpha:1];
        _threeField.backgroundColor=[UIColor colorWithRed:99/255.0 green:214/255.0 blue:74/255.0 alpha:1];
        _fourField.backgroundColor=[UIColor colorWithRed:99/255.0 green:214/255.0 blue:74/255.0 alpha:1];
        
        answered=YES;
        
        TabBarController *tabVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
        
        [self presentViewController:tabVC animated:YES completion:nil];
        
        
        
        
    }else{
        
        _oneField.backgroundColor=[UIColor colorWithRed:228/255.0 green:31/255.0 blue:54/255.0 alpha:1]; //red color
        _twoField.backgroundColor=[UIColor colorWithRed:228/255.0 green:31/255.0 blue:54/255.0 alpha:1];
        _threeField.backgroundColor=[UIColor colorWithRed:228/255.0 green:31/255.0 blue:54/255.0 alpha:1];
        _fourField.backgroundColor=[UIColor colorWithRed:228/255.0 green:31/255.0 blue:54/255.0 alpha:1];
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        [_stackView addStackViewAnimation];
        
        [_oneField becomeFirstResponder];
        
        [_answerString setString:@""];

        
    }
}


-(void)customiseTextFields{
    
    _oneField.delegate=self;
    _twoField.delegate=self;
    _threeField.delegate=self;
    _fourField.delegate=self;
    
    
    
    _oneField.layer.borderColor=[UIColor colorWithRed:13/255.0 green:79/255.0 blue:139/255.0 alpha:1].CGColor;
    _oneField.layer.borderWidth=2.0;
    _oneField.layer.cornerRadius=8.0;
    
    _twoField.layer.borderColor=[UIColor colorWithRed:13/255.0 green:79/255.0 blue:139/255.0 alpha:1].CGColor;
    _twoField.layer.borderWidth=2.0;
    _twoField.layer.cornerRadius=8.0;
    
    _threeField.layer.borderColor=[UIColor colorWithRed:13/255.0 green:79/255.0 blue:139/255.0 alpha:1].CGColor;
    _threeField.layer.borderWidth=2.0;
    _threeField.layer.cornerRadius=8.0;
    
    _fourField.layer.borderColor=[UIColor colorWithRed:13/255.0 green:79/255.0 blue:139/255.0 alpha:1].CGColor;
    _fourField.layer.borderWidth=2.0;
    _fourField.layer.cornerRadius=8.0;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


#pragma text field delegate methods

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
//    //limit each textfield to one character
    
    if (!answered) {
        
    
            if (string.length==1) {
                
                return YES;
            }
            if ([string length]==0) {
                
                NSLog(@"deleted");
                
                return YES;
            }
    }
    else{
        
                return NO;
    }

                return YES;
   
}

-(BOOL)textFieldShouldClear:(UITextField *)textField{
    
    
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"Begin editing");
    
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"Should begin editing");
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSLog(@"Should end editing");
    
    
    
    
    
    return YES;
}

-(void)textFieldDidChange:(id)sender{
    
    UITextField *textField=(UITextField *)sender;
    
    if (savedKey) {
        
        [_answerString appendString:textField.text];
        
    }else{
        
        if (isSecondRegister) {
            
            [_secondTimePasscodeString appendString:textField.text];
            
            
        }else{
            
            [_firstTimePasscodeString appendString:textField.text];
        }
        
    }
    
    
    
    if ([textField tag]==1) {
        
        [_oneField resignFirstResponder];
        [_twoField becomeFirstResponder];
        
    }
    
    if ([textField tag]==2) {
        
        [_twoField resignFirstResponder];
        [_threeField becomeFirstResponder];
        
    }
    
    if ([textField tag]==3) {
        
        [_threeField resignFirstResponder];
        [_fourField becomeFirstResponder];

    }
    
    if ([textField tag]==4) {
        
        [_fourField resignFirstResponder];
        
        
        
        if (!savedKey) {
            if (!isSecondRegister) {
                
                [self showPasswordEnterAgain];
   
            }else{
                
                //save the password and move on to next view
                
                if ([_secondTimePasscodeString isEqualToString:_firstTimePasscodeString]) {
                    
                    _savedKeyString=_secondTimePasscodeString;
                    [self saveKeyAndMoveOn];
                    
                    
                }else{
                    
                    _oneField.backgroundColor=[UIColor colorWithRed:228/255.0 green:31/255.0 blue:54/255.0 alpha:1]; //red color
                    _twoField.backgroundColor=[UIColor colorWithRed:228/255.0 green:31/255.0 blue:54/255.0 alpha:1];
                    _threeField.backgroundColor=[UIColor colorWithRed:228/255.0 green:31/255.0 blue:54/255.0 alpha:1];
                    _fourField.backgroundColor=[UIColor colorWithRed:228/255.0 green:31/255.0 blue:54/255.0 alpha:1];
                    
                    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
                    [_stackView addStackViewAnimation];
                    
                    //second time passcode is wrong, strt from first.
                    isSecondRegister=NO;
                    answered=NO;
                    savedKey=NO;
                    
                    [_savedKeyString setString:@""];
                    [_firstTimePasscodeString setString:@""];
                    [_secondTimePasscodeString setString:@""];
                    _statusLabel.text=@"Password didnt matched.Try with again!!!";
                    _oneField.text=@"";
                    _twoField.text=@"";
                    _threeField.text=@"";
                    _fourField.text=@"";
                    [_oneField becomeFirstResponder];
                }
                
                
            }
        }else{
            [self checkForAnswer];
        }
        
        
    }
    
    
}

-(void)saveKeyAndMoveOn{
    
    //save key on database
    [_manager setPassword:_savedKeyString];
    [_manager setPasswordSaved:YES];
    
    
    
    [_database open];
    [_database executeUpdate:@"insert into user(name, password ,passCreated ,databasePath) values(?,?,?,?)",
     [[UIDevice currentDevice] name],_savedKeyString,[NSNumber numberWithBool:YES],_databasePath,nil];
    [_database close];
    
    
    
//    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"RegisteredKey"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
//    
//    [[NSUserDefaults standardUserDefaults]setObject:_savedKeyString forKey:@"savedPasscode"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    TabBarController *tabVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
    
    [self presentViewController:tabVC animated:YES completion:nil];
    
    
}



-(void)showPasswordEnterAgain{
    
    _oneField.text=@"";
    _twoField.text=@"";
    _threeField.text=@"";
    _fourField.text=@"";
    
    [_savedKeyString setString:@""];
    
    _statusLabel.text=@"Enter same passcode again";
    
    [_fourField resignFirstResponder];
    [_oneField becomeFirstResponder];
    
    isSecondRegister=YES;

    
   
}


-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message{
    
    
    UIAlertController *aCon=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok=[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [aCon dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [aCon addAction:ok];
    
    [self presentViewController:aCon animated:YES completion:nil];
}

-(void)authenticateUser{
    
    LAContext *context=[[LAContext alloc]init];
    
    NSError *authError = nil;
    
    NSString *myLocalizedReasonString = @"Used for quick and secure access to the login the app";

    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    // User authenticated successfully, take appropriate action
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        
                                        TabBarController *tabVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
                                        
                                        [self presentViewController:tabVC animated:YES completion:nil];
                                        
                                        
                                    });
                                } else {
                                    // User did not authenticate successfully, look at error and take appropriate action
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                    switch (error.code) {
                                        case LAErrorSystemCancel:
                                                        [self showAlertWithTitle:@"Log in Failed" message:@"The system stopped the authentication process because another application became active"];
                                            break;
                                        case LAErrorPasscodeNotSet:
                                            
                                                        [self showAlertWithTitle:@"Log in Failed" message:@"No passcode has been set by the user in the device’s Settings."];
                                            break;
                                            
                                        case LAErrorAuthenticationFailed:
                                            
                                                        [self showAlertWithTitle:@"Log in Failed" message:@"Please use correct finger and try again"];
                                            break;
                                            
                                        default:
                                                        [self showAlertWithTitle:@"Log in Failed" message:[error localizedDescription]];
                                            break;
                                    }
                                    
                                        
                                    });

                                }
                            }];
    } else {
        // Could not evaluate policy; look at authError and present an appropriate message to user
    }

    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
