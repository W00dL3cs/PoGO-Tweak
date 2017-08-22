#line 1 "/Users/Alex/Desktop/Development/Tweaks/PoGO-Tweak/PoGO-Tweak/Tweak.xm"










#include <UIKit/UIKit.h>
#include <mach-o/dyld.h>

#import "substrate.h"
#import "MITM/Structs/Structs.h"
#import "PogoprotosNetworkingEnvelopes.pbobjc.h"
#import "PogoprotosNetworkingResponses.pbobjc.h"

NSMutableDictionary* lookup = [NSMutableDictionary dictionary];

#pragma mark - Original implementations

static void (*original_recv)(int pointer, Result* result);
static int (*original_server)(int pointer, int timeoutMs, int retryDelayMs, int count, IntArray* methods, IntPtr bodies, IntArray* sizes, int* result);

#pragma mark - Server Send

static int hacked_server(int pointer, int timeoutMs, int retryDelayMs, int count, IntArray* methods, IntPtr bodies, IntArray* sizes, int* result)
{
    
    
    
    
    
    int original = original_server(pointer, timeoutMs, retryDelayMs, count, methods, bodies, sizes, result);
    
    
    NSMutableArray* protos = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        
        int method = methods->GetAt(i);
        
        
        [protos addObject:@(method)];
    }
    
    
    if (*result > 0 && protos)
    {
        
        [lookup setObject:protos forKey:@(*result)];
    }
    
    return original;
}

#pragma mark - Recv

static void hacked_recv(int pointer, Result* result)
{
    
    int rpcId = result->rpcId;
    
    
    NSMutableArray* protos = [lookup objectForKey:@(rpcId)];
    
    if (protos)
    {
        int actions = result->actionCount;
        
        
        if (protos.count == actions)
        {
            
            ByteStringRepeatedField* repeatedField = result->rpcPayloads;
            
            for (int i = 0; i < repeatedField->count; i++)
            {
                
                ByteString* byteString = repeatedField->array->GetAt(i);
                
                int length = byteString->bytes->max_length;
                
                uint8_t* array = byteString->bytes->m_Items;
                
                
                NSData* data = [NSData dataWithBytes:array length:length];
                
                if (data)
                {
                    
                    int method = [protos[i] integerValue];
                    
                    
                    switch (method)
                    {
                        
                        case RequestType_GetGymDetails:
                        {
                            GetGymDetailsResponse* gym = [GetGymDetailsResponse parseFromData:data error:nil];
                            
                            
                            gym.name = @"HACKED";
                            
                            
                            for (int j = 0; j < gym.gymState.membershipsArray_Count; j++)
                            {
                                GymMembership* membership = gym.gymState.membershipsArray[j];
                                
                                if (membership.hasPokemonData)
                                {
                                    
                                    membership.pokemonData.pokemonId = PokemonId_Mewtwo;
                                }
                                
                                if (membership.hasTrainerPublicProfile)
                                {
                                    
                                    membership.trainerPublicProfile.name = @"HACKED";
                                }
                                
                                
                                gym.gymState.membershipsArray[j] = membership;
                            }
                            
                            
                            data = [gym data];
                            
                            break;
                        }
                            
                        default:
                        {
                            
                            
                            break;
                        }
                    }
                    
                    
                    
                }
            }
        }
    }
    
    
    original_recv(pointer, result);
}

static __attribute__((constructor)) void _logosLocalCtor_37a749d8(int __unused argc, char __unused **argv, char __unused **envp)
{
    
    intptr_t slide = _dyld_get_image_vmaddr_slide(0);
    
    
    unsigned long server_func = (slide + 0x1009012e8);
    MSHookFunction((void*)server_func, (void*)hacked_server, (void**)&original_server);
    
    
    unsigned long recv_func = (slide + 0x100910e50);
    MSHookFunction((void*)recv_func, (void*)hacked_recv, (void**)&original_recv);
}
