//
//  ViewController.m
//  DreamCatcher
//
//  Created by id on 3/2/16.
//  Copyright © 2016 id. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *dreamList;
@property NSMutableArray *descriptions;
@end

@implementation ViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.dreamList = [NSMutableArray new];
    self.descriptions = [NSMutableArray new];
}

- (IBAction) onAddButtonPressed:(UIBarButtonItem *) sender {
    [self presentDreamEntry];
}

- (IBAction) onEditButtonPressed:(UIBarButtonItem *) sender {
}

- (void) presentDreamEntry {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add new dream"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];

    [alertController addTextFieldWithConfigurationHandler: ^(UITextField *_Nonnull textField) {
        textField.placeholder = @"Dream Title";
    }];

    [alertController addTextFieldWithConfigurationHandler: ^(UITextField *_Nonnull textField) {
        textField.placeholder = @"Dream Description";
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];

    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save"
                                                         style:UIAlertActionStyleDefault
                                                       handler: ^(UIAlertAction *_Nonnull action) {
        [self.dreamList addObject:alertController.textFields.firstObject.text];
        [self.descriptions addObject:alertController.textFields.lastObject.text];
        [self.tableView reloadData];
    }];

    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];

    [self presentViewController:alertController animated:YES completion:nil];
}

- (NSInteger)   tableView:(UITableView *) tableView
    numberOfRowsInSection:(NSInteger) section {
    return [self.dreamList count];
}

- (UITableViewCell *) tableView:(UITableView *) tableView
          cellForRowAtIndexPath:(NSIndexPath *) indexPath {
    NSString *reuseIdentifier = @"cellID";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];

    cell.textLabel.text = self.dreamList[indexPath.row];
    cell.detailTextLabel.text = self.descriptions[indexPath.row];
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *) segue
                  sender:(id) sender {
    DetailViewController *detailViewController = (DetailViewController *)segue.destinationViewController;
    UITableViewCell *cell = (UITableViewCell *)sender;
    detailViewController.titleString = cell.textLabel.text;
    detailViewController.descriptionString = cell.detailTextLabel.text;
}

- (void)     tableView:(UITableView *) tableView
    commitEditingStyle:(UITableViewCellEditingStyle) editingStyle
     forRowAtIndexPath:(NSIndexPath *) indexPath {
    [self.dreamList removeObjectAtIndex:indexPath.row];
    [self.descriptions removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

@end