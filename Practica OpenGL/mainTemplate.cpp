#define GLEW_STATIC
#include <GL/glew.h>
#include <SFML/Window.hpp>

int main()
{

 //context settings object
 sf::ContextSettings settings;
 settings.depthBits = 24;
 settings.stencilBits = 8;
 settings.antialiasingLevel = 2;
 settings.majorVersion = 3;
 settings.minorVersion = 2;
 settings.attributeFlags = sf::ContextSettings::Core;

 //Window object instance
 sf::Window window(sf::VideoMode(800,600), "OpenGL", sf::Style::Close, settings);

 //GLEW settings and declarations
 glewExperimental = GL_TRUE;
 glewInit();
 GLuint vertexBuffer;
 glGenBuffers(1, &vertexBuffer);

 //simple print line from the code in line 24
 printf("%u\n", vertexBuffer);

 //main loop
 bool running = true;
 while (running)
 {
  sf::Event windowEvent;
  while (window.pollEvent(windowEvent))
  {
   switch (windowEvent.type)
   {
    //si click en cerrar ventana: cierra contexto
    case sf::Event::Closed:
     running = false;
     break;
    //si presiona el boton escape: cierra contexto
    case sf::Event::KeyPressed:
     if (windowEvent.key.code == sf::Keyboard::Escape)
      running = false;
     break;
   }
  }
 }

 return 0;
}
