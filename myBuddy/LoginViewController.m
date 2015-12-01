//
//  LoginViewController.m
//  myBuddy
//
//  Created by Venkata Maniteja on 2015-12-01.
//  Copyright © 2015 Venkata Maniteja. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (nonatomic,weak) IBOutlet UITextField *oneField;
@property (nonatomic,weak) IBOutlet UITextField *twoField;
@property (nonatomic,weak) IBOutlet UITextField *threeField;
@property (nonatomic,weak) IBOutlet UITextField *fourField;




@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self customiseTextFields];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
}

-(void)customiseTextFields{
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
