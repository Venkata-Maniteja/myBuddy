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
    BOOL deleteKey;
    int     x;
}

@property (nonatomic,weak)IBOutlet StackView *stackView;
@property (nonatomic,strong) IBOutlet UITextField *oneField;
@property (nonatomic,strong) UIImageView *maskView1;
@property (nonatomic,strong) UIImageView *maskView2;
@property (nonatomic,strong) UIImageView *maskView3;
@property (nonatomic,strong) UIImageView *maskView4;

@property (nonatomic,strong) UIImage *maskDot;



@property (nonatomic,strong) NSMutableString *answerString;
@property (nonatomic,strong) NSString *savedKeyString;
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
    
    x=0;
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
            _savedKeyString=[_results stringForColumn:@"password"];
            _manager.password=[_results stringForColumn:@"password"];
            [_manager setPasswordSaved:saved];
        }
        [_database close];
    
    return saved;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [self authenticateUser];
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self customiseTextFields];

    
    [_oneField becomeFirstResponder];
    
    
    
}

-(void)addTextFieldObservers{
    
    
    [_oneField addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];
    
}



-(void)checkForAnswer{

    _oneField.text=@"";
    NSString *answer=_savedKeyString;
    
    if ([_answerString isEqualToString:answer]) {
        
        _maskView1.backgroundColor=[UIColor colorWithRed:99/255.0 green:214/255.0 blue:74/255.0 alpha:1]; //green color
        _maskView2.backgroundColor=[UIColor colorWithRed:99/255.0 green:214/255.0 blue:74/255.0 alpha:1];
        _maskView3.backgroundColor=[UIColor colorWithRed:99/255.0 green:214/255.0 blue:74/255.0 alpha:1];
        _maskView4.backgroundColor=[UIColor colorWithRed:99/255.0 green:214/255.0 blue:74/255.0 alpha:1];
        answered=YES;
        
        TabBarController *tabVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
        
        [self presentViewController:tabVC animated:YES completion:nil];
        
        
        
        
    }else{
        
        _maskView1.backgroundColor=[UIColor colorWithRed:228/255.0 green:31/255.0 blue:54/255.0 alpha:1]; //red color
        _maskView2.backgroundColor=[UIColor colorWithRed:228/255.0 green:31/255.0 blue:54/255.0 alpha:1]; //red color
        _maskView3.backgroundColor=[UIColor colorWithRed:228/255.0 green:31/255.0 blue:54/255.0 alpha:1]; //red color
        _maskView4.backgroundColor=[UIColor colorWithRed:228/255.0 green:31/255.0 blue:54/255.0 alpha:1]; //red color
        
        _maskView1.image=nil;
        _maskView2.image=nil;
        _maskView3.image=nil;
        _maskView4.image=nil;
        
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        [_stackView addStackViewAnimation];
        
        [_oneField becomeFirstResponder];
        
        [_answerString setString:@""];

        
    }
}


-(void)customiseTextFields{
    
    _oneField.delegate=self;
    _oneField.layer.borderColor=[UIColor clearColor].CGColor;
    [self addUIViewsintoTextField];
    
}

