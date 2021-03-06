//
//  ActivityAnimationView.m
//  Activity
//
//  Created by Venkata Maniteja on 2015-12-11.
//  Copyright (c) 2015 Teja Nandamuri. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//

#import "ActivityAnimationView.h"


@implementation ActivityAnimationView

#pragma mark Initialization

+ (void)initialize
{
}

#pragma mark Drawing Methods

+ (void)drawActivityWithMoveLevel: (CGFloat)moveLevel exersizeLevel: (CGFloat)exersizeLevel standLevel: (CGFloat)standLevel 
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Color Declarations
    UIColor* move1 = [UIColor colorWithRed: 0.976 green: 0 blue: 0.055 alpha: 1];
    UIColor* move2 = [UIColor colorWithRed: 1 green: 0 blue: 0.674 alpha: 1];
    UIColor* exercise1 = [UIColor colorWithRed: 0.513 green: 0.927 blue: 0 alpha: 1];
    UIColor* exercise2 = [UIColor colorWithRed: 0.706 green: 1 blue: 0 alpha: 1];
    UIColor* stand1 = [UIColor colorWithRed: 0 green: 0.851 blue: 0.83 alpha: 1];
    UIColor* stand2 = [UIColor colorWithRed: 0 green: 1 blue: 0.904 alpha: 1];

    //// Gradient Declarations
    CGFloat moveGradientLocations[] = {0, 1};
    CGGradientRef moveGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)move1.CGColor, (id)move2.CGColor], moveGradientLocations);
    CGFloat exerciseGradientLocations[] = {0, 1};
    CGGradientRef exerciseGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)exercise1.CGColor, (id)exercise2.CGColor], exerciseGradientLocations);
    CGFloat standGradientLocations[] = {0, 1};
    CGGradientRef standGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)stand1.CGColor, (id)stand2.CGColor], standGradientLocations);

    //// Variable Declarations
    CGFloat moveDash = moveLevel * 408 + 6;
    CGFloat exersizeDash = exersizeLevel * 295 + 6;
    CGFloat standDash = standLevel * 182 + 6;

    //// ColorGroup
    {
        //// MaskOval Drawing
        UIBezierPath* maskOvalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(4, 26, 148, 148)];
        CGContextSaveGState(context);
        [maskOvalPath addClip];
        CGContextDrawLinearGradient(context, moveGradient, CGPointMake(78, 26), CGPointMake(78, 174), 0);
        CGContextRestoreGState(context);


        //// ExerciseOval Drawing
        UIBezierPath* exerciseOvalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(22, 44, 112, 112)];
        CGContextSaveGState(context);
        [exerciseOvalPath addClip];
        CGContextDrawLinearGradient(context, exerciseGradient, CGPointMake(78, 44), CGPointMake(78, 156), 0);
        CGContextRestoreGState(context);
        [UIColor.blackColor setStroke];
        exerciseOvalPath.lineWidth = 1;
        [exerciseOvalPath stroke];


        //// StandOval Drawing
        UIBezierPath* standOvalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(40, 62, 76, 76)];
        CGContextSaveGState(context);
        [standOvalPath addClip];
        CGContextDrawLinearGradient(context, standGradient, CGPointMake(78, 62), CGPointMake(78, 138), 0);
        CGContextRestoreGState(context);
        [UIColor.blackColor setStroke];
        standOvalPath.lineWidth = 1;
        [standOvalPath stroke];
    }


    //// MaskGroup
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 78, 100);
        CGContextRotateCTM(context, 90 * M_PI / 180);

        CGContextSetBlendMode(context, kCGBlendModeDestinationIn);
        CGContextBeginTransparencyLayer(context, NULL);


        //// MoveMask Drawing
        UIBezierPath* moveMaskPath = [UIBezierPath bezierPath];
        [moveMaskPath moveToPoint: CGPointMake(-65, 0)];
        [moveMaskPath addCurveToPoint: CGPointMake(0, -65) controlPoint1: CGPointMake(-65, -35.9) controlPoint2: CGPointMake(-35.9, -65)];
        [moveMaskPath addCurveToPoint: CGPointMake(65, 0) controlPoint1: CGPointMake(35.9, -65) controlPoint2: CGPointMake(65, -35.9)];
        [moveMaskPath addCurveToPoint: CGPointMake(-0, 65) controlPoint1: CGPointMake(65, 35.9) controlPoint2: CGPointMake(35.9, 65)];
        [moveMaskPath addCurveToPoint: CGPointMake(-65, 0) controlPoint1: CGPointMake(-35.9, 65) controlPoint2: CGPointMake(-65, 35.9)];
        [moveMaskPath closePath];
        moveMaskPath.lineCapStyle = kCGLineCapRound;

        [UIColor.blackColor setStroke];
        moveMaskPath.lineWidth = 17;
        CGFloat moveMaskPattern[] = {moveDash, 408};
        [moveMaskPath setLineDash: moveMaskPattern count: 2 phase: 1];
        [moveMaskPath stroke];


        //// ExerciseMask Drawing
        UIBezierPath* exerciseMaskPath = [UIBezierPath bezierPath];
        [exerciseMaskPath moveToPoint: CGPointMake(-47, 0)];
        [exerciseMaskPath addCurveToPoint: CGPointMake(0, -47) controlPoint1: CGPointMake(-47, -25.96) controlPoint2: CGPointMake(-25.96, -47)];
        [exerciseMaskPath addCurveToPoint: CGPointMake(47, 0) controlPoint1: CGPointMake(25.96, -47) controlPoint2: CGPointMake(47, -25.96)];
        [exerciseMaskPath addCurveToPoint: CGPointMake(-0, 47) controlPoint1: CGPointMake(47, 25.96) controlPoint2: CGPointMake(25.96, 47)];
        [exerciseMaskPath addCurveToPoint: CGPointMake(-47, 0) controlPoint1: CGPointMake(-25.96, 47) controlPoint2: CGPointMake(-47, 25.96)];
        [exerciseMaskPath closePath];
        exerciseMaskPath.lineCapStyle = kCGLineCapRound;

        [UIColor.blackColor setStroke];
        exerciseMaskPath.lineWidth = 17;
        CGFloat exerciseMaskPattern[] = {exersizeDash, 295};
        [exerciseMaskPath setLineDash: exerciseMaskPattern count: 2 phase: 1];
        [exerciseMaskPath stroke];


        //// StandMask Drawing
        UIBezierPath* standMaskPath = [UIBezierPath bezierPath];
        [standMaskPath moveToPoint: CGPointMake(-29, 0)];
        [standMaskPath addCurveToPoint: CGPointMake(0, -29) controlPoint1: CGPointMake(-29, -16.02) controlPoint2: CGPointMake(-16.02, -29)];
        [standMaskPath addCurveToPoint: CGPointMake(29, 0) controlPoint1: CGPointMake(16.02, -29) controlPoint2: CGPointMake(29, -16.02)];
        [standMaskPath addCurveToPoint: CGPointMake(-0, 29) controlPoint1: CGPointMake(29, 16.02) controlPoint2: CGPointMake(16.02, 29)];
        [standMaskPath addCurveToPoint: CGPointMake(-29, 0) controlPoint1: CGPointMake(-16.02, 29) controlPoint2: CGPointMake(-29, 16.02)];
        [standMaskPath closePath];
        standMaskPath.lineCapStyle = kCGLineCapRound;

        [UIColor.blackColor setStroke];
        standMaskPath.lineWidth = 17;
        CGFloat standMaskPattern[] = {standDash, 182};
        [standMaskPath setLineDash: standMaskPattern count: 2 phase: 1];
        [standMaskPath stroke];


        CGContextEndTransparencyLayer(context);

        CGContextRestoreGState(context);
    }


    //// Cleanup
    CGGradientRelease(moveGradient);
    CGGradientRelease(exerciseGradient);
    CGGradientRelease(standGradient);
    CGColorSpaceRelease(colorSpace);
}

