//
//  AppDelegate.m
//  myBuddy
//
//  Created by Venkata Maniteja on 2015-11-30.
//  Copyright © 2015 Venkata Maniteja. All rights reserved.
//

#import "AppDelegate.h"
#import "BuddyManager.h"
#import <FMDatabase.h>

@interface AppDelegate ()

@property (nonatomic,strong) BuddyManager *manager;
@property (nonatomic,strong) FMDatabase *database;
@property (nonatomic,strong) NSString *dataBasePath;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    application.statusBarHidden=YES;
    _manager=[BuddyManager sharedManager];
    
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"BaseCreated"]) {
        
        [self createDatabase];
        
    }
    
    
    return YES;
}

-(void)createDatabase{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    _dataBasePath = [docsPath stringByAppendingPathComponent:@"buddyDatabase.sqlite"];
    
    [[NSUserDefaults standardUserDefaults]setObject:_dataBasePath forKey:@"BasePath"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    _database = [FMDatabase databaseWithPath:_dataBasePath];
    
    [_manager setDataBaseCreated:YES];
    [_manager setDataBasePath:_dataBasePath];
    
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"BaseCreated"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [_database open];
    [_database executeUpdate:@"create table user(name text primary key, password text ,passCreated BOOLEAN,databasePath text)"];
    [_database executeUpdate:@"create table fileBase(fileName text primary key, filePassword text ,fileURL text, filePasswordHint text,fileImage BLOB,fileColor text,fileEnteredTime DATETIME)"];
    [_database close];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
