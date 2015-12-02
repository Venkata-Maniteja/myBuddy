//
//  CameraViewController.h
//  myBuddy
//
//  Created by Dhrupa on 2015-12-02.
//  Copyright © 2015 Venkata Maniteja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (strong, nonatomic) UIImagePickerController *imagePicker;


@end



