//
//  BuddyManager.h
//  myBuddy
//
//  Created by Venkata Maniteja on 2015-12-07.
//  Copyright © 2015 Venkata Maniteja. All rights reserved.

//choose color on data entry view ocntroller to represent the data
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>

@interface BuddyManager : NSObject

@property (nonatomic,assign) BOOL passwordSaved;
@property (nonatomic,assign) BOOL passwordRegistered;
@property (nonatomic,assign) BOOL fingerPrintUsed;
@property (nonatomic,assign) BOOL timeOut;
@property (nonatomic,assign) BOOL loggedIn;
@property (nonatomic,assign) BOOL loggedOut;
@property (nonatomic,assign) BOOL dataBaseCreated;

@property (nonatomic,weak) NSString *password;
@property (nonatomic,weak) NSString *temporaryPassword;
@property (nonatomic,weak) NSString *dataBasePath;

@property (nonatomic,strong) FMDatabase *database;


+ (id)sharedManager;
+ (void)logOut;
- (void)createDatabase;
+ (void)deleteDatabase;
+ (void)archiveDatabase;
- (id)getDatabase;

#pragma objects for lest view

@property (nonatomic,strong) NSString *fileName;
@property (nonatomic,strong) NSString *filePassword;
@property (nonatomic,strong) NSString *hint;
@property (nonatomic,strong) NSString *colorName;










@end
