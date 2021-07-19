#include "session.h"

Session::Session(QObject *parent) : QObject(parent) {}

QString Session::value(QString key) {
    QString value = settings.value(key).toString();
    return value;
}

void Session::setValue(QString key, QString value) {
    settings.setValue(key, value);
}
