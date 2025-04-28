# SDL Boilerplate Generator
A simple C boilerplate generator for SDL3. Creates a `main.c` file at a given directory. The `main.c`
file will contain code that creates a given name and size.

## Some notes
- The script enables 4 SDL modules by default: `audio`, `video`, `joystick`, and `events`. It should
  be trivial to add more after generation
- The script only adds one window flag to the generated window: `SDL_WINDOW_OPENGL`

## Todo
- Create a Makefile generator in a new Lua script

## Usage
- Ensure that you have Lua 5.2 or higher installed and added to your PATH. You can check if it is
  installed by running `lua -v` in a terminal. If you do not have Lua, you can install it with your
  package manager, from [here](https://www.lua.org/download.html) (source), or from 
  [here](https://luabinaries.sourceforge.net/) (prebuilt)
- After installing Lua, simply navigate to the folder where you cloned this repo, and run `lua sdl.lua`

## License
The SDL Boilerplate Generator is licensed under the MIT license.
