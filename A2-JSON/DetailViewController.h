/****************************************************************
 FILE:      DetailViewController.h
 AUTHOR:    Robert Kahren II
 LOGON ID:  Z1691801
 DUE DATE:  February 13, 2015 at 11:59pm
 
 PURPOSE:   This file contains the properties and method declarations for
            DetailViewController class
 ****************************************************************/

#import <UIKit/UIKit.h>
@class Client;

@interface DetailViewController : UIViewController

@property (strong, nonatomic)Client *detailItem;                    //item passed from ViewController
@property (weak, nonatomic) IBOutlet UILabel *professionLabel;      //label to display the client's profession
@property (weak, nonatomic) IBOutlet UILabel *DOBLabel;             //label to display the client's date of birth
@property (weak, nonatomic) IBOutlet UILabel *childernLabel;        //label to display the client's childern

@end