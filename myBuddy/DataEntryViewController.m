//
//  DataEntryViewController.m
//  myBuddy
//
//  Created by Venkata Maniteja on 2015-12-09.
//  Copyright © 2015 Venkata Maniteja. All rights reserved.
//

#import "DataEntryViewController.h"
#import "TakePicButton.h"
#import <FMDatabase.h>
#import "BuddyManager.h"

@interface DataEntryViewController ()<UITextFieldDelegate>{
    int x;
}

@property (nonatomic,weak) IBOutlet UITextField *nameField;
@property (nonatomic,weak) IBOutlet UITextField *passwordField;
@property (nonatomic,weak) IBOutlet UITextField *hintField;
@property (nonatomic,weak) IBOutlet TakePicButton *takePic;

@property (nonatomic,strong) BuddyManager *manager;
@property (nonatomic,strong) FMDatabase *database;




@end

@implementation DataEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _manager=[BuddyManager sharedManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"buddyDatabase.sqlite"];
    _database = [FMDatabase databaseWithPath:path];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    x=0;
    
    [self customisePsaswordField];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

-(void)customisePsaswordField{
    
    UIButton *btnColor = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnColor addTarget:self action:@selector(addMask:) forControlEvents:UIControlEventTouchUpInside];
    btnColor.frame = CGRectMake(150, 10, 25, 25);
    [btnColor setBackgroundImage:[UIImage imageNamed:@"eyeMask.png"] forState:UIControlStateNormal];
    [self.passwordField addSubview:btnColor];
    
}

-(void)addMask:(id)sender{
   
    
}

#pragma textfield delegate methods

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma take pic methods

-(IBAction)takePic:(id)sender{
    
    x++;
    [_takePic setBadgeNumber:x];
    [_takePic setNeedsDisplay];
    
    [self insertData];
    
}

-(void)insertData{
    
    //create table fileBase(fileName text primary key, filePassword text ,fileURL text, filePasswordHint text,fileImage BLOB,fileEnteredTime DATETIME)
    
    [_database open];
    [_database executeUpdate:@"insert into fileBase(fileName, filePassword ,filePasswordHint ,fileEnteredTime) values(?,?,?,?)",
     _nameField.text,_passwordField.text,_hintField.text,[NSDate date],nil];
    [_database close];
    
    _nameField.text=@"";
    _passwordField.text=@"";
    _hintField.text=@"";
    
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