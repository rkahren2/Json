/***********************************************************************
 PROGRAM: 		A2-JSON
 AUTHOR: 		Robert Kahren II
 LOGON ID		Z1691801
 DUE DATE:		February 13, 2015 at 11:59pm
 
 FUNCTION:		This program Runs on iphone and downloads a clients list in the form of JSON data,
 parses the data and displays it on the deceive's touch screen in a master-detail view.
 
 INPUT: 		The program revieces input from the user via the deceive's touch screen and downloads it's
 json data from http://www.seasite.niu.edu/cs680Android/JSON/Client_list_json.txt
 
 OUTPUT: 		The program displys information to the user via the deceive's touch screen
 **************************************************************************/

#import "ViewController.h"
#import "Client.h"
#import "ClientTableCellView.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

/********************************************************************************
 FUNCTION:		- (void)viewDidLoad
 
 ARGUMENTS:		This function recieves no arguments
 
 RETURNS:		The function has no return value
 
 NOTES:			the function is called after the controller’s view is loaded into memory. It poplates the UI elements of the view
 ************************************************************************************/
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clientList = [[NSMutableArray alloc]init];
    //create NSURL to retrive JSON data from
    NSURL *jsonURL = [NSURL URLWithString:@"http://www.seasite.niu.edu/cs680Android/JSON/Client_list_json.txt"];
    //create background queue and dispatch the background thread to get and parse the JSON data
    dispatch_queue_t backgroundQue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(backgroundQue, ^{
        NSData* data = [NSData dataWithContentsOfURL:jsonURL];
        [self parsData:data];
    });
}
/********************************************************************************
 FUNCTION:		- (void)didReceiveMemoryWarning
 
 ARGUMENTS:		This function recieves no arguments
 
 RETURNS:		The function has no return value
 
 NOTES:			This function is called by the system when the app receives a memory warning.
 ************************************************************************************/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/********************************************************************************
 FUNCTION:		- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
 
 ARGUMENTS:		(UITableView *)tableView, a table view requesting this information.
 
 RETURNS:		The function returns a NSInteger reperseting the number of sections in the table
 
 NOTES:			This function returns the number of sections in the table, in this case 1
 ************************************************************************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
/********************************************************************************
 FUNCTION:		- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 
 ARGUMENTS:		(UITableView *)tableView, The table view requesting this information, (NSInteger)section, index number identifying a section in tableView.
 
 RETURNS:		The function returns a NSInteger repersenting the number of rows in the section
 
 NOTES:			This function gets the number of clients in the clientList and returns it as the number of rows for the tableview
 ************************************************************************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.clientList count]; // get the number of rows // from the controller
}
/********************************************************************************
 FUNCTION:		- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 
 ARGUMENTS:		(UITableView *)tableView, the tableview requesting the cell, (NSIndexPath *)indexPath, index path locating a row in tableView
 
 
 RETURNS:		The function returns an UITableViewCell that the tableview can use for the specified row
 
 NOTES:			This function gets a cell and sets it up for use in the tableview
 ************************************************************************************/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClientTableCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"ClientCell" forIndexPath:indexPath];
    Client *client = [self.clientList objectAtIndex:indexPath.row];
    cell.nameLabel.text=client.name;
    cell.profession.text=client.profession;
    return cell;
}
/********************************************************************************
 FUNCTION:		- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath: (NSIndexPath *)indexPath
 
 ARGUMENTS:		(UITableView *)tableView, the tableview requesting this information,  (NSIndexPath *)indexPath, index path locating a row in tableView.
 
 RETURNS:		The function returns a bool indicationg if the row in the index path is editable
 
 NOTES:			This function returns a bool telling if the row indicated by the indexpath in the tableview is editable.
 ************************************************************************************/
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath: (NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}
/********************************************************************************
 FUNCTION:		-(void)parsData:(NSData *)jsonData
 
 ARGUMENTS:		(NSData *)jsonData, JSON data to be parases
 
 RETURNS:		The function has no return value
 
 NOTES:			This function parses the JSON data recieved and stores it as clients in the clientlist.
                it then calls the UI thread and reloads the table view.
 ************************************************************************************/
-(void)parsData:(NSData *)jsonData
{
    NSError* error;         //create NSError to catch error is parsing fails
    //parse data into a NSDictionary using NSJSONSerialization
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    //if not json data display error
    if (!json)
    {
        NSLog(@"Error parsing JSON: %@", error);
    }
    //otherwise store data  as clients in clientList
    else
    {
        //extract array of clients from dicionary
        NSArray *clients = json[@"clients"];
        //create a client fro each client in the array
        for (NSDictionary *theClient in clients)
        {
            NSMutableString *childern = [[NSMutableString alloc]init];
            Client *newClient = [[Client alloc]init];
            newClient.name = theClient[@"name"];
            newClient.profession = theClient[@"profession"];
            newClient.dateOfBirth = theClient[@"dob"];
            //extract array of childern from theClient
            NSArray *children = theClient[@"children"];
            //for each child in array add it to the new client's childern
            for (NSString *child in children)
            {
               
                if (![childern isEqualToString:@""])
                {
                    [childern appendString:@", "];
                }
                [childern appendString:child];
            }
            newClient.childern = childern;
            //add client to clientList
            [self.clientList addObject:newClient];
            
        }
    }
    //call UI thread and update the tableView
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
/********************************************************************************
 FUNCTION:		- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 
 ARGUMENTS:		(UIStoryboardSegue *)segue, the segue containing information about the view controllers involved in the segue,
 sender:(id)sender, the object that initiated the segue.
 
 RETURNS:		The function has no return value
 
 NOTES:			This function notifies the view controller that a segue is about to be performed and can be used to pass relevant data to the new view controller.
 ************************************************************************************/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //if the segue is equal to ShowAttractionDetails, retrive the selected attraction and pass it to the DetailViewController.
    if ([[segue identifier] isEqualToString:@"viewClient"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Client *segueClient = [self.clientList objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:segueClient];
    }
}


@end
