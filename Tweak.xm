//
//  File Name: Tweak.xm
//  Project Name: PoGO-Tweak
//
//  Created by Alexandro Luongo on 26/12/2016.
//  Copyright © 2016 Alexandro Luongo. All rights reserved.
//

#import "PogoprotosNetworkingEnvelopes.pbobjc.h"
#import "PogoprotosNetworkingResponses.pbobjc.h"

#ifdef THEOS
%hook __NSCFURLSession
#endif

NSMutableDictionary* lookup = [NSMutableDictionary dictionary];

- (id)dataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler
{
    NSString* host = [request URL].host;
    
    // Validate request
    if ([host containsString:@"pgorelease.nianticlabs.com"])
    {
        // Parse the request data
        RequestEnvelope* req = [RequestEnvelope parseFromData:request.HTTPBody error:nil];
        
        // Add the request to the lookup dictionary
        [lookup setObject:req forKey:[@(req.requestId) stringValue]];
        
        // Craft an hacked handler
        void (^hacked)(NSData *data, NSURLResponse *response, NSError *error) = ^void(NSData *data, NSURLResponse *response, NSError *error)
        {
            // Parse the response data
            ResponseEnvelope* resp = [ResponseEnvelope parseFromData:data error:&error];
            
            // Lookup for the respective request
            RequestEnvelope* req = [lookup objectForKey:[@(resp.requestId) stringValue]];
            
            // Loop through the requests
            for (int i = 0; i < req.requestsArray_Count; i++)
            {
                // Pointer to the request
                Request* message = req.requestsArray[i];
                
                // Pointer to the respective response
                NSData* testing = resp.returnsArray[i];
                
                // Handle message
                switch (message.requestType)
                {
                    // User-click on a gym
                    case RequestType_GetGymDetails:
                    {
                        GetGymDetailsResponse* gym = [GetGymDetailsResponse parseFromData:testing error:&error];
                        
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
                        testing = [gym data];
                        
                        break;
                    }
                    
                    default:
                    {
                        dispatch_async(dispatch_get_main_queue(),
                                       ^{
                                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"NOT IMPLEMENTED:" message:[@(message.requestType) stringValue] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                                           //[alert show];
                                           [alert release];
                                       });
                        
                        break;
                    }
                }
                
                // Update details
                resp.returnsArray[i] = testing;
            }
            
            data = [resp data];
            
            // Invoke the original handler
            completionHandler(data, response, error);
        };
        
        // Call the hacked handler
        return %orig(request, hacked);
    }
    
    return %orig(request, completionHandler);
}

#ifdef THEOS
%end
#endif
