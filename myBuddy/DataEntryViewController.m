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
#import <HRColorPickerView.h>
#import "ColorPickerViewController.h"

@interface DataEntryViewController ()<UITextFieldDelegate>{
    int x;
}

@property (nonatomic,weak) IBOutlet UITextField *nameField;
@property (nonatomic,weak) IBOutlet UITextField *passwordField;
@property (nonatomic,weak) IBOutlet UITextField *hintField;
@property (nonatomic,weak) IBOutlet TakePicButton *takePic;

@property (nonatomic,strong) BuddyManager *manager;
@property (nonatomic,strong) FMDatabase *database;

@property (nonatomic,strong)  ColorPickerViewController *colVC;

@property (nonatomic,strong) UIColor *selectedColor;


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
    
   
    
    if ([_nameField.text isEqualToString:@""]) {
        
        [self showAlertWithTitle:@"Please enter all details to save" withMessage:@"One or more fields are empty."];
    }else{
        [self showAlertWithTitle:@"Saved" withMessage:[NSString stringWithFormat:@"Do you want to add color to the item \n[%@]",_nameField.text]];

    }
    
    
    
}

-(void)addPicker{
    
    
   _colVC=[ColorPickerViewController pickerController];
   
    _colVC.view.tag=2;
    
    [_colVC.done addTarget:self action:@selector(doneClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_colVC.view];
  
}

-(void)doneClicked{
    
    _selectedColor=_colVC.colorInfoView.color;
    [self insertDataWithColor:YES];
    for (UIView *view in self.view.subviews){
    
        if ([view tag]==2) {
            
            [UIView animateWithDuration:0.3 animations:^{
                view.alpha=0.0;
            } completion:^(BOOL finished) {
                [view removeFromSuperview];
            }];
           
            

        }
    
    }
    
}

-(void)insertDataWithColor:(BOOL)value{
    
    
    NSString *color=value? [self convertColorToString] : nil;
    
    [_database open];
    [_database executeUpdate:@"insert into fileBase(fileName, filePassword ,filePasswordHint ,fileColor,fileEnteredTime) values(?,?,?,?,?)",
     _nameField.text,_passwordField.text,_hintField.text,color,[NSDate date],nil];
    [_database close];
    
    
    
    _nameField.text=@"";
    _passwordField.text=@"";
    _hintField.text=@"";
    

    
}

-(NSString *)convertColorToString{
    
   return [[CIColor colorWithCGColor:_selectedColor.CGColor] stringRepresentation];
    
}

-(void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)msg{
    
    UIAlertController *aC=[UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction *ok=[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [aC dismissViewControllerAnimated:YES completion:nil];
        
        //present the picker view
        
        if ([title isEqualToString:@"Saved"]) {
             [self addPicker];
        }
        
        
        
    }];
     
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [aC dismissViewControllerAnimated:YES completion:nil];
        
        //save data with dummy color
        if ([title isEqualToString:@"Saved"]) {
              [self insertDataWithColor:NO];
        }
        
    }];
    
    [aC addAction:ok];
    [aC addAction:cancel];
    
    [self presentViewController:aC animated:YES completion:nil];
}

-(void)action:(id)sender{
    
    
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
