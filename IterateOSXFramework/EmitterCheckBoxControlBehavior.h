//
//  EmitterCheckBoxControlBehavior.h
//  IterateOSX
//
//  Created by James Wilson on 9/29/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <IterateOSXFramework/IterateOSXFramework.h>

@interface EmitterCheckBoxControlBehavior : EmitterControlBehavior

@property (weak) IBOutlet NSButton *checkBox;

- (IBAction)checkBoxToggled:(NSButton *)sender;

@end
