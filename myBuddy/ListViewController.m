//
//  ListViewController.m
//  
//
//  Created by Venkata Maniteja on 2015-12-09.
//
//

#import "ListViewController.h"
#import "BuddyManager.h"
#import <FMDatabase.h>
#import "ListDetailViewController.h"
@interface ListViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    IBOutlet UITableView *listView;
    
}

@property (nonatomic,strong) BuddyManager *manager;
@property (nonatomic,strong) FMDatabase *database;
@property (nonatomic,strong) FMResultSet *results;

@property (nonatomic,strong) NSMutableArray *dataSet;


@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _manager=[BuddyManager sharedManager];
    
    _dataSet=[[NSMutableArray alloc]init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"buddyDatabase.sqlite"];
    _database = [FMDatabase databaseWithPath:path];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [_dataSet removeAllObjects];
    [self getData];
    
    [listView reloadData];
}


-(void)getData{
    
    //fileName, filePassword ,filePasswordHint ,fileEnteredTime
    
    
    [_database open];
    _results = [_database executeQuery:@"select * from fileBase"];
    while([_results next]) {
        
        BuddyManager *data=[BuddyManager new];
        data.filePassword=[_results stringForColumn:@"filePassword"];
        data.fileName=[_results stringForColumn:@"fileName"];
        data.hint=[_results stringForColumn:@"filePasswordHint"];
       
        [_dataSet addObject:data];
    }
    [_database close];

    
}

-(void)deleteData{
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma table delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    
    return _dataSet.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:  (NSIndexPath *)indexPath  {
    
    static NSString *CellIdentifer = @"listCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    
    // Using a cell identifier will allow your app to reuse cells as they come and go from the screen.
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
    }
    
    // Deciding which data to put into this particular cell.
    // If it the first row, the data input will be "Data1" from the array.
    
    BuddyManager *dataDisplay=[_dataSet objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text = dataDisplay.fileName;
    
    return cell;

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"sendData"]) {
        
        ListDetailViewController *vc=[segue destinationViewController];
        
        NSIndexPath *indexPAth=[listView indexPathForSelectedRow];
        
        vc.manager=[_dataSet objectAtIndex:indexPAth.row];
        
    }
}


@end
