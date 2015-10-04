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

#import "DetailViewController.h"
#import "Client.h"

//private interface for DetailViewController for nonpublic elements
@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController
/********************************************************************************
 FUNCTION:		- (void)setDetailItem:(id)newDetailItem
 
 ARGUMENTS:		(id)newDetailItem, object the contains the book to be displayed
 
 RETURNS:		The function has no return value
 
 NOTES:			This function updates the detailItem to be the curretnly selected client if it is not already.
 ************************************************************************************/
- (void)setDetailItem:(id)newDetailItem
{
    //if detailItem is not equal to newDetailItem, update it
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}
/********************************************************************************
 FUNCTION:		- (void)configureView
 
 ARGUMENTS:		This function recieves no arguments
 
 RETURNS:		The function has no return value
 
 NOTES:			This function sets the text on the detailview to be the details for the selected client
 ************************************************************************************/
- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem)
    {
        self.navigationItem.title = self.detailItem.name;
        self.professionLabel.text= self.detailItem.profession;
        self.DOBLabel.text = self.detailItem.dateOfBirth;
        //if childern is nil set label to None
        if ([self.detailItem.childern isEqualToString:@""])
        {
            self.childernLabel.text = @"None";
        }
        //else set label to equal detailItem childern
        else
        {
            self.childernLabel.text = self.detailItem.childern;
        }
    }
    
}
/********************************************************************************
 FUNCTION:		- (void)viewDidLoad
 
 ARGUMENTS:		This function recieves no arguments
 
 RETURNS:		The function has no return value
 
 NOTES:			The function is called after the controller’s view is loaded into memory.
 ************************************************************************************/
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}
/********************************************************************************
 FUNCTION:		- (void)didReceiveMemoryWarning
 
 ARGUMENTS:		This function recieves no arguments
 
 RETURNS:		The function has no return value
 
 NOTES:			This function is called by the system when the app receives a memory warning.
 ************************************************************************************/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

