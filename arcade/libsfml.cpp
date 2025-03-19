#include "IGraphicModule.hpp"
#include <SFML/Graphics.hpp>
#include "InputKey.hpp"
#include <vector>
#include <sstream>

class SFMLDisplay : public IGraphicModule {
private:
    sf::RenderWindow window;
    sf::Font font;

public:
    SFMLDisplay() : window(sf::VideoMode(800, 600), "SFML Arcade") {
        if (!font.loadFromFile("arial.ttf")) {
            throw std::runtime_error("Erreur: Impossible de charger la police");
        }
    }

    void init() override {
        window.clear();
    }

    void render(const std::vector<std::string>& objects) override {
        window.clear(sf::Color::Black);

        for (const std::string& obj : objects) {
            std::istringstream iss(obj);
            std::string sprite;
            int x, y;
            iss >> sprite >> x >> y;

            sf::Text text;
            text.setFont(font);
            text.setString(sprite);
            text.setCharacterSize(24);
            text.setFillColor(sf::Color::White);
            text.setPosition(x * 20, y * 20);

            window.draw(text);
        }

        window.display();
    }

    int getInput() override {
        sf::Event event;
        while (window.pollEvent(event)) {
            if (event.type == sf::Event::Closed)
                return EXIT_KEY;
            if (event.type == sf::Event::KeyPressed) {
                return event.key.code;
            }
        }
        return -1;
    }
};

extern "C" IGraphicModule* createInstance() {
    return new SFMLDisplay();
}
