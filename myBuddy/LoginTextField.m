//
//  LoginTextField.m
//  myBuddy
//
//  Created by Venkata Maniteja on 2015-12-01.
//  Copyright © 2015 Venkata Maniteja. All rights reserved.
//

#import "LoginTextField.h"

@implementation LoginTextField

//added commwent

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/







- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    return CGRectZero;
}

- (NSArray *)selectionRectsForRange:(UITextRange *)range
{
    return nil;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(copy:) || action == @selector(selectAll:) || action == @selector(paste:))
    {
        return NO;
    }
    
    return [super canPerformAction:action withSender:sender];
}

@end