+ (void)drawActivityCompositionWithMoveLevel: (CGFloat)moveLevel exersizeLevel: (CGFloat)exersizeLevel standLevel: (CGFloat)standLevel
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Color Declarations
    UIColor* move1 = [UIColor colorWithRed: 0.976 green: 0 blue: 0.055 alpha: 1];
    CGFloat move1HSBA[4];
    [move1 getHue: &move1HSBA[0] saturation: &move1HSBA[1] brightness: &move1HSBA[2] alpha: &move1HSBA[3]];

    UIColor* moveBkg = [UIColor colorWithHue: move1HSBA[0] saturation: move1HSBA[1] brightness: 0.196 alpha: move1HSBA[3]];
    UIColor* exercise1 = [UIColor colorWithRed: 0.513 green: 0.927 blue: 0 alpha: 1];
    CGFloat exercise1HSBA[4];
    [exercise1 getHue: &exercise1HSBA[0] saturation: &exercise1HSBA[1] brightness: &exercise1HSBA[2] alpha: &exercise1HSBA[3]];

    UIColor* exerciseBkg = [UIColor colorWithHue: exercise1HSBA[0] saturation: exercise1HSBA[1] brightness: 0.204 alpha: exercise1HSBA[3]];
    UIColor* stand1 = [UIColor colorWithRed: 0 green: 0.851 blue: 0.83 alpha: 1];
    CGFloat stand1HSBA[4];
    [stand1 getHue: &stand1HSBA[0] saturation: &stand1HSBA[1] brightness: &stand1HSBA[2] alpha: &stand1HSBA[3]];

    UIColor* standBkg = [UIColor colorWithHue: stand1HSBA[0] saturation: stand1HSBA[1] brightness: 0.2 alpha: stand1HSBA[3]];

    //// Shadow Declarations
    NSShadow* shadow = [[NSShadow alloc] init];
    [shadow setShadowColor: UIColor.blackColor];
    [shadow setShadowOffset: CGSizeMake(0.1, -0.1)];
    [shadow setShadowBlurRadius: 1];

    //// ColorGroup
    {
        //// MaskOval Drawing
        UIBezierPath* maskOvalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(4, 26, 148, 148)];
        [moveBkg setFill];
        [maskOvalPath fill];


        //// ExerciseOval Drawing
        UIBezierPath* exerciseOvalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(22, 44, 112, 112)];
        [exerciseBkg setFill];
        [exerciseOvalPath fill];
        [UIColor.blackColor setStroke];
        exerciseOvalPath.lineWidth = 1;
        [exerciseOvalPath stroke];


        //// StandOval Drawing
        UIBezierPath* standOvalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(40, 62, 76, 76)];
        [standBkg setFill];
        [standOvalPath fill];
        [UIColor.blackColor setStroke];
        standOvalPath.lineWidth = 1;
        [standOvalPath stroke];
    }


    //// SymbolGroup
    {
        CGContextSaveGState(context);
        CGContextSetBlendMode(context, kCGBlendModeSourceAtop);
        CGContextBeginTransparencyLayer(context, NULL);


        //// Symbol Drawing
        CGRect symbolRect = CGRectMake(0, 0, 156, 195);
        CGContextSaveGState(context);
        UIRectClip(symbolRect);
        CGContextTranslateCTM(context, symbolRect.origin.x, symbolRect.origin.y);

        [ActivityAnimationView drawActivityWithMoveLevel: moveLevel exersizeLevel: exersizeLevel standLevel: standLevel];
        CGContextRestoreGState(context);


        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
    }


    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(57.5, 79.5, 41, 41)];
    [UIColor.blackColor setFill];
    [ovalPath fill];


    //// MoveArrow
    {
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(76.5, 35.5)];
        [bezierPath addLineToPoint: CGPointMake(83.5, 35.5)];
        bezierPath.lineCapStyle = kCGLineCapRound;

        [UIColor.blackColor setStroke];
        bezierPath.lineWidth = 2;
        [bezierPath stroke];


        //// Bezier 2 Drawing
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 83.5, 35.5);
        CGContextRotateCTM(context, -45 * M_PI / 180);

        UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
        [bezier2Path moveToPoint: CGPointMake(-5.5, -0)];
        [bezier2Path addLineToPoint: CGPointMake(0, 0)];
        bezier2Path.lineCapStyle = kCGLineCapRound;

        [UIColor.blackColor setStroke];
        bezier2Path.lineWidth = 2;
        [bezier2Path stroke];

        CGContextRestoreGState(context);


        //// Bezier 3 Drawing
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 83.5, 35.5);
        CGContextRotateCTM(context, 45 * M_PI / 180);

        UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
        [bezier3Path moveToPoint: CGPointMake(-5.5, -0)];
        [bezier3Path addLineToPoint: CGPointMake(0, 0)];
        bezier3Path.lineCapStyle = kCGLineCapRound;

        [UIColor.blackColor setStroke];
        bezier3Path.lineWidth = 2;
        [bezier3Path stroke];

        CGContextRestoreGState(context);
    }


    //// ExerciseArrow
    {
        //// Bezier 4 Drawing
        UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
        [bezier4Path moveToPoint: CGPointMake(76.5, 53.5)];
        [bezier4Path addLineToPoint: CGPointMake(83.5, 53.5)];
        bezier4Path.lineCapStyle = kCGLineCapRound;

        [UIColor.blackColor setStroke];
        bezier4Path.lineWidth = 2;
        [bezier4Path stroke];


        //// Bezier 5 Drawing
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 83.5, 53.5);
        CGContextRotateCTM(context, -45 * M_PI / 180);

        UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
        [bezier5Path moveToPoint: CGPointMake(-5.5, -0)];
        [bezier5Path addLineToPoint: CGPointMake(0, 0)];
        bezier5Path.lineCapStyle = kCGLineCapRound;

        [UIColor.blackColor setStroke];
        bezier5Path.lineWidth = 2;
        [bezier5Path stroke];

        CGContextRestoreGState(context);


        //// Bezier 6 Drawing
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 83.5, 53.5);
        CGContextRotateCTM(context, 45 * M_PI / 180);

        UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
        [bezier6Path moveToPoint: CGPointMake(-5.5, -0)];
        [bezier6Path addLineToPoint: CGPointMake(0, 0)];
        bezier6Path.lineCapStyle = kCGLineCapRound;

        [UIColor.blackColor setStroke];
        bezier6Path.lineWidth = 2;
        [bezier6Path stroke];

        CGContextRestoreGState(context);


        //// Bezier 7 Drawing
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 87.5, 53.5);
        CGContextRotateCTM(context, -45 * M_PI / 180);

        UIBezierPath* bezier7Path = [UIBezierPath bezierPath];
        [bezier7Path moveToPoint: CGPointMake(-5.5, -0)];
        [bezier7Path addLineToPoint: CGPointMake(0, 0)];
        bezier7Path.lineCapStyle = kCGLineCapRound;

        [UIColor.blackColor setStroke];
        bezier7Path.lineWidth = 2;
        [bezier7Path stroke];

        CGContextRestoreGState(context);


        //// Bezier 8 Drawing
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 87.5, 53.5);
        CGContextRotateCTM(context, 45 * M_PI / 180);

        UIBezierPath* bezier8Path = [UIBezierPath bezierPath];
        [bezier8Path moveToPoint: CGPointMake(-5.5, -0)];
        [bezier8Path addLineToPoint: CGPointMake(0, 0)];
        bezier8Path.lineCapStyle = kCGLineCapRound;

        [UIColor.blackColor setStroke];
        bezier8Path.lineWidth = 2;
        [bezier8Path stroke];

        CGContextRestoreGState(context);
    }


    //// StandArrow
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 80, 71.5);
        CGContextRotateCTM(context, -90 * M_PI / 180);



        //// Bezier 9 Drawing
        UIBezierPath* bezier9Path = [UIBezierPath bezierPath];
        [bezier9Path moveToPoint: CGPointMake(-3.5, 0)];
        [bezier9Path addLineToPoint: CGPointMake(3.5, 0)];
        bezier9Path.lineCapStyle = kCGLineCapRound;

        [UIColor.blackColor setStroke];
        bezier9Path.lineWidth = 2;
        [bezier9Path stroke];


        //// Bezier 10 Drawing
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 3.5, 0);
        CGContextRotateCTM(context, -45 * M_PI / 180);

        UIBezierPath* bezier10Path = [UIBezierPath bezierPath];
        [bezier10Path moveToPoint: CGPointMake(-5.5, -0)];
        [bezier10Path addLineToPoint: CGPointMake(0, 0)];
        bezier10Path.lineCapStyle = kCGLineCapRound;

        [UIColor.blackColor setStroke];
        bezier10Path.lineWidth = 2;
        [bezier10Path stroke];

        CGContextRestoreGState(context);


        //// Bezier 11 Drawing
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 3.5, 0);
        CGContextRotateCTM(context, 45 * M_PI / 180);

        UIBezierPath* bezier11Path = [UIBezierPath bezierPath];
        [bezier11Path moveToPoint: CGPointMake(-5.5, -0)];
        [bezier11Path addLineToPoint: CGPointMake(0, 0)];
        bezier11Path.lineCapStyle = kCGLineCapRound;

        [UIColor.blackColor setStroke];
        bezier11Path.lineWidth = 2;
        [bezier11Path stroke];

        CGContextRestoreGState(context);



        CGContextRestoreGState(context);
    }


    //// Text Drawing
    CGRect textRect = CGRectMake(6, 25.5, 58, 19);
    {
        NSString* textContent = @"MOVE";
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
        NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        textStyle.alignment = NSTextAlignmentRight;

        NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue" size: 13], NSForegroundColorAttributeName: move1, NSParagraphStyleAttributeName: textStyle};

        CGFloat textTextHeight = [textContent boundingRectWithSize: CGSizeMake(textRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, textRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(textRect), CGRectGetMinY(textRect) + (CGRectGetHeight(textRect) - textTextHeight) / 2, CGRectGetWidth(textRect), textTextHeight) withAttributes: textFontAttributes];
        CGContextRestoreGState(context);
        CGContextRestoreGState(context);

    }


    //// Text 2 Drawing
    CGRect text2Rect = CGRectMake(6, 42, 58, 19);
    {
        NSString* textContent = @"EXERCISE";
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
        NSMutableParagraphStyle* text2Style = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        text2Style.alignment = NSTextAlignmentRight;

        NSDictionary* text2FontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue" size: 13], NSForegroundColorAttributeName: exercise1, NSParagraphStyleAttributeName: text2Style};

        CGFloat text2TextHeight = [textContent boundingRectWithSize: CGSizeMake(text2Rect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: text2FontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, text2Rect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(text2Rect), CGRectGetMinY(text2Rect) + (CGRectGetHeight(text2Rect) - text2TextHeight) / 2, CGRectGetWidth(text2Rect), text2TextHeight) withAttributes: text2FontAttributes];
        CGContextRestoreGState(context);
        CGContextRestoreGState(context);

    }


    //// Text 3 Drawing
    CGRect text3Rect = CGRectMake(6, 61, 58, 19);
    {
        NSString* textContent = @"STAND";
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
        NSMutableParagraphStyle* text3Style = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        text3Style.alignment = NSTextAlignmentRight;

        NSDictionary* text3FontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue" size: 13], NSForegroundColorAttributeName: stand1, NSParagraphStyleAttributeName: text3Style};

        CGFloat text3TextHeight = [textContent boundingRectWithSize: CGSizeMake(text3Rect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: text3FontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, text3Rect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(text3Rect), CGRectGetMinY(text3Rect) + (CGRectGetHeight(text3Rect) - text3TextHeight) / 2, CGRectGetWidth(text3Rect), text3TextHeight) withAttributes: text3FontAttributes];
        CGContextRestoreGState(context);
        CGContextRestoreGState(context);

    }
}

