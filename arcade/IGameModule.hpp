#include <vector>
#include <string>

#pragma once

struct GameObject {
    std::string sprite;
    int x, y;
};

class IGameModule
{
public:
    virtual ~IGameModule() = default;
    virtual void init() = 0;
    virtual void update() = 0;
    virtual std::vector<std::string> getRenderData() = 0;
    virtual void handleInput(int key) = 0;
};
