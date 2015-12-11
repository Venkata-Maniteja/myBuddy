//
//  ColorPickerViewController.h
//  myBuddy
//
//  Created by Venkata Maniteja on 2015-12-10.
//  Copyright © 2015 Venkata Maniteja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HRColorInfoView.h>
@interface ColorPickerViewController : UIViewController

+(instancetype)pickerController;
@property (nonatomic,weak) IBOutlet UIButton *done;


@property (nonatomic, strong) IBOutlet HRColorInfoView  *colorInfoView;
@property (nonatomic, strong) IBOutlet UIControl  *colorMapView;
@property (nonatomic, strong) IBOutlet UIControl  *brightnessSlider;

@end
