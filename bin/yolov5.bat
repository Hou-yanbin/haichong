@echo off
start cmd /k "activate pytorch && cd %1 &&python detect.py --weights %2 --source %3 --project %4 --conf-thres %5 --img-size %6 "
