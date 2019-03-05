#include <iostream>
#include <sstream>
#include <string>

#include <fstream>
#include "Logger.hpp"
#include "ConsoleColor.hpp"
int main()
{
    Logger::Log("Fehler",Logger::Error);
    Logger::Log("Warnung",Logger::Warning);
    Logger::Log("Information",Logger::Information);
    Logger::Register(Color::Compatibility::Text::LightGray + "[ " + Color::Formatting::Bold + Color::Compatibility::Text::Magenta +  "Network " + Color::Formatting::ResetDim + Color::Compatibility::Text::LightGray + "] " + Color::Compatibility::Text::Magenta,3);
    Logger::Log("Network Problem",3);
    return 0;
}