-(void)addUIViewsintoTextField{
    
    _maskView1=[[UIImageView alloc]initWithFrame:CGRectMake(_stackView.frame.origin.x, _stackView.frame.origin.y, _oneField.frame.size.width/4, _oneField.frame.size.height)];
    _maskView1.layer.borderColor=[UIColor colorWithRed:13/255.0 green:79/255.0 blue:139/255.0 alpha:1].CGColor;
    _maskView1.layer.borderWidth=2.0;
    _maskView1.layer.cornerRadius=8.0;
    _maskView1.contentMode=UIViewContentModeScaleAspectFit;
    
    
    [self.view addSubview:_maskView1];
    
    _maskView2=[[UIImageView alloc]initWithFrame:CGRectMake(_stackView.frame.origin.x+_maskView1.frame.size.width, _stackView.frame.origin.y, _oneField.frame.size.width/4, _oneField.frame.size.height)];
    _maskView2.layer.borderColor=[UIColor colorWithRed:13/255.0 green:79/255.0 blue:139/255.0 alpha:1].CGColor;
    _maskView2.layer.borderWidth=2.0;
    _maskView2.layer.cornerRadius=8.0;
    
    
    [self.view addSubview:_maskView2];
   
    _maskView3=[[UIImageView alloc]initWithFrame:CGRectMake(_stackView.frame.origin.x+_maskView1.frame.size.width+_maskView2.frame.size.width, _stackView.frame.origin.y, _oneField.frame.size.width/4, _oneField.frame.size.height)];
    _maskView3.layer.borderColor=[UIColor colorWithRed:13/255.0 green:79/255.0 blue:139/255.0 alpha:1].CGColor;
    _maskView3.layer.borderWidth=2.0;
    _maskView3.layer.cornerRadius=8.0;
    
    
    [self.view addSubview:_maskView3];

    _maskView4=[[UIImageView alloc]initWithFrame:CGRectMake(_stackView.frame.origin.x+_maskView1.frame.size.width+_maskView2.frame.size.width+_maskView3.frame.size.width, _stackView.frame.origin.y, _oneField.frame.size.width/4, _oneField.frame.size.height)];
    _maskView4.layer.borderColor=[UIColor colorWithRed:13/255.0 green:79/255.0 blue:139/255.0 alpha:1].CGColor;
    _maskView4.layer.borderWidth=2.0;
    _maskView4.layer.cornerRadius=8.0;
    
    
    [self.view addSubview:_maskView4];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


#pragma text field delegate methods

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    x++;
    
    if (!answered) {
        
            if ([string length]==0) {
                x--;
                if (x==2) {
                    _maskView2.image=nil;
                }
                if (x==3) {
                    _maskView3.image=nil;
                    
                    //image nil not workung
                }
                if (x==1) {
                    _maskView2.image=nil;
                }
                deleteKey=YES;
              
            }
    }
    
              [_answerString appendString:string];
    NSLog(@"x is %d,rnage location is %d",x,range.location);
    
    _maskView1.image=[UIImage imageNamed:@"dot.png"];
    if (x==2) {
        _maskView2.image=[UIImage imageNamed:@"dot.png"];
        
    }
    if (x==3) {
        _maskView3.image=[UIImage imageNamed:@"dot.png"];
        
    }
    if (x==4) {
        _maskView4.image=[UIImage imageNamed:@"dot.png"];
        
    }
                           return YES;
   
}



- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    //check if textfields have values
    NSLog(@"did begin editing: textfield tag is %d, text is %@",textField.tag,textField.text);
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSLog(@"did end begin editing: textfield tag is %d, text is %@",textField.tag,textField.text);
    //check if textfields have values
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"Should begin editing textfield %d",textField.tag);
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSLog(@"Should end editing textfield %d",textField.tag);
    
    
    
    
    
    return YES;
}

-(void)textFieldDidChange:(id)sender{
    
    UITextField *textField=(UITextField *)sender;
    
    if (savedKey) {
        if (_answerString.length==4) {
            [self checkForAnswer];
        }
    }else{
        
        if (isSecondRegister) {
            
            [_secondTimePasscodeString appendString:textField.text];
            
            
        }else{
            
            [_firstTimePasscodeString appendString:textField.text];
        }
        
    }
    
    if ([textField tag]==1) {
        
        if (!deleteKey) {
            
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
                            
                            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
                            [_stackView addStackViewAnimation];
                            
                            //second time passcode is wrong, strt from first.
                            isSecondRegister=NO;
                            answered=NO;
                            savedKey=NO;
                            
                            _savedKeyString=@"";
                            [_firstTimePasscodeString setString:@""];
                            [_secondTimePasscodeString setString:@""];
                            _statusLabel.text=@"Password didnt matched.Try with again!!!";
                            _oneField.text=@"";
                            [_oneField becomeFirstResponder];
                        }
                        
                        
                    }
                }
                
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
    
    _savedKeyString=@"";
    
    _statusLabel.text=@"Enter same passcode again";
    
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
