//
//  ListViewController.m
//  myBuddy
//
//  Created by Dhrupa on 2015-12-02.
//  Copyright © 2015 Venkata Maniteja. All rights reserved.
//


#import "ListViewController.h"
#import <sqlite3.h>
#import "FMDatabase.h"


@interface ListViewController ()

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *myDatabase;
@property (strong, nonatomic) NSMutableArray *list;

@end

@implementation ListViewController


@synthesize databasePath,myDatabase,list;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDatafromDatabase];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    



// Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    
        [super viewWillAppear:animated];
    
        //  [self getTextFomDB];
    
        // [self save_Image];
        [self getDatafromDatabase];
    
        [self.tableView reloadData];
    
    }


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
   
        return list.count;
}
  
  -(void)getDatafromDatabase{
  
      // Used Fmdb to get data
      
      list = [[NSMutableArray alloc] init];
      NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
      NSString *docsPath = [paths objectAtIndex:0];
      NSString *dbPath = [docsPath stringByAppendingPathComponent:@"Buddy.db"];
      
      FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
      [database open];
      NSString *sqlSelectQuery = @"SELECT IMAGE FROM Data ";
      
      // Query result
      FMResultSet *resultsWithNameLocation = [database executeQuery:sqlSelectQuery];
      while([resultsWithNameLocation next]) {
          
          NSData *imgData = [resultsWithNameLocation dataForColumn:@"IMAGE"];
          // UIImage *img = [UIImage imageWithData:imgData];
          
          [list addObject:imgData];;
      }
      [database close];
  }
  
  
  
  
  
  - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
      static NSString *CellIdentifier = @"Cell";
      UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
      if (cell == nil) {
          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
      }
  
  
   // Configure the cell...
      UIImage *img = [[UIImage alloc] initWithData:[list objectAtIndex:indexPath.row]];
  
      cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
      cell.imageView.image = img;
  
  
  return cell;
  }




 // Override to support conditional editing of the table view.



@end
