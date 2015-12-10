//
//  TakePicButton.m
//  myBuddy
//
//  Created by Venkata Maniteja on 2015-12-09.
//  Copyright © 2015 Venkata Maniteja. All rights reserved.
//

#import "TakePicButton.h"

@implementation TakePicButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)frame {
    // Drawing code
    
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color5 = [UIColor colorWithRed: 0.907 green: 0.091 blue: 0.091 alpha: 1];
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [UIColor.redColor setStroke];
    bezierPath.lineWidth = 2;
    [bezierPath stroke];
    
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + 20, 81, 80)];
    [UIColor.darkGrayColor setStroke];
    rectanglePath.lineWidth = 1;
    [rectanglePath stroke];
    
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(frame) + 68, CGRectGetMinY(frame) + 8, 24, 25)];
    [color5 setFill];
    [ovalPath fill];
    
    
    //// Text Drawing
    CGRect textRect = CGRectMake(CGRectGetMinX(frame) + 73, CGRectGetMinY(frame) + 14, 13, 14);
    {
        NSString* textContent = [NSString stringWithFormat:@"%d",_badgeNumber];
        NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        textStyle.alignment = NSTextAlignmentCenter;
        
        NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: UIFont.labelFontSize], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};
        
        CGFloat textTextHeight = [textContent boundingRectWithSize: CGSizeMake(textRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, textRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(textRect), CGRectGetMinY(textRect) + (CGRectGetHeight(textRect) - textTextHeight) / 2, CGRectGetWidth(textRect), textTextHeight) withAttributes: textFontAttributes];
        CGContextRestoreGState(context);
    }
    
    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [UIColor.blackColor setStroke];
    bezier2Path.lineWidth = 1;
    [bezier2Path stroke];
    
    
    //// Bezier 3 Drawing
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 20.5, CGRectGetMinY(frame) + 59.5)];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 64.5, CGRectGetMinY(frame) + 59.5) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 63.5, CGRectGetMinY(frame) + 58.5) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 64.5, CGRectGetMinY(frame) + 59.5)];
    [UIColor.blackColor setStroke];
    bezier3Path.lineWidth = 1;
    [bezier3Path stroke];
    
    
    //// Bezier 4 Drawing
    UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
    [bezier4Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 42.5, CGRectGetMinY(frame) + 36.5)];
    [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 42.5, CGRectGetMinY(frame) + 81.5) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 41.5, CGRectGetMinY(frame) + 78.5) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 42.5, CGRectGetMinY(frame) + 81.5)];
    [UIColor.blackColor setStroke];
    bezier4Path.lineWidth = 1;
    [bezier4Path stroke];

}


@end
