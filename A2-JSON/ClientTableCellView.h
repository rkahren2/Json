/****************************************************************
 FILE:      ClientTableCellView.h
 AUTHOR:    Robert Kahren II
 LOGON ID:  Z1691801
 DUE DATE:  February 13, 2015 at 11:59pm
 
 PURPOSE:   This file contains the properties and method declarations for
            ClientTableCellView class
 ****************************************************************/
#import <UIKit/UIKit.h>

@interface ClientTableCellView : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;        //label for client's name
@property (weak, nonatomic) IBOutlet UILabel *profession;       //label for client's profession

@end
