//
//  PrefsController.h
//  FoolSaver
//
//  Created by Kevin Wojniak on 8/16/05.
//  Copyright 2005, 2014 Kevin Wojniak. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PrefsController : NSWindowController
{
	IBOutlet NSMatrix *osImage;
}

- (IBAction)save:(id)sender;

@end
