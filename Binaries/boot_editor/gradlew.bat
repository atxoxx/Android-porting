@IF EXIST tools\bin SET PATH=%PATH%;tools\bin
 @if "%1" == "check" exit 0
 @if "%1" == "clean" exit 0
 ..\java\bin\java.exe -jar bbootimg/bbootimg.jar %*
