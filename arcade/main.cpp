#include "IGameModule.hpp"
#include "InputKey.hpp"
#include "IGraphicModule.hpp"
#include <iostream>
#include <dlfcn.h>

void run(IGameModule* game, IGraphicModule* graphics)
{
    game->init();
    graphics->init();

    while (true) {
        int key = graphics->getInput();
        if (key == -1) break;

        game->handleInput(key);
        game->update();

        auto objects = game->getRenderData();
        graphics->render(objects);
    }
}

void* loadLibrary(const std::string& path) {
    void* handle = dlopen(path.c_str(), RTLD_LAZY);
    if (!handle) {
        std::cerr << "Erreur lors du chargement de " << path << ": " << dlerror() << std::endl;
        exit(EXIT_FAILURE);
    }
    return handle;
}

template <typename T>
T* loadInstance(void* handle, const std::string& functionName) {
    using CreateFunc = T* (*)();
    CreateFunc createInstance = (CreateFunc) dlsym(handle, functionName.c_str());
    if (!createInstance) {
        std::cerr << "Erreur lors du chargement de la fonction " << functionName << ": " << dlerror() << std::endl;
        exit(EXIT_FAILURE);
    }
    return createInstance();
}

int main() {
    void* gameHandle = loadLibrary("./game2.so");
    IGameModule* game = loadInstance<IGameModule>(gameHandle, "createInstance");
    void* graphicHandle = loadLibrary("./libsfml.so");
    IGraphicModule* graphics = loadInstance<IGraphicModule>(graphicHandle, "createInstance");

    run(game, graphics);

    delete game;
    delete graphics;
    dlclose(gameHandle);
    dlclose(graphicHandle);
    return 0;
}