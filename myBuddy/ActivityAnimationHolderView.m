//
//  ActivityAnimationHolderView.m
//  myBuddy
//
//  Created by Teja Nandamuri on 2015-12-11.
//  Copyright © 2015 Venkata Maniteja. All rights reserved.
//

#import "ActivityAnimationHolderView.h"
#import "ActivityAnimationView.h"

@implementation ActivityAnimationHolderView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [ActivityAnimationView drawActivityCompositionWithMoveLevel:_moveLevel exersizeLevel:_exerciseLevel standLevel:_standLevel];
}


@end
