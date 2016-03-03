//
//  ViewController.m
//  DreamCatcher
//
//  Created by id on 3/2/16.
//  Copyright © 2016 id. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *dreamList;
@end

@implementation ViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.dreamList = [NSMutableArray new];
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

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];

    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save"
                                                         style:UIAlertActionStyleDefault
                                                       handler: ^(UIAlertAction *_Nonnull action) {
                                                           UITextField *textField = alertController.textFields.firstObject;
                                                           [self.dreamList addObject:textField.text];
                                                           [self.tableView reloadData];
                                                       }];

    [alertController addAction: cancelAction];
    [alertController addAction: saveAction];

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
    return cell;
}

@end