+ (void)drawCanvas1
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Color Declarations
    UIColor* move1 = [UIColor colorWithRed: 0.976 green: 0 blue: 0.055 alpha: 1];
    UIColor* move2 = [UIColor colorWithRed: 1 green: 0 blue: 0.674 alpha: 1];
    UIColor* exercise1 = [UIColor colorWithRed: 0.513 green: 0.927 blue: 0 alpha: 1];
    UIColor* exercise2 = [UIColor colorWithRed: 0.706 green: 1 blue: 0 alpha: 1];
    UIColor* stand1 = [UIColor colorWithRed: 0 green: 0.851 blue: 0.83 alpha: 1];
    UIColor* stand2 = [UIColor colorWithRed: 0 green: 1 blue: 0.904 alpha: 1];

    //// Gradient Declarations
    CGFloat moveGradientLocations[] = {0, 1};
    CGGradientRef moveGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)move1.CGColor, (id)move2.CGColor], moveGradientLocations);
    CGFloat exerciseGradientLocations[] = {0, 1};
    CGGradientRef exerciseGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)exercise1.CGColor, (id)exercise2.CGColor], exerciseGradientLocations);
    CGFloat standGradientLocations[] = {0, 1};
    CGGradientRef standGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)stand1.CGColor, (id)stand2.CGColor], standGradientLocations);

    //// Variable Declarations
    CGFloat standDash2 = 0.656 * 182 + 6;
    CGFloat moveDash2 = 0.795 * 408 + 6;
    CGFloat exersizeDash2 = 0.327 * 295 + 6;

    //// Group
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 33, 32);

        CGContextBeginTransparencyLayer(context, NULL);


        //// ColorGroup
        {
            //// MaskOval Drawing
            UIBezierPath* maskOvalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(4, 26, 148, 148)];
            CGContextSaveGState(context);
            [maskOvalPath addClip];
            CGContextDrawLinearGradient(context, moveGradient, CGPointMake(78, 26), CGPointMake(78, 174), 0);
            CGContextRestoreGState(context);


            //// ExerciseOval Drawing
            UIBezierPath* exerciseOvalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(22, 44, 112, 112)];
            CGContextSaveGState(context);
            [exerciseOvalPath addClip];
            CGContextDrawLinearGradient(context, exerciseGradient, CGPointMake(78, 44), CGPointMake(78, 156), 0);
            CGContextRestoreGState(context);
            [UIColor.blackColor setStroke];
            exerciseOvalPath.lineWidth = 1;
            [exerciseOvalPath stroke];


            //// StandOval Drawing
            UIBezierPath* standOvalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(40, 62, 76, 76)];
            CGContextSaveGState(context);
            [standOvalPath addClip];
            CGContextDrawLinearGradient(context, standGradient, CGPointMake(78, 62), CGPointMake(78, 138), 0);
            CGContextRestoreGState(context);
            [UIColor.blackColor setStroke];
            standOvalPath.lineWidth = 1;
            [standOvalPath stroke];
        }


        //// MaskGroup
        {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, 78, 100);
            CGContextRotateCTM(context, 90 * M_PI / 180);

            CGContextSetBlendMode(context, kCGBlendModeDestinationIn);
            CGContextBeginTransparencyLayer(context, NULL);


            //// MoveMask Drawing
            UIBezierPath* moveMaskPath = [UIBezierPath bezierPath];
            [moveMaskPath moveToPoint: CGPointMake(-65, 0)];
            [moveMaskPath addCurveToPoint: CGPointMake(0, -65) controlPoint1: CGPointMake(-65, -35.9) controlPoint2: CGPointMake(-35.9, -65)];
            [moveMaskPath addCurveToPoint: CGPointMake(65, 0) controlPoint1: CGPointMake(35.9, -65) controlPoint2: CGPointMake(65, -35.9)];
            [moveMaskPath addCurveToPoint: CGPointMake(-0, 65) controlPoint1: CGPointMake(65, 35.9) controlPoint2: CGPointMake(35.9, 65)];
            [moveMaskPath addCurveToPoint: CGPointMake(-65, 0) controlPoint1: CGPointMake(-35.9, 65) controlPoint2: CGPointMake(-65, 35.9)];
            [moveMaskPath closePath];
            moveMaskPath.lineCapStyle = kCGLineCapRound;

            [UIColor.blackColor setStroke];
            moveMaskPath.lineWidth = 17;
            CGFloat moveMaskPattern[] = {moveDash2, 408};
            [moveMaskPath setLineDash: moveMaskPattern count: 2 phase: 1];
            [moveMaskPath stroke];


            //// ExerciseMask Drawing
            UIBezierPath* exerciseMaskPath = [UIBezierPath bezierPath];
            [exerciseMaskPath moveToPoint: CGPointMake(-47, 0)];
            [exerciseMaskPath addCurveToPoint: CGPointMake(0, -47) controlPoint1: CGPointMake(-47, -25.96) controlPoint2: CGPointMake(-25.96, -47)];
            [exerciseMaskPath addCurveToPoint: CGPointMake(47, 0) controlPoint1: CGPointMake(25.96, -47) controlPoint2: CGPointMake(47, -25.96)];
            [exerciseMaskPath addCurveToPoint: CGPointMake(-0, 47) controlPoint1: CGPointMake(47, 25.96) controlPoint2: CGPointMake(25.96, 47)];
            [exerciseMaskPath addCurveToPoint: CGPointMake(-47, 0) controlPoint1: CGPointMake(-25.96, 47) controlPoint2: CGPointMake(-47, 25.96)];
            [exerciseMaskPath closePath];
            exerciseMaskPath.lineCapStyle = kCGLineCapRound;

            [UIColor.blackColor setStroke];
            exerciseMaskPath.lineWidth = 17;
            CGFloat exerciseMaskPattern[] = {exersizeDash2, 295};
            [exerciseMaskPath setLineDash: exerciseMaskPattern count: 2 phase: 1];
            [exerciseMaskPath stroke];


            //// StandMask Drawing
            UIBezierPath* standMaskPath = [UIBezierPath bezierPath];
            [standMaskPath moveToPoint: CGPointMake(-29, 0)];
            [standMaskPath addCurveToPoint: CGPointMake(0, -29) controlPoint1: CGPointMake(-29, -16.02) controlPoint2: CGPointMake(-16.02, -29)];
            [standMaskPath addCurveToPoint: CGPointMake(29, 0) controlPoint1: CGPointMake(16.02, -29) controlPoint2: CGPointMake(29, -16.02)];
            [standMaskPath addCurveToPoint: CGPointMake(-0, 29) controlPoint1: CGPointMake(29, 16.02) controlPoint2: CGPointMake(16.02, 29)];
            [standMaskPath addCurveToPoint: CGPointMake(-29, 0) controlPoint1: CGPointMake(-16.02, 29) controlPoint2: CGPointMake(-29, 16.02)];
            [standMaskPath closePath];
            standMaskPath.lineCapStyle = kCGLineCapRound;

            [UIColor.blackColor setStroke];
            standMaskPath.lineWidth = 17;
            CGFloat standMaskPattern[] = {standDash2, 182};
            [standMaskPath setLineDash: standMaskPattern count: 2 phase: 1];
            [standMaskPath stroke];


            CGContextEndTransparencyLayer(context);

            CGContextRestoreGState(context);
        }


        CGContextEndTransparencyLayer(context);

        CGContextRestoreGState(context);
    }


    //// Cleanup
    CGGradientRelease(moveGradient);
    CGGradientRelease(exerciseGradient);
    CGGradientRelease(standGradient);
    CGColorSpaceRelease(colorSpace);
}

#pragma mark Generated Images

+ (UIImage*)imageOfActivityCompositionWithMoveLevel: (CGFloat)moveLevel exersizeLevel: (CGFloat)exersizeLevel standLevel: (CGFloat)standLevel
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(156, 195), NO, 0.0f);
    [ActivityAnimationView drawActivityCompositionWithMoveLevel: moveLevel exersizeLevel: exersizeLevel standLevel: standLevel];

    UIImage* imageOfActivityComposition = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return imageOfActivityComposition;
}

@end
