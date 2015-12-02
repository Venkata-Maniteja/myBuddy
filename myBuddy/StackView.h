//
//  StackView.h
//  myBuddy
//
//  Created by Venkata Maniteja on 2015-12-02.
//  Copyright © 2015 Venkata Maniteja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StackView : UIView

@property (strong, nonatomic) NSDictionary *viewsByName;


// StackView
- (void)addStackViewAnimation;
- (void)addStackViewAnimationWithCompletion:(void (^)(BOOL finished))completionBlock;
- (void)addStackViewAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion;
- (void)addStackViewAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock;
- (void)addStackViewAnimationWithBeginTime:(CFTimeInterval)beginTime andFillMode:(NSString *)fillMode andRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock;
- (void)removeStackViewAnimation;

- (void)removeAllAnimations;

@end
