//
//  LSOptionsViewController.m
//  TileGame
//
//  Created by Artem Kravchenko on 4/21/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSOptionsViewController.h"

#import "NSMutableArray+Shuffle.h"

#import "LSLibraryViewController.h"
#import "LSButtonTableViewCell.h"
#import "LSGameViewController.h"
#import "LSDataProvider.h"
#import "FCFileManager.h"
#import "LSTile.h"
#import "LSGame.h"

@interface LSOptionsViewController () <LSButtonTableViewCellDelegate>

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) LSGame *currentGame;

@end

@implementation LSOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[@"Easy", @"Medium", @"Hard", @"Library"];
    NSLog(@"%@", [FCFileManager pathForDocumentsDirectory]);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.currentGame = nil;
    [[LSDataProvider sharedInstance] addUser:self.currentUser];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"button_cell";
    if (indexPath.row == self.dataSource.count-1) {
        identifier = @"library_cell";
    }
    LSButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.delegate = self;
    [cell.actionButton setTitle:self.dataSource[indexPath.row] forState:UIControlStateNormal];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (self.currentGame) {
        LSGameViewController *gameController = [segue destinationViewController];
        gameController.currentGame = self.currentGame;
        gameController.currentUser = self.currentUser;
    } else {
        LSLibraryViewController *libraryController = [segue destinationViewController];
        libraryController.currentUser = self.currentUser;
    }
}



#pragma mark - LSButtonTableViewCellDelegate

- (void)handleTap:(NSString *)title
{
    if ([title isEqualToString:self.dataSource[0]])
    {
        self.currentGame = [self gameForMode:LSGameModeEasy];
    }
    else if ([title isEqualToString:self.dataSource[1]])
    {
        self.currentGame = [self gameForMode:LSGameModeMedium];
    }
    else if ([title isEqualToString:self.dataSource[2]])
    {
        self.currentGame = [self gameForMode:LSGameModeHard];
    }
}

- (LSGame*)gameForMode:(LSGameMode)gameMode {
    LSGame *game = [self.currentUser gameForMode:gameMode];
    if (game == nil) {
        game = [LSGame new];
        game.gameID = [[NSProcessInfo processInfo] globallyUniqueString];
        game.gameMode = gameMode;
        [self.currentUser setGame:game forMode:gameMode];
        game.tilesSet = [self randomColorsForCount:game.itemsInLine * game.itemsInColumns];
    }
    return game;
}

- (NSArray*)randomColorsForCount:(NSInteger)count {
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0; i < count / 2; i++) {
        LSTile *tile = [LSTile new];
        tile.tileID = [[NSProcessInfo processInfo] globallyUniqueString];
        tile.imageName = [self.allImagesForUser[i] stringByReplacingOccurrencesOfString:[FCFileManager pathForLibraryDirectory] withString:@""];
        tile.color = self.randomColor;
        [result addObject:tile];
    }
    for (int i = (int)count/2, j = 0; i < count; i++, j++) {
        LSTile *tile = [LSTile new];
        LSTile *oldTile = result[j];
        tile.tileID = [[NSProcessInfo processInfo] globallyUniqueString];
        tile.color = oldTile.color;
        tile.imageName = oldTile.imageName;
        [result addObject:tile];
    }
    [result shuffle];
    [result enumerateObjectsUsingBlock:^(LSTile*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.order = idx;
    }];
    return result;
}


- (NSArray*)allImagesForUser {
    NSString *userPath = [NSString stringWithFormat:@"%@/%@", [FCFileManager pathForLibraryDirectory], self.currentUser.alias];
    NSArray *images = [FCFileManager listFilesInDirectoryAtPath:userPath];
    return images;
}

- (UIColor *)randomColor
{
    float red = arc4random() % 255 / 255.0;
    float green = arc4random() % 255 / 255.0;
    float blue = arc4random() % 255 / 255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    return color;
}

@end
