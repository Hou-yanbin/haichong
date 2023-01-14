@echo off
start cmd /k "activate train && cd %1 && python detect.py --weights %2"
