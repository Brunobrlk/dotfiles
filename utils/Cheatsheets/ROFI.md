# Shortcuts
    C-<Tab> = Switch mode
    C+S-<Tab> = Reverse switch mode

# Commands
## Run rofi in a certain mode
    rofi -show <mode>

## Get options from a script
    ~/script_path.sh | rofi -dmenu

## Ordered list of modes to enable(enabled modes can be changed at runtime) + start with run mode
    rofi -modes "run,ssh,filebrowser" -show run
