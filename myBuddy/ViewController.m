//
//  ViewController.m
//  myBuddy
//
//  Created by Venkata Maniteja on 2015-11-30.
//  Copyright © 2015 Venkata Maniteja. All rights reserved.
//

#import "ViewController.h"
#import "ActivityAnimationView.h"

@interface ViewController ()

@property (nonatomic,weak) IBOutlet UISlider *move;
@property (nonatomic,weak) IBOutlet UISlider *exercise;
@property (nonatomic,weak) IBOutlet UISlider *stand;

@property (nonatomic,strong) UIView *animeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

   
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
      
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
