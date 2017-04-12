#ifndef VALUES_HPP
#define VALUES_HPP 1

#include <iostream>
#include <memory>
#include <vector>
#include <string>
#include <sstream>

namespace json
{

enum ValueType {STRING, NUMBER, OBJECT, ARRAY, BOOLEAN, UNDEFINED};

struct Value
{
    Value(){};
    Value(ValueType t) : type(t){};
    ValueType type;
    virtual std::string ToString()
    {
        std::stringstream os;
        os << "";
        return os.str();
    }
};

struct StringValue : Value
{
    StringValue() : Value(ValueType::STRING), value(""){};
    StringValue(std::string s) : Value(ValueType::STRING), value(s){};
    std::string value;
    virtual std::string ToString()
    {
        std::stringstream os;
        os << "\"" << value << "\"";
        return os.str();
    }
};

struct NumberValue : Value
{
    NumberValue() : Value(ValueType::NUMBER), value(0){};
    NumberValue(double n) : Value(ValueType::NUMBER), value(n){};
    double value;
    virtual std::string ToString()
    {
        std::stringstream os;
        os << value;
        return os.str();
    }
};

struct ArrayValue : Value
{
    ArrayValue() : Value(ValueType::ARRAY), elements(){};
    ArrayValue(std::vector<std::shared_ptr<Value>> el) : Value(ValueType::ARRAY), elements(el){};
    std::vector<std::shared_ptr<Value>> elements;
    virtual std::string ToString()
    {
        std::stringstream os;
        os << "[ ";
        for(auto v : elements)
        {
            os << v->ToString() << (v != elements.back() ? ", " : "");
        }
        os << " ]";
        return os.str();
    }
};

struct BooleanValue : Value
{
    BooleanValue() : Value(ValueType::BOOLEAN), value(){};
    BooleanValue(bool b) : Value(ValueType::BOOLEAN), value(b){};
    bool value;
    virtual std::string ToString()
    {
        std::stringstream os;
        os << (value ? "true" : "false");
        return os.str();
    }
};

struct NullValue : Value
{
    NullValue() : Value(ValueType::UNDEFINED){};
    std::string ToString()
    {
        std::stringstream os;
        os << "null";
        return os.str();
    }
};

struct Pair
{
    std::string key;
    std::shared_ptr<Value> value;
    std::string ToString()
    {
        std::stringstream os;
        os << "\"" << key << "\" : " << value->ToString();
        return os.str();
    }
};

struct ObjectValue : Value
{
    ObjectValue() : Value(ValueType::OBJECT), members(){};
    ObjectValue(std::vector<Pair> m) : Value(ValueType::OBJECT), members(m){};
    std::vector<Pair> members;
    virtual std::string ToString()
    {
        std::stringstream os;
        os << "{\n";
        auto i = 0;
        for(auto p : members)
        {
            os << "  " << p.ToString() << (i < members.size() - 1 ? "," : "") << std::endl;
            i++;
        }
        os << "}";
        return os.str();
    }
};

}

#endif