/*
 * Copyright (c) 2020 Taner Sener
 *
 * This file is part of FlutterFFmpeg.
 *
 * FlutterFFmpeg is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * FlutterFFmpeg is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with FlutterFFmpeg.  If not, see <http://www.gnu.org/licenses/>.
 */

#import "FlutterExecuteDelegate.h"

static NSString *const EVENT_EXECUTE = @"FlutterFFmpegExecuteCallback";

/**
 * Execute delegate for async executions.
 */
@implementation FlutterExecuteDelegate {
    FlutterEventSink _eventSink;
}

- (instancetype)initWithEventSink:(FlutterEventSink)eventSink {
    self = [super init];
    if (self) {
        _eventSink = eventSink;
    }

    return self;
}

- (void)executeCallback:(long)executionId :(int)returnCode {
    NSMutableDictionary *executeDictionary = [[NSMutableDictionary alloc] init];
    executeDictionary[@"executionId"] = [NSNumber numberWithLong: executionId];
    executeDictionary[@"returnCode"] = [NSNumber numberWithInt: returnCode];

    NSMutableDictionary *eventDictionary = [[NSMutableDictionary alloc] init];
    eventDictionary[EVENT_EXECUTE] = executeDictionary;

    if(_eventSink){
        _eventSink(eventDictionary);
    }
}

@end
