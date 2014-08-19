//
//  FoolSaverView.h
//  FoolSaver
//
//  Created by Kevin Wojniak on 8/16/05.
//  Copyright 2005, 2014 Kevin Wojniak. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>

@class PrefsController;

@interface FoolSaverView : ScreenSaverView 
{
	NSImage *winXPPro;
	NSPoint drawPoint;
	
	PrefsController *prefs;
}

- (void)updateImage:(NSNotification *)notification;

@end
