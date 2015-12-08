//
//  BuddyManager.m
//  myBuddy
//
//  Created by Venkata Maniteja on 2015-12-07.
//  Copyright © 2015 Venkata Maniteja. All rights reserved.
//

#import "BuddyManager.h"
#import <UIKit/UIKit.h>

@implementation BuddyManager

#pragma mark Singleton Methods

+ (id)sharedManager {
    static BuddyManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (id)init {
    if (self = [super init]) {
        
        [self generateTemporaryPassword];
    
    }
    return self;
}

-(void)generateTemporaryPassword{
    
    int number = arc4random_uniform(10000);
    
    _temporaryPassword=[NSString stringWithFormat:@"%d",number];
    
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}



-(id)getDatabase{
    
    return _database;
}

-(void)insertSampleData{
    
   
    
}


@end
