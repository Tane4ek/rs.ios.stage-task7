//
//  AppDelegate.m
//  RSSchool_T7
//
//  Created by Татьяна Лузанова on 01.07.2021.
//

#import "AppDelegate.h"
#import "RSViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        RSViewController *rootVC = [[RSViewController alloc] initWithNibName:@"RSViewController" bundle:nil];
        window.rootViewController = rootVC;
        
        self.window = window;
        [self.window makeKeyAndVisible];
    
    return YES;
}

@end
