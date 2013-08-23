//
//  AppDelegate.h
//  CellDownload
//
//  Created by Zhang Yan on 12-9-17.
//  Copyright (c) 2012年 Zhang Yan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//@property (retain, nonatomic) UINavigationController *nav;
@property (retain, nonatomic) ViewController *viewController;

@end
