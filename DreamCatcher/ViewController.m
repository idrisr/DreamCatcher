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


#pragma mark - view life cycle
- (void) viewDidLoad {
    [super viewDidLoad];
    self.dreamList = [NSMutableArray new];
    self.descriptions = [NSMutableArray new];
}

#pragma mark IBActions
- (IBAction) onAddButtonPressed:(UIBarButtonItem *) sender {
    [self presentDreamEntry];
}

- (IBAction) onEditButtonPressed:(UIBarButtonItem *) sender {
    if (self.editing) {
        self.editing = false;
        [self.tableView setEditing:false animated:true];
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Edit";
    } else {
        self.editing = true;
        [self.tableView setEditing:true animated:true];
        sender.style = UIBarButtonItemStyleDone;
        sender.title = @"Done";
    }
    [self.tableView reloadData];
}

#pragma mark - private methods
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

#pragma mark - table view datasource
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

- (void)     tableView:(UITableView *) tableView
    moveRowAtIndexPath:(NSIndexPath *) sourceIndexPath
           toIndexPath:(NSIndexPath *) destinationIndexPath {
    NSString *dream = [self.dreamList objectAtIndex:sourceIndexPath.row];
    NSString *description = [self.dreamList objectAtIndex:sourceIndexPath.row];

    [self.dreamList removeObjectAtIndex:sourceIndexPath.row];
    [self.descriptions removeObjectAtIndex:sourceIndexPath.row];

    [self.dreamList insertObject:dream atIndex:destinationIndexPath.row];
    [self.descriptions insertObject:description atIndex:destinationIndexPath.row];
}

#pragma mark - segue
- (void) prepareForSegue:(UIStoryboardSegue *) segue
                  sender:(id) sender {
    DetailViewController *detailViewController = (DetailViewController *)segue.destinationViewController;
    UITableViewCell *cell = (UITableViewCell *)sender;
    detailViewController.titleString = cell.textLabel.text;
    detailViewController.descriptionString = cell.detailTextLabel.text;
}

#pragma mark - table view delegate
- (void)     tableView:(UITableView *) tableView
    commitEditingStyle:(UITableViewCellEditingStyle) editingStyle
     forRowAtIndexPath:(NSIndexPath *) indexPath {
    [self.dreamList removeObjectAtIndex:indexPath.row];
    [self.descriptions removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

- (BOOL)        tableView:(UITableView *) tableView
    canMoveRowAtIndexPath:(NSIndexPath *) indexPath {
    return true;
}

@end