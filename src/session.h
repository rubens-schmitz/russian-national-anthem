#ifndef SESSION_H
#define SESSION_H

#include <QObject>
#include <QSettings>

class Session : public QObject
{
    Q_OBJECT
public:
    explicit Session(QObject *parent = nullptr);
    Q_INVOKABLE QString value(QString key);
    Q_INVOKABLE void setValue(QString key, QString value);
private:
    QSettings settings;
};

#endif // SESSION_H
