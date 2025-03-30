# ConsoleAnimator - MATLAB Console Animation Tool

ConsoleAnimator is a MATLAB class that creates a simple console-based animation, displaying a loading animation in the terminal. It works by cycling through frames in a specified cell array, thus creating an animation in the console. The animation runs asynchronously using a timer, allowing your scripts to use it, while running at the same time, and the class provides methods to start and stop the animation as you need.

## Features
- **Asynchronous Animation**: The animation runs in the background while allowing other tasks to execute.
- **Timer-based Animation**: Uses MATLAB’s timer function to control animation intervals.
- **Customizable Frames**: You can pass a list of frames (e.g., loading dots, characters) to display as the animation.
- **Stop and Reset**: You can stop the animation at any time, (e.g. after loading is complete for your own scripts).

## Installation
Clone this repository to your local machine:

```bash
git clone https://github.com/developer-cunningham/matlab-console-animator.git
```
