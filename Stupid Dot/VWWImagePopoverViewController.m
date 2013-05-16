//
//  VWWImagePopoverViewController.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWImagePopoverViewController.h"

@interface VWWImagePopoverViewController ()
@property (nonatomic, strong) NSMutableArray *imageNames;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation VWWImagePopoverViewController
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contentSizeForViewInPopover = CGSizeMake(200, 400);
    _imageNames = [@[@"white.jpg", @"maze_01.jpg", @"maze_02.jpg", @"maze_03.jpg", @"maze_04.jpg"]mutableCopy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:18.0];
    cell.textLabel.text = self.imageNames[indexPath.row];
    return cell;
}
    
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.completion(self.imageNames[indexPath.row]);
}



////    [self.imageView setImage:[UIImage imageNamed:@"white.jpg"]];
//    [self.imageView setImage:[UIImage imageNamed:@"maze_01.jpg"]];
////    [self.imageView setImage:[UIImage imageNamed:@"maze_02.jpg"]];
////    [self.imageView setImage:[UIImage imageNamed:@"maze_03.jpg"]];
////    [self.imageView setImage:[UIImage imageNamed:@"maze_04.jpg"]];

@end
