//
//  MasterTableViewController.m
//  TaskTracking-C
//
//  Created by GengRui on 2016-12-08.
//  Copyright © 2016 GengRui. All rights reserved.
//

#import "MasterTableViewController.h"
#import "AddTaskViewController.h"
#import "Task+CoreDataProperties.h"
#import "DataManager.h"

@interface MasterTableViewController ()

@property NSMutableArray *toDoItems;

@end

@implementation MasterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    self.toDoItems = [[NSMutableArray alloc] init];
    [self loadInitialData];
}

- (void)loadInitialData{
    
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];

    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"taskName" ascending:YES];
    
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"Unresolved Fetch Error%@",error);
    }else{
        [self.toDoItems addObjectsFromArray:fetchedObjects];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.toDoItems count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"TaskCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    
    Task *task = self.toDoItems[indexPath.row];
    
    //ToDoItem *toDoItem = [self.toDoItems objectAtIndex:indexPath.row];
    
    cell.textLabel.text = task.taskName;
    
    cell.detailTextLabel.text = [NSDateFormatter localizedStringFromDate:task.dueDate
                                                               dateStyle:NSDateFormatterShortStyle
                                                               timeStyle:NSDateFormatterShortStyle];
    return cell;
}

//Delete Button
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"Delete";
}


//Delete One Row
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
        
        Task *task = self.toDoItems[indexPath.row];
        [self.toDoItems removeObject:task];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [managedObjectContext deleteObject:task];
        
        [[DataManager sharedManager] saveContext];
    }
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"selectSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    }
}



- (IBAction)unwindToMasterTableViewController:(UIStoryboardSegue *)segue
{
    if ([segue.identifier isEqualToString:@"cancel"]) {
        NSLog(@"Button is %@", segue.identifier);
    }
    else if([segue.identifier isEqualToString:@"save"]){
        
        AddTaskViewController *source = [segue sourceViewController];
        
        if(source.taskName != nil){
            
            NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
            
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:managedObjectContext];
            
            Task *task = [[Task alloc]initWithEntity: entityDescription insertIntoManagedObjectContext:managedObjectContext];
            
            task.taskName = source.taskName;
            task.dueDate = source.dateTime;
            task.progress = source.progress;
            task.taskDetail = source.taskDetail;
            
            [self.toDoItems insertObject:task atIndex:0];
            
            [[DataManager sharedManager] saveContext];
            
            [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
}

@end
