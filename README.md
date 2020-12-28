# Autohotkey Workspace Switch

## Install

1. Download and install [AutoHotKey](https://www.autohotkey.com)
2. Create 9 workspaces (`Ctrl+D` to create one) or change the constant in `workspace-ctl.ahk` to necessary number (<=9)
3. Download, then run (or compile) `workspace-ctl.ahk` with AutoHotKey (via right mouse click on the file)
4. For better visual experience, disable system animations

## How to use

- Move to Previous workspace: `MouseButton4`, `Numpad0`
- Move to Next workspace: `MouseButton5`, `NumpadEnter`
- Show desktop: `NumpadDel` (`.`)
- Go to `X`'th desktop: `Numpad_X`, where `X` belongs to `[1, 9]`

The application uses its internal state to track current workspace index since there is no any system API for that. If workspace has been switched with native Windows hotkeys or by Windows directly, the state could loose the actual workspace index. Use `Shift+X` to get to needed workspace and calibrate the state. This will open the desired workspace and synchronize the app's state with it.

## Under the hood

In essential, the application just sends `Ctrl + Win + Arrow` keys combination to switch workspaces. To jump from `N`'th to `N+j`'th workspace it performs `j` hotkey commands with one millisecind time interval to ensure commands are processed one-by-one. Normally, if `[j] > 1`, this will not work, because Windows needs certain amount of time to perform renderings for desktop transitions, which takes 20-100 ms, depending on hardware capabilities and system performance plan. To overcome this, the app creates black fullscreen window (the color constant can be changed) while the transitions is going to avoid unncecessary panel and desktop renderings.
