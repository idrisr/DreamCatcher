//
//  ViewController.m
//  DreamCatcher
//
//  Created by id on 3/2/16.
//  Copyright © 2016 id. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void) viewDidLoad {
    [super viewDidLoad];
}

- (IBAction) onAddButtonPressed:(UIBarButtonItem *) sender {
}

- (IBAction) onEditButtonPressed:(UIBarButtonItem *) sender {
}

- (NSInteger)   tableView:(UITableView *) tableView
    numberOfRowsInSection:(NSInteger) section {
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *) tableView
          cellForRowAtIndexPath:(NSIndexPath *) indexPath {
    NSString *reuseIdentifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    return cell;
}

@end