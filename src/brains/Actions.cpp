#include "Actions.hpp"

std::shared_ptr<json::ObjectValue> json::Actions::CreateObjectValue(std::vector<json::Pair> members)
{
    return std::make_shared<json::ObjectValue>(members);
};

std::shared_ptr<json::ArrayValue> json::Actions::CreateArrayValue(std::vector<std::shared_ptr<json::Value>> elements)
{
    return std::make_shared<json::ArrayValue>(elements);
};

std::shared_ptr<json::StringValue> json::Actions::CreateStringValue(std::string value)
{
    return std::make_shared<json::StringValue>(value);
};

std::shared_ptr<json::NumberValue> json::Actions::CreateNumberValue(std::string value)
{
    return std::make_shared<json::NumberValue>(std::stod(value));
};

std::shared_ptr<json::BooleanValue> json::Actions::CreateBooleanValue(bool value)
{
    return std::make_shared<json::BooleanValue>(value);
};

std::shared_ptr<json::NullValue> json::Actions::CreateNullValue()
{
    return std::make_shared<json::NullValue>();
}

json::Pair json::Actions::CreatePair(std::string key, std::shared_ptr<json::Value> value)
{
    Pair pair;
    pair.key = key;
    pair.value = value;
    return pair;
};