//
//  DLGMem.h
//  memui
//
//  Created by Liu Junqi on 4/23/18.
//  Copyright © 2018 DeviLeo. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <mach-o/dyld.h>
#include <mach/mach.h>
#import <objc/runtime.h>
typedef struct{
    uint64_t address;
    size_t size;
    uint32_t value;
}MemoryRestore;
typedef struct{
    uint64_t offests;
    uint32_t bytes;
    MemoryRestore restore;
}Patch;

@interface DLGMem : NSObject

- (void)launchDLGMem;
- (void)DLG;
@end
