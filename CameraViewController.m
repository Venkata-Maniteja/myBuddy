//
//  CameraViewController.m
//  myBuddy
//
//  Created by Dhrupa on 2015-12-02.
//  Copyright © 2015 Venkata Maniteja. All rights reserved.
//



#import "CameraViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ListViewController.h"
#import <sqlite3.h>
#import "FMDatabase.h"



@interface CameraViewController ()
@property (assign) BOOL *makeCameraOff;
@property (nonatomic,strong) NSString *imageURL;
@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *myDatabase;
@property (strong, nonatomic) NSString *statusOfAddingToDB;
@property (nonatomic,strong) NSString *insertSQL;


@end

@implementation CameraViewController

@synthesize imagePicker,imageview;
@synthesize databasePath,myDatabase,statusOfAddingToDB,insertSQL,imageURL;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareDatabase];
    
    // Do any additional setup after loading the view.
    
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    //[super viewDidAppear:animated];
    
    
    
    if (_makeCameraOff==NO) {
        
        [self performSelector:@selector(takePic) withObject:nil afterDelay:0.3];
    }
    
    
}

-(void)takePic{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate =self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Image Picker Delegate Methods

//  Dismiss the image picker on selection and use the resulting image in our ImageView
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //[imagePicker dismissModalViewControllerAnimated:YES];
    // [imageview setImage:image];
    
    
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(chosenImage)  forKey:@"imagesave"];
    self.imageview.image = chosenImage;
    
    [self save_Image];
    
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:((UIImage *)[info objectForKey:UIImagePickerControllerEditedImage]).CGImage
                                 metadata:[info objectForKey:UIImagePickerControllerMediaMetadata]
                          completionBlock:^(NSURL *assetURL, NSError *error) {
                              NSLog(@"assetURL %@", assetURL);
                              imageURL=[assetURL absoluteString];
                              
                              [[NSUserDefaults standardUserDefaults] setObject:imageURL forKey:@"imageurl"];
                              
                          }];
    
    _makeCameraOff = YES;
    
    //[picker dismissViewControllerAnimated:YES completion:NULL];
    ListViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"List"];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self presentViewController:vc animated:YES completion:NULL];
    }];
    
    
    
    
    
}

//  On cancel, only dismiss the picker controller
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    
    ListViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"List"];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self presentViewController:vc animated:YES completion:NULL];
    }];
    
    //[imagePicker dismissModalViewControllerAnimated:YES];
}


-(void)prepareDatabase{
    
    // Used sqlite just to create DB and Table  FMDB not allow to create writable database file Remaining all used by FMDB
    
    
    // Get the documents directory
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = dirPaths[0];
    
    // Build the path to the database file
    
    
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"Buddy.db"]];
    
    
    NSLog(@"DB Path: %@", databasePath);
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &myDatabase) == SQLITE_OK) {
            char *errMsg;
            
            
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS Data ( IMAGE BLOB )";
            
            
            
            if (sqlite3_exec(myDatabase, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                statusOfAddingToDB = @"Failed to create table";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DB Status" message:statusOfAddingToDB delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            } else {
                
                statusOfAddingToDB = @"Success in creating table";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DB Status" message:statusOfAddingToDB delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            
            sqlite3_close(myDatabase);
        } else {
            statusOfAddingToDB = @"Failed to open/create database";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DB Status" message:statusOfAddingToDB delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
    
    
}

- (void)save_Image {
    
    
    
    // Used FMDB TO insert
    
    
    NSData* imageData_tempsave = [[NSUserDefaults standardUserDefaults] objectForKey:@"imagesave"];
    UIImage* chosenImage = [UIImage imageWithData:imageData_tempsave];
    NSData *imageData=UIImagePNGRepresentation(chosenImage);
    
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *dbPath = [docsPath stringByAppendingPathComponent:@"Buddy.db"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    NSString *insertQuery = [NSString stringWithFormat:@"INSERT INTO Data VALUES (?)",imageData];
    
    [database executeUpdate:insertQuery];
    [database close];
}



 #pragma mark - Navigation
 


@end
