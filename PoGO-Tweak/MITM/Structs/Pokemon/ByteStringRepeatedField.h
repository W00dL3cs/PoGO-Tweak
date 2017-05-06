//
//  ByteStringRepeatedField.h
//  PoXemon
//
//  Created by Alexandro Luongo on 03/05/17.
//
//

#ifndef ByteStringRepeatedField_h
#define ByteStringRepeatedField_h

#include "Il2CppObject.h"
#include "ByteStringArray.h"

struct ByteStringRepeatedField : public Il2CppObject
{
    ByteStringArray* array;
    
    int count;
};


#endif /* ByteStringRepeatedField_h */
