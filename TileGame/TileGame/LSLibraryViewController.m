//
//  LSLibraryViewController.m
//  TileGame
//
//  Created by Artem Kravchenko on 5/5/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

//test com
#import "LSLibraryViewController.h"

#import "LSImageTableViewCell.h"
#import "JVTImageFilePicker.h"
#import "FCFileManager.h"
#import "LSGame.h"

@interface LSLibraryViewController () <FilesPickerDelegate>

@property (nonatomic, strong) JVTImageFilePicker *filePicker;

@end

@implementation LSLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allImagesForUser.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"image_cell" forIndexPath:indexPath];
    
    NSString *fullName = self.allImagesForUser[indexPath.row];
//    NSString *userPath = [NSString stringWithFormat:@"%@/%@", [FCFileManager pathForLibraryDirectory], self.currentUser.alias];
//    cell.textLabel.text = [fullName stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@/", userPath] withString:@""];
    
    cell.iconImageView.image = [UIImage imageWithContentsOfFile:fullName];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addDidTap:(id)sender {
    self.filePicker = [[JVTImageFilePicker alloc] init];
    self.filePicker.delegate = self;
    [self.filePicker presentFilesPickerOnController:self];
}


#pragma mark - FilesPickerDelegate

- (void)didPickFile:(NSData *)file fileName: (NSString *) fileName {
    NSLog(@"Did pick file");
}

- (void)didPickImage:(UIImage *)image withImageName:(NSString *) imageName {
    NSString *userPath = [NSString stringWithFormat:@"%@/%@", [FCFileManager pathForLibraryDirectory], self.currentUser.alias];
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@", userPath, [NSString stringWithFormat:@"%@_%@", kBaseImageNage, @(self.allImagesForUser.count + 1)]];
    [FCFileManager writeFileAtPath:imagePath content:image];
    [self.tableView reloadData];
}


#pragma mark - Utils

- (NSArray*)allImagesForUser {
    NSString *userPath = [NSString stringWithFormat:@"%@/%@", [FCFileManager pathForLibraryDirectory], self.currentUser.alias];
    NSArray *images = [FCFileManager listFilesInDirectoryAtPath:userPath];
    return images;
}


@end
