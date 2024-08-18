# Advanced Computer Monitoring System

## Project Overview
This project is a Lua script designed to run on an advanced computer within Minecraft, using the CC: Tweaked mod along with the Advanced Peripherals mod. The system utilizes an advanced monitor to display real-time information including:

- **Current Time**: Displays the current in-game time.
- **Weather Conditions**: Shows weather details such as rain, thunderstorms, and clear skies.
- **Radiation Levels**: Monitors environmental radiation levels, color-coded based on severity.
- **RSS Feed**: Displays random news headlines from a predefined RSS feed.

The system allows users to switch between different display modes by touching the monitor, rotating through time, weather, and radiation readings.

## Requirements
To run this project, you need the following:
1. **CC: Tweaked Mod**: A Minecraft mod that extends the capabilities of the ComputerCraft mod.
2. **Advanced Peripherals Mod**: A mod that provides additional peripherals, like the `environmentDetector`, used in this project.

Items required:
1. **Advanced Computer**: A computer with advanced capabilities to run the Lua script.
2. **Advanced Monitor**: A monitor to display the real-time information.
3. **Environment Detector Peripheral**: A peripheral that detects environmental data like time, weather, and radiation.

## Installation
1. Ensure you have the required mods installed in your Minecraft instance.
2. Set up an advanced computer and advanced monitor, ensuring they are connected properly.
3. Attach the `environmentDetector` peripheral to your computer.
4. Copy and paste the Lua script into the advanced computer's editor.
5. Run the script and interact with the monitor to toggle between different displays.

## Script Breakdown
- **Event Handling**: The script listens for `monitor_touch` events to switch between time, weather, and radiation displays.
- **Display Logic**: Depending on the selected display mode, the script shows time, weather, or radiation data in the center of the monitor.
- **RSS Feed Integration**: The script fetches headlines from a specified RSS feed and displays them at the bottom of the monitor.

## Future Enhancements
- **Additional Displays**: More data types could be added, such as in-game player locations or system status updates.
- **Customization**: Allowing user customization of RSS feeds or display themes could enhance the system’s flexibility.

This setup creates a highly interactive and informative monitoring system for your Minecraft world, perfect for players who want to keep track of multiple environmental factors at a glance.
