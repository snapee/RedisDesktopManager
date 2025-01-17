
# Python
win32* {
    QMAKE_LIBS += -LC:\Python37-x64\libs -lpython37
    INCLUDEPATH += C:\Python37-x64\include\
} else {
    unix:macx {
      exists($$PWD/python-3/bin/python3-config) {
        PYTHON_CONFIG = $$PWD/python-3/bin/python3-config
      } else {
       PYTHON_CONFIG = /usr/local/bin/python3-config
      }
    } else {
      PYTHON_CONFIG = python3-config
    }
    QMAKE_LIBS += $$system($$PYTHON_CONFIG --ldflags --libs)
    QMAKE_CXXFLAGS += $$system($$PYTHON_CONFIG --includes)
}

include(pyotherside/pyotherside.pri)

DEFINES += PYOTHERSIDE_VERSION=\\\"$${VERSION}\\\"

DEPENDPATH += $$PWD/pyotherside/src
INCLUDEPATH += $$PWD/pyotherside/src

PYOTHERSIDE_DIR = $$PWD/pyotherside/src/

# QML Image Provider
SOURCES += $$PYOTHERSIDE_DIR/qpython_imageprovider.cpp
HEADERS += $$PYOTHERSIDE_DIR/qpython_imageprovider.h

# Importer from Qt Resources
RESOURCES += $$PYOTHERSIDE_DIR/qrc_importer.qrc

# Embedded Python Library (add pythonlib.zip if you want this)
exists ($$PYOTHERSIDE_DIR/pythonlib.zip) {
    message("Using Embedded Python Lib")
    RESOURCES += $$PYOTHERSIDE_DIR/pythonlib_loader.qrc
    DEFINES *= PYTHONLIB_LOADER_HAVE_PYTHONLIB_ZIP
}

!windows {
    DEFINES *= HAVE_DLADDR
}

HEADERS += $$PYOTHERSIDE_DIR/pythonlib_loader.h\
    $$PWD/pyotherside/src/callback.h
SOURCES += $$PYOTHERSIDE_DIR/pythonlib_loader.cpp

# Python QML Object
SOURCES += $$PYOTHERSIDE_DIR/qpython.cpp
HEADERS += $$PYOTHERSIDE_DIR/qpython.h
SOURCES += $$PYOTHERSIDE_DIR/qpython_worker.cpp
HEADERS += $$PYOTHERSIDE_DIR/qpython_worker.h
SOURCES += $$PYOTHERSIDE_DIR/qpython_priv.cpp
HEADERS += $$PYOTHERSIDE_DIR/qpython_priv.h
HEADERS += $$PYOTHERSIDE_DIR/python_wrap.h

# Globally Load Python hack
SOURCES += $$PYOTHERSIDE_DIR/global_libpython_loader.cpp
HEADERS += $$PYOTHERSIDE_DIR/global_libpython_loader.h

# Reference-counting PyObject wrapper class
SOURCES += $$PYOTHERSIDE_DIR/pyobject_ref.cpp
HEADERS += $$PYOTHERSIDE_DIR/pyobject_ref.h

# QObject wrapper class exposed to Python
SOURCES += $$PYOTHERSIDE_DIR/qobject_ref.cpp
HEADERS += $$PYOTHERSIDE_DIR/qobject_ref.h
HEADERS += $$PYOTHERSIDE_DIR/pyqobject.h

# GIL helper
HEADERS += $$PYOTHERSIDE_DIR/ensure_gil_state.h

# Type System Conversion Logic
HEADERS += $$PYOTHERSIDE_DIR/converter.h
HEADERS += $$PYOTHERSIDE_DIR/qvariant_converter.h
HEADERS += $$PYOTHERSIDE_DIR/pyobject_converter.h
HEADERS += $$PYOTHERSIDE_DIR/qml_python_bridge.h

