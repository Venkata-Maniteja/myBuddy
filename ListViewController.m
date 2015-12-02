//
//  ListViewController.m
//  myBuddy
//
//  Created by Dhrupa on 2015-12-02.
//  Copyright © 2015 Venkata Maniteja. All rights reserved.
//


#import "ListViewController.h"
#import <sqlite3.h>

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
  
      list = [[NSMutableArray alloc] init];
      NSString *docsDir;
      NSArray *dirPaths;
  
      // Get the documents directory
      dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
      docsDir = dirPaths[0];
  
      // Build the path to the database file
  
      databasePath = [[NSString alloc]
                      initWithString: [docsDir stringByAppendingPathComponent:
                                       @"Buddy.db"]];
  
      const char *dbpath = [databasePath UTF8String];
      sqlite3_stmt    *statement;
  
      if (sqlite3_open(dbpath, &myDatabase) == SQLITE_OK)
      {
  
          [list removeAllObjects];
  
          NSString *querySQL = @"SELECT IMAGE FROM Data ";
  
          const char *query_stmt = [querySQL UTF8String];
  
          if (sqlite3_prepare_v2(myDatabase, query_stmt, -1, &statement, NULL) == SQLITE_OK)
          {
  
              while (sqlite3_step(statement) == SQLITE_ROW)
              {
  
                  int  len = sqlite3_column_bytes(statement, 0);
                  NSData *imgData = [[NSData alloc] initWithBytes: sqlite3_column_blob(statement, 0) length: len];
  
                  if(imgData == nil){
                      NSLog(@"No image found.");
                  }
                  else{
                                         [list addObject:imgData];
                  }
  
  
              }
              sqlite3_finalize(statement);
  
          }
  
          NSLog(@"list count is %lu",(unsigned long)list.count);
                 sqlite3_close(myDatabase);
      }
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
