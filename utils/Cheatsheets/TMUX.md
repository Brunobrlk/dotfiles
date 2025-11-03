# Notation
    ^ = CTRL
    MASTER = ^ + s
    Prompt = MASTER + :

# Screen Split
    MASTER + - = Horizontal Split
    MASTER + | = Vertical Split

# Managing Panes
    MASTER + AnyArrowKey = Move to another pane
    MASTER(Keep Pressing) + AnyArrowKey = Adjust Pane Size
    MASTER + { or } = Change current pane position 
    MASTER + SPACE = Rearange panes to different layouts
    MASTER + q then [Pane Number]
    MASTER + z = Enter zen mode

# Nav/Manage Windows
    MASTER + ! = Turn the current pane into a new window 
    MASTER + c = Nova janela(Listadas na parte inferior)
    MASTER + n(next) = Janela a direita
    MASTER + p(previous) = Janela a esquerda
    MASTER + [NUMERO] = Janela referente ao numero
    MASTER + , = Renomear janela atual
    exit = Closes the window

--- Managing Sessions - Permanecem mesmo após reiniciar o sistema
# Start a new session without a name(Can rename afterwards)
tmux
# Start a new session with a name
tmux new -s [session_name] 

# Persiste a sessão e para quando voltar permanecer no mesmo estado
MASTER + d(detach) 
# Lista todas as sessões existentes
tmux ls 
# Retorna a ultima sessão do estado que parou
tmux a 
# Retorna a sessão <name> do estado que parou
tmux a(attach) -t <name> 
tmux rename-session -t [target_session_name] [new_session_name]

# Switch between sessions without leaving tmux. Opens a tab with your sessions
MASTER + s 

# Opens a tab with your sessions and windows within each session
MASTER + w 
