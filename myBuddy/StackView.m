//
//  StackView.m
//  myBuddy
//
//  Created by Venkata Maniteja on 2015-12-02.
//  Copyright © 2015 Venkata Maniteja. All rights reserved.
//

#import "StackView.h"

@interface StackView ()

@property (strong, nonatomic) NSMapTable *completionBlocksByAnimation;

@end

@implementation StackView

#pragma mark - Scaling



- (void)addStackViewAnimation
{
    [self addStackViewAnimationWithBeginTime:0 andFillMode:kCAFillModeBoth andRemoveOnCompletion:NO completion:NULL];
}

- (void)addStackViewAnimationWithCompletion:(void (^)(BOOL finished))completionBlock
{
    [self addStackViewAnimationWithBeginTime:0 andFillMode:kCAFillModeBoth andRemoveOnCompletion:NO completion:completionBlock];
}

- (void)addStackViewAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion
{
    [self addStackViewAnimationWithBeginTime:0 andFillMode:removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth andRemoveOnCompletion:removedOnCompletion completion:NULL];
}

- (void)addStackViewAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock
{
    [self addStackViewAnimationWithBeginTime:0 andFillMode:removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth andRemoveOnCompletion:removedOnCompletion completion:completionBlock];
}

- (void)addStackViewAnimationWithBeginTime:(CFTimeInterval)beginTime andFillMode:(NSString *)fillMode andRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock
{
    CAMediaTimingFunction *linearTiming = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    if (completionBlock)
    {
        CABasicAnimation *representativeAnimation = [CABasicAnimation animationWithKeyPath:@"not.a.real.key"];
        representativeAnimation.duration = 0.400;
        representativeAnimation.delegate = self;
        [self.layer addAnimation:representativeAnimation forKey:@"StackView"];
        [self.completionBlocksByAnimation setObject:completionBlock forKey:[self.layer animationForKey:@"StackView"]];
    }
    
    CAKeyframeAnimation *screenshotTranslationXAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    screenshotTranslationXAnimation.duration = 0.400;
    screenshotTranslationXAnimation.values = @[@(0.000), @(20.000), @(0.000), @(-20.000), @(0.000)];
    screenshotTranslationXAnimation.keyTimes = @[@(0.000), @(0.250), @(0.500), @(0.750), @(1.000)];
    screenshotTranslationXAnimation.timingFunctions = @[linearTiming, linearTiming, linearTiming, linearTiming];
    screenshotTranslationXAnimation.beginTime = beginTime;
    screenshotTranslationXAnimation.fillMode = fillMode;
    screenshotTranslationXAnimation.removedOnCompletion = removedOnCompletion;
    [[self layer] addAnimation:screenshotTranslationXAnimation forKey:@"StackView_TranslationX"];
}

- (void)removeStackViewAnimation
{
    [self.layer removeAnimationForKey:@"StackView"];
    [[self layer] removeAnimationForKey:@"StackView_TranslationX"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    void (^completion)(BOOL) = [self.completionBlocksByAnimation objectForKey:anim];
    [self.completionBlocksByAnimation removeObjectForKey:anim];
    if (completion)
    {
        completion(flag);
    }
}

- (void)removeAllAnimations
{
    for (UIView *view in self.viewsByName.allValues)
    {
        [view.layer removeAllAnimations];
    }
    [self.layer removeAnimationForKey:@"StackView"];
}


@end
