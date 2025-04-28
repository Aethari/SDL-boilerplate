--[[
Copyright 2025 DJaySky

Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
and associated documentation files (the “Software”), to deal in the Software without 
restriction, including without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom
the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or 
substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING 
BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]

local name, path, sdl_path
local size = {}

function interp(s, tab)
	return (s:gsub("($%b{})", function(w) return tab[w:sub(3, -2)] or w end))
end

:: beginning ::
print()
print("  SDL3 Boilerplate Generator v1.0.0")
print("By DJaySky (https://github.com/DJaySky)")
print("---------------------------------------")

-- name
io.write("Enter your app's name (window title): ")
name = io.read()

-- window size
io.write("\nEnter your app's window width: ")
size.w = io.read()

io.write("\nEnter your app's window height: ")
size.h = io.read()

-- filepath
io.write("\nEnter the path to the directory where you want the output file (main.c) to be located: ")
path = io.read()

-- sdl path
io.write("\nEnter the include statement for SDL:")
io.write("\nFor example in \"#include <SDL3/SDL.h>\" you would enter \"SDL3/SDL.h\"")
io.write("\nType here: ")
sdl_path = io.read()

-- confirmation
local conf_message = interp([[

Your current configuration:
	App name: "${app_name}"
	App window size: ${width} x ${height}
	Output file path: "${out_path}"
	SDL include statement: "${sdl_incpath}"
]], {
	app_name = name,
	width = size.w,
	height = size.h,
	out_path = path,
	sdl_incpath = sdl_path
})
io.write(conf_message)
io.write("\nIs this correct (y/n)? ")
local input = io.read()

if(input ~= "y") then
	io.write("\027[H\027[2J")
	goto beginning
end

-- create the output for the file
local out = interp([[
#include <stdio.h>

#include <${sdl_incpath}>
#include <${sdl_mainpath}>

int main() {
	SDL_Window *window;
	bool running = true;

	SDL_Init(
		SDL_INIT_AUDIO |
		SDL_INIT_VIDEO |
		SDL_INIT_JOYSTICK |
		SDL_INIT_EVENTS
	);

	window = SDL_CreateWindow(
		${win_title},
		${win_w},
		${win_h},
		SDL_WINDOW_OPENGL
	);
	SDL_Renderer *rend = SDL_CreateRenderer(window, NULL);

	while(running) {
		SDL_Event event;

		SDL_SetRenderDrawColorFloat(rend, 0, 0, 0, 1);
		SDL_RenderClear(rend);

		SDL_RenderPresent(rend);

		while(SDL_PollEvent(&event)) {
			if(event.type == SDL_EVENT_QUIT) {
				running = false;
			}
		}
	}
}
]], {
	sdl_incpath = sdl_path,
	sdl_mainpath = sdl_path:sub(-2).."main.h",
	win_title = title,
	win_w = size.w,
	win_h = size.h,
})

local file = assert(io.open(path.."/main.c", "w"))
file:write(out)
file:close()

print("\nOutput written to "..path.."/main.c\n")
os.exit()
