//
//  AppDelegate.m
//  IterateOSX
//
//  Created by James Wilson on 9/6/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate 
            
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)application:(NSApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity {
    [userActivity addUserInfoEntriesFromDictionary:@ {
        @"handoffVersion" : @"1.0"
    }];
}

- (BOOL)application:(NSApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType {
        NSLog(@"%s", __PRETTY_FUNCTION__);
    if ([userActivityType isEqualToString:@"com.noesisingenuity.emitter.Transfer"]) {
        //load view controller and return yes
    } else if ([userActivityType isEqualToString:@"com.noesisingenuity.emitter.liveEditing"]) {
        return YES;
    }
    
    return NO;
}

- (BOOL)application:(NSApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *))restorationHandler {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    //Reconstruct the user's activity
    NSString *activityType = userActivity.activityType;
    
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    NSViewController *viewController = [storyboard instantiateInitialController];
    
//    [userActivity becomeCurrent];
//    [userActivity invalidate];
    //Call the restorationHandler, passing it an array of documents or responders that present the user activity.  This will make the system call the restore methods in the respective class.  So if I pass an instance of ViewController.h then the restoreUserActivity method will be called and I can reconstruct what the user was doing on iOS or OS X.
    
    //Continution Streams
    
    if (userActivity.supportsContinuationStreams) {
        [userActivity getContinuationStreamsWithCompletionHandler:^(NSInputStream *inputStream, NSOutputStream *outputStream, NSError *error) {
            if (!error) {
//                NSOutputStream *output = [NSOutputStream alloc] init
            }
        }];
    }
    
    return NO;
}

- (void)application:(NSApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    //Can be NSUserCancelledError, can happen when the user tried to do something else while the system is still fetching the user activity
    
    
}

- (void)applicationDidBecomeActive:(NSNotification *)notification {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSWindow *window = [[NSApplication sharedApplication] mainWindow];
    NSViewController *controller = window.contentViewController;
    
    if ([controller isKindOfClass:[NSSplitViewController class] ]) {
        NSSplitViewController *splitView = (NSSplitViewController*)controller;
        NSViewController *controller = splitView.childViewControllers[1];
        [controller viewDidAppear];
    }
}

@end
