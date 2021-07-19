#ifndef THEME_H
#define THEME_H

#include <QObject>
#include <QObject>
#include <QDir>
#include <QString>
#include <QFile>
#include <QIcon>
#include <QRegularExpression>
#include <QColor>
#include <QFileSystemWatcher>
#include <QGuiApplication>
#include <QProcess>

class Theme : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QColor primaryColor READ primaryColor
               WRITE setPrimaryColor NOTIFY primaryColorChanged)
    Q_PROPERTY(QColor backgroundColor READ backgroundColor
               WRITE setBackgroundColor NOTIFY backgroundColorChanged)
    Q_PROPERTY(QColor foregroundColor READ foregroundColor
               WRITE setForegroundColor NOTIFY foregroundColorChanged)
    Q_PROPERTY(qint8 iconSize READ iconSize
               WRITE setIconSize NOTIFY iconSizeChanged)
public:
    explicit Theme(QObject *parent = nullptr);
    void update();
    Q_INVOKABLE bool isDark(QColor);
    Q_INVOKABLE QColor primaryColor();
    Q_INVOKABLE void setPrimaryColor(QColor &);
    Q_INVOKABLE QColor backgroundColor();
    Q_INVOKABLE void setBackgroundColor(QColor &);
    Q_INVOKABLE QColor foregroundColor();
    Q_INVOKABLE void setForegroundColor(QColor &);
    Q_INVOKABLE qint8 iconSize();
    Q_INVOKABLE void setIconSize(qint8 &);
signals:
    void primaryColorChanged();
    void backgroundColorChanged();
    void foregroundColorChanged();
    void iconSizeChanged();
private:
    QFileSystemWatcher watcher;
    QObject handler;
    QString palettePath;
    QColor m_primaryColor;
    QColor m_backgroundColor;
    QColor m_foregroundColor;
    qint8 m_iconSize;
};

#endif // THEME_H
