//
//  ListDetailViewController.m
//  myBuddy
//
//  Created by Venkata Maniteja on 2015-12-09.
//  Copyright © 2015 Venkata Maniteja. All rights reserved.
//

#import "ListDetailViewController.h"
#import "BuddyManager.h"

@interface ListDetailViewController ()

@property (nonatomic,weak) IBOutlet UILabel *name;
@property (nonatomic,weak) IBOutlet UILabel *pass;
@property (nonatomic,weak) IBOutlet UILabel *hint;

@end

@implementation ListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    _name.text=_manager.fileName;
    _pass.text=_manager.filePassword;
    _hint.text=_manager.hint;
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
