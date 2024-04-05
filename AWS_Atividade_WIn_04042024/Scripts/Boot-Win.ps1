<powershell>
Write-Output "Baixando o instalador do Google Chrome..."
Invoke-WebRequest -Uri 'https://dl.google.com/chrome/install/latest/chrome_installer.exe' -OutFile "$TEMP_DIR\chrome_installer.exe"

Write-Output "Instalando o Google Chrome..."
Start-Process -FilePath "$TEMP_DIR\chrome_installer.exe" -ArgumentList "/silent", "/install" -Wait

Remove-Item -Path "$TEMP_DIR\chrome_installer.exe" -Force

Write-Output "Baixando o instalador do Visual Studio Code..."
Invoke-WebRequest -Uri 'https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user' -OutFile "$TEMP_DIR\vscode_installer.exe"

Write-Output "Instalando o Visual Studio Code..."
Start-Process -FilePath "$TEMP_DIR\vscode_installer.exe" -ArgumentList "/silent", "/install" -Wait

Write-Output "Instalacao concluida."
</powershell>