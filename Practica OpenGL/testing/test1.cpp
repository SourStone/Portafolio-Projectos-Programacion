#define GLEW_STATIC
#include <GL/glew.h>
#include <SFML/Window.hpp>

int main()
{
 sf::ContextSettings settings;
 settings.depthBits = 24;
 settings.stencilBits = 8;
 settings.antialiasingLevel = 2;
 settings.majorVersion = 3;
 settings.minorVersion = 2;
 settings.attributeFlags = sf::ContextSettings::Core;

 sf::Window window(sf::VideoMode(800,600), "OpenGL", sf::Style::Close, settings);
 glewExperimental = GL_TRUE;
 glewInit();
 GLuint vertexBuffer;
 glGenBuffers(1, &vertexBuffer);

 printf("%u\n", vertexBuffer);

 bool running = true;
 while (running)
 {
  sf::Event windowEvent;
  while (window.pollEvent(windowEvent))
  {
   switch (windowEvent.type)
   {
    case sf::Event::Closed:
     running = false;
     break;
    case sf::Event::KeyPressed:
     if (windowEvent.key.code == sf::Keyboard::Escape)
      running = false;
     break;
   }
  }
 }

 return 0;
}
