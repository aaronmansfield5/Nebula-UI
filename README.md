![image](https://github.com/user-attachments/assets/04a4a09c-23ad-4638-9740-46c2f46b29f1)

### **Overview**

The **Nebula UI Library** is a highly customizable and modular Roblox interface library designed to create dynamic and feature-rich user interfaces (UIs) for Roblox games. It provides a set of powerful tools to developers, enabling them to efficiently design UIs with built-in functionality such as toggles, sliders, text inputs, and dropdowns. This library focuses on flexibility, ease of integration, and compatibility with various platforms (Mobile and PC).

---

### **Features**
- **Platform Detection**: Automatically adjusts UI layout depending on whether the user is on mobile or PC.
- **Dynamic Sections**: The library allows the creation of custom sections and UI elements like sliders, toggles, and text inputs.
- **User Profile Integration**: Displays the player's avatar and information with gradients and customizable player frames.
- **UI Tweens**: Uses `TweenService` to create smooth transitions and interactions.
- **Responsive Design**: Automatically adjusts the layout to fit different screen sizes and resolutions.

![image](https://github.com/user-attachments/assets/2f7599a1-9645-4a19-b6aa-74b2a736f55c)

---

### **Installation and Setup**

To start using Nebula UI, you need to ensure you have a valid Roblox executor like **Solara**, **Wave**, or **Synapse Z**. Simply load the library by running the following command in your executor:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/aaronmansfield5/Nebula-UI/master/lib.lua"))()
```

### **Initialization**

To initialize the Nebula UI Library in your game, you will need to pass in customization options such as `ImageId` and `PrimaryColour`. Here is an example script to get started:

```lua
local Nebula = loadstring(game:HttpGet("https://raw.githubusercontent.com/aaronmansfield5/Nebula-UI/master/lib.lua"))()

Nebula.init({
    ImageId = "12345678",  -- The asset ID for the top image/logo
    PrimaryColour = "#3498db"  -- Hex color for UI accents
})
```

### **Creating Sections**

You can create different sections in your UI, which can hold various controls like toggles, sliders, and inputs. Below is an example of how to create a section with a text input, toggle, and slider:

```lua
local section = Nebula.addSection("Settings")

-- Add a Text Input
section.addTextInput("Username", "Enter your name", function(input)
    print("User input: " .. input)
end)

-- Add a Toggle
section.addToggle("Enable Feature", false, function(isEnabled)
    print("Feature Enabled: " .. tostring(isEnabled))
end)

-- Add a Slider
section.addSlider("Volume", 0, 100, 50, function(value)
    print("Volume set to: " .. value)
end)
```

### **Customization Options**

When initializing Nebula UI, you can pass different options to customize the look and feel of your UI. For example, the color scheme, images, and layout can be controlled via arguments:

```lua
Nebula.init({
    ImageId = "987654321",  -- Custom image for sidebar
    PrimaryColour = "#ff6347"  -- Custom primary color
})
```

---

### **Available Methods**

- **addSection**: Create a new section for grouping controls.
- **addTextInput**: Adds a text input field.
- **addToggle**: Adds a toggle switch.
- **addSlider**: Adds a slider to the section.
- **addParagraph**: Adds a paragraph of text to the UI.
- **addDropdownSection**: Adds a dropdown menu to the UI.

### **Mobile and PC Compatibility**

The library automatically detects the platform using `UserInputService`, and adjusts the UI layout accordingly. This ensures a seamless experience for both mobile and PC users, with optimized touch support for mobile devices.

### **Next Steps**

1. **Add More Components**: Continue to expand the library with additional UI elements such as buttons, dropdowns, and more advanced features like tabs or collapsible sections.

2. **Mobile Optimization**: Ensure that all UI components work seamlessly across various mobile screen sizes, enhancing the user experience for mobile players.

3. **Themes and Customization**: Implement additional customization options, allowing users to easily switch between predefined themes or create their own using custom colors and fonts.

4. **Community Contribution**: Open the project for community contributions by providing a clear contributing guide and issue templates to help others collaborate on improving the library.

5. **Documentation and Examples**: Expand on the existing documentation by adding detailed usage examples for each feature. This will help other developers implement the library more effectively.

6. **Performance Optimization**: Optimize the library to ensure that it remains lightweight and fast, even in larger projects or games with complex UIs.

7. **Executor-Specific Features**: Introduce features or optimizations that leverage the strengths of popular executors like Solara, Wave, and Synapse X to enhance functionality further.

### **Conclusion**

The Nebula UI Library offers a robust solution for creating modern and interactive user interfaces within Roblox. With its built-in platform detection, customizable sections, and controls, it enables developers to quickly implement dynamic UIs in their games. The library is compatible with major Roblox executors, making it a flexible tool for many use cases.

For further customizations or contributions, feel free to visit the [GitHub repository](https://github.com/aaronmansfield5/Nebula-UI).
