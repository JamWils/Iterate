//
//  EmitterTextFieldControlBehavior.h
//  IterateOSX
//
//  Created by James Wilson on 9/28/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import <IterateOSXFramework/IterateOSXFramework.h>

@interface EmitterTextFieldControlBehavior : EmitterControlBehavior
@property (weak) IBOutlet NSTextField *textField;
- (IBAction)textFieldEdited:(NSTextField *)sender;

@end
