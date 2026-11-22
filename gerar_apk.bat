@echo off
chcp 65001 > nul
title CHECKPRO - Gerador Automatico de APK Android

echo ============================================================
echo   CHECKPRO - VERIFICACAO DE AMBIENTE E BUILD APK
echo ============================================================
echo.

set "WORK_DIR=%~dp0_apk_build"
set "WEB_DIR=%WORK_DIR%\www"

where node >nul 2>nul
if %errorlevel% neq 0 (
    echo [!] Node.js nao encontrado. Tentando instalar via winget...
    where winget >nul 2>nul
    if %errorlevel% equ 0 (
        winget install --id OpenJS.NodeJS.LTS -e --silent --accept-source-agreements --accept-package-agreements
        echo [i] Reinicie o terminal caso o PATH do Node.js ainda nao tenha atualizado.
    ) else (
        echo [ERRO] Winget nao disponivel. Instale o Node.js LTS em https://nodejs.org/
        pause
        exit /b 1
    )
) else (
    for /f "tokens=*" %%v in ('node -v') do echo [OK] Node.js detetado: %%v
)

where java >nul 2>nul
if %errorlevel% neq 0 (
    echo [!] Java JDK nao encontrado. Instalando Microsoft OpenJDK 17 via winget...
    where winget >nul 2>nul
    if %errorlevel% equ 0 (
        winget install --id Microsoft.OpenJDK.17 -e --silent --accept-source-agreements --accept-package-agreements
    ) else (
        echo [ERRO] Instale o JDK 17+ para compilar APKs Android.
        pause
        exit /b 1
    )
) else (
    echo [OK] Java detetado.
)

if not defined ANDROID_HOME (
    if exist "%LOCALAPPDATA%\Android\Sdk" (
        set "ANDROID_HOME=%LOCALAPPDATA%\Android\Sdk"
    )
)

if not defined ANDROID_HOME (
    echo [!] Android SDK nao detetado em ANDROID_HOME nem em %LOCALAPPDATA%\Android\Sdk.
    where winget >nul 2>nul
    if %errorlevel% equ 0 (
        echo [i] Instalando Android Studio via winget...
        winget install --id Google.AndroidStudio -e --silent --accept-source-agreements --accept-package-agreements
        echo [i] Abra o Android Studio uma vez para concluir o download do SDK e rode este script novamente.
        pause
        exit /b 1
    ) else (
        echo [ERRO] Configure o Android SDK e a variavel de ambiente ANDROID_HOME.
        pause
        exit /b 1
    )
) else (
    echo [OK] Android SDK em: "%ANDROID_HOME%"
)

echo.
echo [i] Preparando ficheiros web em "%WEB_DIR%"...
if not exist "%WEB_DIR%" mkdir "%WEB_DIR%"
copy /y "%~dp0index.html" "%WEB_DIR%\index.html" >nul
if exist "%~dp0MANUAL.md" copy /y "%~dp0MANUAL.md" "%WEB_DIR%\MANUAL.md" >nul

if not exist "%WORK_DIR%\package.json" (
    echo [i] Inicializando projeto Capacitor...
    pushd "%WORK_DIR%"
    npm init -y >nul
    npm install --no-audit --no-fund @capacitor/core @capacitor/cli @capacitor/android
    npx cap init "CheckPro Industrial" "com.checkpro.checklist" --web-dir="www"
    npx cap add android
    popd
) else (
    pushd "%WORK_DIR%"
    call npx cap sync android
    popd
)

if exist "%WORK_DIR%\android\gradlew.bat" (
    echo.
    echo [i] Compilando APK Android...
    pushd "%WORK_DIR%\android"
    call gradlew.bat assembleDebug
    set "GRADLE_STATUS=%errorlevel%"
    popd

    if %GRADLE_STATUS% equ 0 (
        set "APK_PATH=%WORK_DIR%\android\app\build\outputs\apk\debug\app-debug.apk"
        if exist "%APK_PATH%" (
            copy /y "%APK_PATH%" "%~dp0checkpro-checklist-debug.apk" >nul
            echo.
            echo ============================================================
            echo   SUCESSO! APK gerado em:
            echo   "%~dp0checkpro-checklist-debug.apk"
            echo ============================================================
        )
    ) else (
        echo [ERRO] Falha durante a compilacao Gradle. Verifique os logs acima.
    )
) else (
    echo [!] Pasta android nao encontrada. Execute o script novamente apos concluir o Android SDK.
)

pause