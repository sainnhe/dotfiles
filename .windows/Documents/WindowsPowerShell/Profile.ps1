Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Avit
Import-Module PSReadLine
Import-Module PSFzf -ArgumentList 'Ctrl+t','Ctrl+r'
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineOption -ShowToolTips
