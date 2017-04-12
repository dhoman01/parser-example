#ifndef ACTIONS_HPP
#define ACTIONS_HPP 1

#include <iostream>
#include <memory>
#include <string>
#include <vector>

#include "Values.hpp"

namespace json
{

class Actions
{
public:
    Actions(){};
    virtual ~Actions() = default;

    std::shared_ptr<ObjectValue> CreateObjectValue(std::vector<Pair>);
    std::shared_ptr<ArrayValue> CreateArrayValue(std::vector<std::shared_ptr<Value>>);
    std::shared_ptr<StringValue> CreateStringValue(std::string);
    std::shared_ptr<NumberValue> CreateNumberValue(std::string);
    std::shared_ptr<BooleanValue> CreateBooleanValue(bool);
    std::shared_ptr<NullValue> CreateNullValue();
    Pair CreatePair(std::string, std::shared_ptr<Value>);
};

}

#endif