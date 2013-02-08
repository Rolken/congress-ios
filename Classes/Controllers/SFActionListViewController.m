//
//  SFActionListViewController.m
//  Congress
//
//  Created by Daniel Cloud on 1/31/13.
//  Copyright (c) 2013 Sunlight Foundation. All rights reserved.
//

#import "SFActionListViewController.h"
#import "SFBillAction.h"
#import "SFVoteDetailViewController.h"
#import "SFVote.h"

@interface SFActionListViewController ()

@end

@implementation SFActionListViewController

- (id)init
{
    self = [super init];
    if (self) {
        [self _initialize];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tableView.delegate = self;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!_sections) {
        return 0;
    }
    return [_sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_sections) {
        return [_dataArray count];
    }
    return [[_sections objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    SFBillAction *object = (SFBillAction *)[[self.sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = object.text;
    NSDateFormatter *dateFormatter = [NSDateFormatter mediumDateShortTimeFormatter];
    cell.detailTextLabel.text = [dateFormatter stringFromDate:object.actedAt];

    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SFBillAction *selection = [[self.sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSString *actionType = selection.type;
    if ([actionType isEqualToString:@"vote"]) {
        SFVoteDetailViewController *detailViewController = [[SFVoteDetailViewController alloc] initWithNibName:nil bundle:nil];
        detailViewController.vote = [SFVote objectWithExternalRepresentation:[selection externalRepresentation]];
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}

#pragma mark - Accessor methods

-(void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self sortDataIntoSections];
    [self.tableView reloadData];
}


#pragma mark - Private

-(void)_initialize
{
    _sectionTitles = @[];
    _sections = @[];
    self.tableView.delegate = self;
}

-(void)sortDataIntoSections
{
    _sections = @[_dataArray];
}

@end
