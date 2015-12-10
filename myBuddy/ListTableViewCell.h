//
//  ListTableViewCell.h
//  myBuddy
//
//  Created by Teja Nandamuri on 2015-12-09.
//  Copyright © 2015 Venkata Maniteja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *fileName;
@property (nonatomic,weak) IBOutlet UIImageView *icon;

@end
