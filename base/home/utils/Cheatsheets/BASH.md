# Scripting
## Options
    set -e = Exits on non-zero results within the script(functions, commands, etc.)
    set -u = Exits immediately when referencing a variable that doesn't exist
    set -o pipefail = Returns a non-zero code when one command in a pipeline fails(ie: grep word non-existent-file.txt | sort).
        The default behavior is to take the last command exit code as the result even if it doesn't make sense(The exemple successfully sorts an empty string)
    IFS=$'\n\t' = IFS(Internal Field Separator) controls the bash word splitting system. It's used by arguments, lists/arrays to separate items by something.
        The default is IFS=$' \n\t' or (space, newline, tab). The problem is the space that turn sentences into different items when not handled properly.
        ie: if you forget to add aspas when iterate thought args like (while arg in $@; do) instead of (while arg in "$@"; do). This much is doable but error prone

## Rules
- Use readonly for constants: readonly SCRIPT_DIR="..."
- Prefer local inside functions: local tmp="..."
- Use namespaces for functions: module::fun(){...}
- Always quote variables: "$@"
- Explicit returns: return 0 or return 1
- Never exit in sourced libs: return 1; return 0
- Validate files(-f): [[ -f "$FILE_PATH" ]] || { echo "Missing file"; return 1 }
- Validate dirs(-d): [[ -d "$DIR_PATH" ]] || { echo "Missing dir"; return 1 }
- Validate commands(-v): command -v git >/dev/null || { echo "git not installed"; exit 1 }
- Prefer parameters over global variables: do_something(){ local file_arg = "$1" }
- Use arrays for lists: FILES=("a b c")
- Do not override system variables: HOME, PATH, PWD, IFS, SHELL...
- When require arguments, instead of show error or advice using --help / -h => Show help/usage immediately

## Experiences
- Don't modularize. Your scripts aren't that big. You can repeat functions(create snippets) to keep scripts self sufficient
