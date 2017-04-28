//
//  LSLoginViewController.m
//  TileGame
//
//  Created by Artem Kravchenko on 4/21/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSLoginViewController.h"

#import "LSOptionsViewController.h"
#import "LSDataProvider.h"
#import "LSUser.h"

@interface LSLoginViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *aliasTextField;
@property (weak, nonatomic) IBOutlet UIButton *enterButton;
@property (weak, nonatomic) IBOutlet UITableView *usersTableView;

@property (nonatomic, strong) LSUser *currentUser;

@end

@implementation LSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.usersTableView.dataSource = self;
    self.usersTableView.delegate = self;
    self.aliasTextField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.aliasTextField.text = @"";
    self.enterButton.enabled = NO;
    [self refreshUsers];
}

- (IBAction)enterDidTap:(id)sender {
    if (self.aliasTextField.text.length > 0) {
        self.currentUser = [LSUser new];
        self.currentUser.alias = self.aliasTextField.text;
    }
    if (self.currentUser != nil) {
        [[LSDataProvider sharedInstance] addUser:self.currentUser];
        [self refreshUsers];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *result = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.enterButton.enabled = result.length != 0;
    if (result != 0) {
        self.currentUser = nil;
        [self.usersTableView reloadData];
    }
    return YES;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.usersList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.usersTableView dequeueReusableCellWithIdentifier:@"user_cell"];
    LSUser *user = self.usersList[indexPath.row];
    cell.textLabel.text = user.alias;
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentUser = self.usersList[indexPath.row];
    self.aliasTextField.text = @"";
    self.enterButton.enabled = YES;
}



#pragma mark - Utils

- (void)refreshUsers {
    self.usersList = [[LSDataProvider sharedInstance] allUsers];
    [self.usersTableView reloadData];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    LSOptionsViewController *options = [segue destinationViewController];
    options.currentUser = self.currentUser;
}


@end
