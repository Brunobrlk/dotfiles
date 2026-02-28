# Managing Sessions - Permanecem mesmo após reiniciar o sistema

## Start a new session without a name(Can rename afterwards)
tmux

## Start a new session with a name
tmux new -s [session_name] 

## Persiste a sessão e para quando voltar permanecer no mesmo estado
MASTER + d(detach) 

## Lista todas as sessões existentes
tmux ls 

## Retorna a ultima sessão do estado que parou
tmux a 

## Retorna a sessão <name> do estado que parou
tmux a(attach) -t <name> 
tmux rename-session -t [target_session_name] [new_session_name]
