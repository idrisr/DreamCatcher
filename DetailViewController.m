//
//  DetailViewController.m
//  DreamCatcher
//
//  Created by id on 3/3/16.
//  Copyright © 2016 id. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation DetailViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.textView.text = self.descriptionString;
    self.title = self.titleString;
}

@end
