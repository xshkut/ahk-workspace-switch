# Install

1. Download [AutoHotKey](https://www.autohotkey.com)
2. Run (or compile) `workspace-ctl.ahk`

# How to use

- Previous workspace: `MouseButton4`, `Numpad0`
- Next workspace: `MouseButton5`, `NumpadEnter`
- Show desktop: `NumpadDel` (`.`)
- Go to `X` desktop: `Numpad_X`, where `X` belongs to `[1, 9]`

The application uses internal state to track current workspace cursor, because there is no Windows API for that. If workspace was switched with native Windows hotkeys or by Windows directly, use `Shift+X` to go calibrate the workspace (needed only once). This will open the desired workspace and synchronize the app's state with it.
