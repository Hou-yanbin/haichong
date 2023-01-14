@echo off
start cmd /k "activate train && cd %1 && python detect.py --weights %2 --source %3 --project %4 &&exit"
