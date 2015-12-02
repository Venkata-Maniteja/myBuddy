//
//  LoginViewController.m
//  myBuddy
//
//  Created by Venkata Maniteja on 2015-12-01.
//  Copyright © 2015 Venkata Maniteja. All rights reserved.
//

#import "LoginViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>{
    
    BOOL answered;
}

@property (nonatomic,assign)    BOOL    oneValue;
@property (nonatomic,assign)    BOOL    twoValue;
@property (nonatomic,assign)    BOOL    threeValue;
@property (nonatomic,assign)    BOOL    fourValue;

@property (nonatomic,weak) IBOutlet UITextField *oneField;
@property (nonatomic,weak) IBOutlet UITextField *twoField;
@property (nonatomic,weak) IBOutlet UITextField *threeField;
@property (nonatomic,weak) IBOutlet UITextField *fourField;

@property (nonatomic,strong) NSMutableString *answerString;

@end

@implementation LoginViewController
@synthesize oneValue=_oneValue;
@synthesize twoValue=_twoValue;
@synthesize threeValue=_threeValue;
@synthesize fourValue=_fourValue;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _answerString=[[NSMutableString alloc]init];
    
    [self addTextFieldObservers];
    
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self customiseTextFields];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [_oneField becomeFirstResponder];
    
}

-(void)addTextFieldObservers{
    
    [_oneField addObserver:self forKeyPath:@"oneField" options:0 context:nil];
    [_twoField addObserver:self forKeyPath:@"twoField" options:0 context:nil];
    [_threeField addObserver:self forKeyPath:@"threeField" options:0 context:nil];
    [_fourField addObserver:self forKeyPath:@"fourField" options:0 context:nil];
    
}



-(void)setOneValue:(BOOL)oneValue{
    
    _oneValue=oneValue;
    
}

-(void)setTwoValue:(BOOL)twoValue{
    
    _twoValue=twoValue;
    
    if (twoValue) {
     
        [_twoField resignFirstResponder];
        [_threeField becomeFirstResponder];
    }
}

-(void)setThreeValue:(BOOL)threeValue{
    
    _threeValue=threeValue;
    
    if (threeValue) {
        [_threeField resignFirstResponder];
        [_fourField becomeFirstResponder];
    }
    
}

-(void)setFourValue:(BOOL)fourValue{
    
    _fourValue=fourValue;
    if (fourValue) {
         [_fourField resignFirstResponder];
        [_oneField resignFirstResponder];
        [_twoField resignFirstResponder];
        [_threeField resignFirstResponder];
        answered=YES;
        
        [self checkForAnswer];
    }
    
   
}

-(void)checkForAnswer{
    
    _oneField.text=@"";
    _twoField.text=@"";
    _threeField.text=@"";
    _fourField.text=@"";
    _oneField.backgroundColor=[UIColor colorWithRed:99/255.0 green:214/255.0 blue:74/255.0 alpha:1];
    _twoField.backgroundColor=[UIColor colorWithRed:99/255.0 green:214/255.0 blue:74/255.0 alpha:1];
    _threeField.backgroundColor=[UIColor colorWithRed:99/255.0 green:214/255.0 blue:74/255.0 alpha:1];
    _fourField.backgroundColor=[UIColor colorWithRed:99/255.0 green:214/255.0 blue:74/255.0 alpha:1];
    
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
        
        if (textField.tag==1) {
            
            //magic has to be done here
                if (textField.text.length==1) {
                    [_oneField resignFirstResponder];
                    [_twoField becomeFirstResponder];
                }
        }else if (textField.tag==2){  //this gets hit when third textfield is filled
            
            [self setOneValue:NO];
            [self setTwoValue:YES];
           
        }else if (textField.tag==3){  //this gets hit when 4th textfield value is filled
            
            [self setThreeValue:YES];
            [self setTwoValue:NO];
            [self setOneValue:NO];
        }else if (textField.tag==4){
            
            [self setFourValue:YES];
            [self setOneValue:NO];
            [self setTwoValue:NO];
            [self setThreeValue:NO];
            
        }
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
    
    if ([textField tag]==4) {
        
        [_answerString appendString:_fourField.text];
        
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"Should begin editing");
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSLog(@"Should end editing");
    
    
    [_answerString appendString:textField.text];
    
    
    return YES;
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
