//
//  PrefsController.m
//  FoolSaver
//
//  Created by Kevin Wojniak on 8/16/05.
//  Copyright 2005, 2014 Kevin Wojniak. All rights reserved.
//

#import "PrefsController.h"

#define PREFS_PATH [@"~/Library/Preferences/com.kainjow.FoolSaver.plist" stringByExpandingTildeInPath]

@implementation PrefsController

- (id)init
{
	if (self = [super initWithWindowNibName:@"Prefs" owner:self])
	{
	}
	
	return self;
}

- (void)awakeFromNib
{
	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:PREFS_PATH];
	if (dict)
	{
		NSNumber *xpHome = [dict objectForKey:@"WindowsImage"];
		
		int i;
		for (i=0; i<[osImage numberOfRows]; i++)
			[[osImage cellAtRow:i column:0] setState:NO];
		
		if (xpHome)
		{
			[[osImage cellWithTag:[xpHome intValue]] setState:YES];
		}
		else
		{
			[[osImage cellAtRow:0 column:0] setState:YES];
		}
	}
}

- (IBAction)save:(id)sender
{
	NSNumber *obj = [NSNumber numberWithInt:[[osImage selectedCell] tag]];
	NSDictionary *dict = [NSDictionary dictionaryWithObject:obj forKey:@"WindowsImage"];
	[dict writeToFile:PREFS_PATH atomically:YES];

	[[NSNotificationCenter defaultCenter] postNotificationName:@"FoolPrefsClose" object:obj];
	
	[NSApp endSheet:[self window]];
	[self close];
}

@end
