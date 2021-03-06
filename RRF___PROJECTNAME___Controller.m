////////////////////////////////////////////////////////////////////////////////
//  RRF___PROJECTNAME___Controller.m
//  RRF___PROJECTNAME___
//  ----------------------------------------------------------------------------
//  Author: ___FULLUSERNAME___
//  Created: ___DATE___
//  Copyright ___YEAR___, Residential Research Facility,
//  University of Kentucky. All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
#import "RRF___PROJECTNAME___Controller.h"

#define RRFLogToTemp(fmt, ...) [delegate logStringToDefaultTempFile:[NSString stringWithFormat:fmt,##__VA_ARGS__]]
#define RRFLogToFile(filename,fmt, ...) [delegate logString:[NSString stringWithFormat:fmt,##__VA_ARGS__] toDirectory:[delegate tempDirectory] toFile:filename]
#define RRFPathToTempFile(filename) [[delegate tempDirectory] stringByAppendingPathComponent:filename]

@implementation RRF___PROJECTNAME___Controller

@synthesize delegate,definition,errorLog,view;  // add any member that has a 
                                                //property

#pragma mark HOUSEKEEPING METHODS
/**
 Give back any memory that may have been allocated by this bundle
 */
- (void)dealloc {
  [errorLog release];
  // any additional release calls go here
  // ...
  [super dealloc];
}

#pragma mark REQUIRED PROTOCOL METHODS
/**
 Start the component - will receive this message from the component controller
 */
- (void)begin {
    
}
/**
 Return a string representation of the data directory
 */
- (NSString *)dataDirectory {
  NSString *temp = nil;
  if(temp = [definition valueForKey:RRF___PROJECTNAME___DataDirectoryKey]) {
    return [temp stringByStandardizingPath];    // return standardized path if
                                                // we have one
  } else {
    return nil;                                 // otherwise, return nil
  }
}
/**
 Return a string object representing all current errors in log form
 */
- (NSString *)errorLog {
  return errorLog;
}
/**
 Perform any and all error checking required by the component - return YES if 
 passed
 */
- (BOOL)isClearedToBegin {
  return YES; // this is the default; change as needed
}
/**
 Returns the file name containing the raw data that will be appended to the data
 file
 */
- (NSString *)rawDataFile {
  return [delegate defaultTempFile]; // this is the default implementation
}
/**
 Perform actions required to recover from crash using the given raw data passed
 as string
 */
- (void)recover {
  // if no recovery is needed, nothing need be done here
  // but you may want to consider removing the old data file
  // [[NSFileManager defaultManager] removeItemAtPath:RRFPathToTempFile([delegate defaultTempFile]) error:nil];
  // -- 
}
/**
 Accept assignment for the component definition
 */
- (void)setDefinition: (NSDictionary *)aDictionary {
  definition = aDictionary;
}
/**
 Accept assignment for the component delegate - The component controller will 
 assign itself as the delegate
 Note: The new delegate must adopt the TKComponentBundleDelegate protocol
 */
- (void)setDelegate: (id <TKComponentBundleDelegate> )aDelegate {
  delegate = aDelegate;
}
/**
 Perform any and all initialization required by component - load any nib files 
 and perform all required initialization
 */
- (void)setup {
  [self setErrorLog:@""]; // clear the error log
  // WHAT NEEDS TO BE INITIALIZED BEFORE THIS COMPONENT CAN OPERATE?
  // ...
  // LOAD NIB
  // ...
  if([NSBundle loadNibNamed:RRF___PROJECTNAME___MainNibNameKey owner:self]) {
    // SETUP THE INTERFACE VALUES
    // ...
  } else {
    // nib did not load, so throw error
    [self registerError:@"Could not load Nib file"];
  }
}
/**
 Return YES if component should perform recovery actions
 */
- (BOOL)shouldRecover {
  return NO;  // this is the default; change if needed
  /* Might consider to recover if a temporary data file exists
     (un-comment to use)
  return [[NSFileManager defaultManager] fileExistsAtPath:RRFPathToTempFile([delegate defaultTempFile]);
   */
}
/**
 Perform any and all finalization required by component
 */
- (void)tearDown {
  // any finalization should be done here:
  // ...
  // remove any temporary data files (uncomment below to use default)
  /*
  NSError *tFileMoveError = nil;
  [[NSFileManager defaultManager] removeItemAtPath:RRFPathToTempFile([delegate defaultTempFile]) error:&tFileMoveError];
  if(tFileMoveError) {
    ELog(@"%@",[tFileMoveError localizedDescription]);
    [tFileMoveError release]; tFileMoveError=nil;
  }
   */
  // de-register any possible notifications
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/**
 Return the name of the current task
 */
- (NSString *)taskName {
  return [definition valueForKey:RRF___PROJECTNAME___TaskNameKey];
}
/**
 Return the main view that should be presented to the subject
 */
- (NSView *)mainView {
  return view;
}

#pragma mark OPTIONAL PROTOCOL METHODS
/** Uncomment and implement the following methods if desired */
/**
 Run header if something other than default is required
 */
//- (NSString *)runHeader {
//
//}
/**
 Session header if something other than default is required
 */
//- (NSString *)sessionHeader {
//
//}
/**
 Summary data if desired
 */
//- (NSString *)summary {
//
//}
/**
 Summary offset must be provided if a custom summary will be used.
 See comments below for use.
 */
//- (NSUInteger)summaryOffset {
  // for an overwritting summary, un-comment the following line
  // return [[[delegate registryForTaskWithOffset:0] valueForKey:TKComponentSummaryStartKey] unsignedIntegerValue];
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // for an appending summary, un-comment the following line
  // return [[[delegate registryForTaskWithOffset:0] valueForKey:TKComponentSummaryEndKey] unsignedIntegerValue];
// }

#pragma mark ADDITIONAL METHODS
// PLACE ANY NON-PROTOCOL METHODS HERE
//////////////////////////////////////
- (void)registerError: (NSString *)theError {
  // append the new error to the error log
  [self setErrorLog:[[errorLog stringByAppendingString:theError] 
                     stringByAppendingString:@"\n"]];
}

#pragma mark Preference Keys
// HERE YOU DEFINE KEY REFERENCES FOR ANY PREFERENCE VALUES
// ex: NSString * const RRF___PROJECTNAME___NameOfPreferenceKey = @"RRF___PROJECTNAME___NameOfPreference"
NSString * const RRF___PROJECTNAME___TaskNameKey = @"RRF___PROJECTNAME___TaskName";
NSString * const RRF___PROJECTNAME___DataDirectoryKey = @"RRF___PROJECTNAME___DataDirectory";

#pragma mark Internal Strings
// HERE YOU DEFINE KEYS FOR CONSTANT STRINGS //
///////////////////////////////////////////////
NSString * const RRF___PROJECTNAME___MainNibNameKey = @"RRF___PROJECTNAME___MainNib";
        
@end
