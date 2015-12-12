//
//  ViewController.m
//  myBuddy
//
//  Created by Venkata Maniteja on 2015-11-30.
//  Copyright © 2015 Venkata Maniteja. All rights reserved.
//

#import "ViewController.h"
#import "ActivityAnimationView.h"
#import "ActivityAnimationHolderView.h"

@interface ViewController ()

@property (nonatomic,weak) IBOutlet UISlider *move;
@property (nonatomic,weak) IBOutlet UISlider *exercise;
@property (nonatomic,weak) IBOutlet UISlider *stand;

@property (nonatomic,strong) IBOutlet ActivityAnimationHolderView *animeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

   
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
      
}

-(IBAction)move:(UISlider *)sender{
    
    _animeView.moveLevel=sender.value;
    [_animeView setNeedsDisplay];
    
}
-(IBAction)exercise:(UISlider *)sender{
    
    _animeView.exerciseLevel=sender.value;
    [_animeView setNeedsDisplay];

    
}
-(IBAction)stand:(UISlider *)sender{
    
    _animeView.standLevel=sender.value;
    [_animeView setNeedsDisplay];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
