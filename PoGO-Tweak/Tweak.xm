//
//  File Name: Tweak.xm
//  Project Name: PoGO-Tweak
//
//  Created by Alexandro Luongo on 26/12/2016.
//  Updated by Alexandro Luongo on 06/05/2017.
//
//  Copyright © 2016-2017 Alexandro Luongo. All rights reserved.
//

#include <UIKit/UIKit.h>
#include <mach-o/dyld.h>

#import "substrate.h"
#import "MITM/Structs/Structs.h"
#import "PogoprotosNetworkingEnvelopes.pbobjc.h"
#import "PogoprotosNetworkingResponses.pbobjc.h"

NSMutableDictionary* lookup = [NSMutableDictionary dictionary];

#pragma mark - Original implementations

static void (*original_recv)(int pointer, Result result);
static int (*original_server)(int pointer, int timeoutMs, int retryDelayMs, int count, IntArray* methods, IntPtr bodies, IntArray* sizes, int* result);

#pragma mark - Server Send

static int hacked_server(int pointer, int timeoutMs, int retryDelayMs, int count, IntArray* methods, IntPtr bodies, IntArray* sizes, int* result)
{
    // You can do shady stuff here...
    // Wanna do perfect throws every time? Well, this is the place.
    // The job is up to you, tho ;)
    
    // Call the original method implementation
    int original = original_server(pointer, timeoutMs, retryDelayMs, count, methods, bodies, sizes, result);
    
    // Allocate a new array which will contain all the messages to be parsed
    NSMutableArray* protos = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        // Get the proto-id of the message at index 'i'
        int method = methods->GetAt(i);
        
        // Update the array
        [protos addObject:@(method)];
    }
    
    // Check if message has been sent, and we have a valid rpcId
    if (*result > 0 && protos)
    {
        // Update the final dictionary with the current request
        [lookup setObject:protos forKey:@(*result)];
    }
    
    return original;
}

#pragma mark - Recv

static void hacked_recv(int pointer, Result result)
{
    // Get the identifier of the current server response
    int rpcId = result.rpcId;
    
    // Lookup for the request having the same identifier
    NSMutableArray* protos = [lookup objectForKey:@(rpcId)];
    
    if (protos)
    {
        int actions = result.actionCount;
        
        // Game requests and server responses are supposed to have the same amount of messages
        if (protos.count == actions)
        {
            // Get a reference to the various bodies contained in this response
            ByteStringRepeatedField* repeatedField = result.rpcPayloads;
            
            for (int i = 0; i < repeatedField->count; i++)
            {
                // From C++ ByteString...
                ByteString* byteString = repeatedField->array->GetAt(i);
                
                int length = byteString->bytes->max_length;
                
                uint8_t* array = byteString->bytes->m_Items;
                
                // ... to Obj-C NSData!
                NSData* data = [NSData dataWithBytes:array length:length];
                
                if (data)
                {
                    // Get the proto-id of the message at index 'i'
                    int method = [protos[i] integerValue];
                    
                    // Handle message
                    switch (method)
                    {
                        // User-click on a gym
                        case RequestType_GetGymDetails:
                        {
                            GetGymDetailsResponse* gym = [GetGymDetailsResponse parseFromData:data error:nil];
                            
                            // Update the gym name
                            gym.name = @"HACKED";
                            
                            // Cycle through the gym members
                            for (int j = 0; j < gym.gymState.membershipsArray_Count; j++)
                            {
                                GymMembership* membership = gym.gymState.membershipsArray[j];
                                
                                if (membership.hasPokemonData)
                                {
                                    // Change pokemon
                                    membership.pokemonData.pokemonId = PokemonId_Mewtwo;
                                }
                                
                                if (membership.hasTrainerPublicProfile)
                                {
                                    // Change defender username
                                    membership.trainerPublicProfile.name = @"HACKED";
                                }
                                
                                // Update details
                                gym.gymState.membershipsArray[j] = membership;
                            }
                            
                            // Update details
                            data = [gym data];
                            
                            break;
                        }
                            
                        default:
                        {
                            // Request type has not been implemented: do something (log, throw error, ignore...).
                            
                            break;
                        }
                    }
                    
                    // Now just update data, and force the game use your informations rather than its own...
                    // Once again, this part of the job is up to you! ;)
                }
            }
        }
    }
    
    // Call the original method implementation
    original_recv(pointer, result);
}

%ctor
{
    // N2ServerSend$$Invoke
    unsigned long server_func = (_dyld_get_image_vmaddr_slide(0) + 0x1007C562C);
    MSHookFunction((void*)server_func, (void*)hacked_server, (void**)&original_server);
    
    // RPC$$Recv
    unsigned long recv_func = (_dyld_get_image_vmaddr_slide(0) + 0x1007C9914);
    MSHookFunction((void*)recv_func, (void*)hacked_recv, (void**)&original_recv);
}
