/****************************************************************
 FILE:      ViewController.h
 AUTHOR:    Robert Kahren II
 LOGON ID:  Z1691801
 DUE DATE:  February 13, 2015 at 11:59pm
 
 PURPOSE:   This file contains the properties and method declarations for
            ViewController class
 ****************************************************************/
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic)NSMutableArray* clientList;                    //list of clients

@property (weak, nonatomic) IBOutlet UITableView *tableView;        //UI table view to display client list
@end

