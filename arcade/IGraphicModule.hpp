#include "IGameModule.hpp"
#include <vector>
#include <string>

#pragma once

class IGraphicModule
{
public:
    virtual ~IGraphicModule() = default;
    virtual void init() = 0;
    virtual void render(const std::vector<std::string>& objects) = 0;
    virtual int getInput() = 0;
};
