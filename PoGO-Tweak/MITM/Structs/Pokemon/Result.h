//
//  Result.h
//  PoXemon
//
//  Created by Alexandro Luongo on 03/05/17.
//
//

#ifndef Result_h
#define Result_h

#include "ByteStringRepeatedField.h"

// Result
struct  Result
{
public:
    // System.Int32 Result::rpcId
    int rpcId;
    
    // RpcStatus Result::rpcStatus
    int rpcStatus;
    
    // Google.Protobuf.Collections.RepeatedField`1<Google.Protobuf.ByteString> Result::rpcPayloads
    ByteStringRepeatedField* rpcPayloads;
    
    // System.Int32 Result::actionCount
    int actionCount;
};

#endif /* Result_h */
