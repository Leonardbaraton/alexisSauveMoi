#include "IGameModule.hpp"
#include <vector>
#include <iostream>
#include <string>

class PongGame : public IGameModule {
private:
    int playerY;
    int ballX, ballY;
    int ballDirX, ballDirY;

public:
    PongGame() : playerY(10), ballX(20), ballY(10), ballDirX(1), ballDirY(1) {}

    void init() override {
        std::cout << "PongGame initialisé !" << std::endl;
    }

    void handleInput(int key) override {
        if (key == 'w') playerY--;
        if (key == 's') playerY++;
    }

    void update() override {
        ballX += ballDirX;
        ballY += ballDirY;
        if (ballY <= 0 || ballY >= 20) ballDirY *= -1;
        if (ballX <= 0 || ballX >= 40) ballDirX *= -1;
        if (ballX == 2 && ballY == playerY) ballDirX *= -1;
    }

    std::vector<std::string> getRenderData() override {
        std::vector<std::string> objects;
        objects.push_back("| " + std::to_string(2) + " " + std::to_string(playerY));
        objects.push_back("O " + std::to_string(ballX) + " " + std::to_string(ballY));
        return objects;
    }
};

    extern "C" IGameModule* createInstance() {
    return new PongGame();
}
