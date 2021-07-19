QT += core gui quick

TARGET = russiannationalanthem
TEMPLATE = app
CONFIG += warn_on c++11

DESTDIR = ../bin
MOC_DIR = ../build/moc
RCC_DIR = ../build/rcc
UI_DIR = ../build/ui
unix:OBJECTS_DIR = ../build/o/unix

DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += main.cpp \
    session.cpp \
    theme.cpp
    
RESOURCES += qml.qrc

HEADERS += \
    session.h \
    theme.h
