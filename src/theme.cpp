#include "theme.h"

Theme::Theme(QObject *parent) : QObject(parent) {
    QIcon::setThemeName("fly-astra-mobile");
    palettePath = QDir::homePath() + "/.fly/paletterc";
    m_iconSize = 32;
    update();
    watcher.addPath(palettePath);
    QObject::connect(&watcher, &QFileSystemWatcher::fileChanged,
                     &handler, [=](){ update(); });
}

void couldNotOpenFileError() {
    QProcess process;
    QString command = "fly-dialog";
    command += " --title \"Государственный гимн Российской Федерации\"";
    command += " --error \"Не могу открыть файл ";
    command += QDir::homePath() + "/.fly/paletterc" + "\"";
    command += " --icon /usr/share/pixmaps/russiannationalanthem.png";
    process.execute(command);
    exit(EXIT_FAILURE);
}

void variableNotFoundError(QString colorStr) {
    QProcess process;
    QString command = "fly-dialog";
    command += " --title \"Государственный гимн Российской Федерации\"";
    command += " --error \"Не удалось найти переменную "
            + colorStr + " в файле ";
    command += QDir::homePath() + "/.fly/paletterc" + "\"";
    command += " --icon /usr/share/pixmaps/russiannationalanthem.png";
    process.execute(command);
    exit(EXIT_FAILURE);
}

bool Theme::isDark(QColor color) {
    return color.lightness() <= 167;
}

void Theme::update() {
    QRegularExpression primaryRegex("^PrimaryColor=(#[a-zA-Z0-9]+)$");
    QRegularExpression backgroundRegex("^BackgroundColor=(#[a-zA-Z0-9]+)$");
    QFile file(palettePath);
    if (!file.open(QIODevice::ReadOnly))
        couldNotOpenFileError();
    while (!file.atEnd()) {
        QByteArray line = file.readLine();
        QString lineStr = line;
        QRegularExpressionMatch match = primaryRegex.match(lineStr);
        if (match.hasMatch()){
            QString primaryColorStr = match.captured(1);
            QColor primaryColor(primaryColorStr);
            setPrimaryColor(primaryColor);
            QString foregroundColorStr = (isDark(primaryColor))
                    ? "white" : "black";
            QColor foregroundColor(foregroundColorStr);
            setForegroundColor(foregroundColor);
        }
        match = backgroundRegex.match(lineStr);
        if (match.hasMatch()){
            QString backgroundColorStr = match.captured(1);
            QColor backgroundColor(backgroundColorStr);
            setBackgroundColor(backgroundColor);
        }
    }
    if (Theme::primaryColor() == nullptr)
        variableNotFoundError("PrimaryColor");
    if (Theme::backgroundColor() == nullptr)
        variableNotFoundError("BackgroundColor");
    watcher.removePath(palettePath);
    watcher.addPath(palettePath);
}

QColor Theme::primaryColor() {
    return m_primaryColor;
}

void Theme::setPrimaryColor(QColor &color) {
    m_primaryColor = color;
    emit primaryColorChanged();
}

QColor Theme::backgroundColor() {
    return m_backgroundColor;
}

void Theme::setBackgroundColor(QColor &color) {
    m_backgroundColor = color;
    emit backgroundColorChanged();
}

QColor Theme::foregroundColor() {
    return m_foregroundColor;
}

void Theme::setForegroundColor(QColor &color) {
    m_foregroundColor = color;
    emit foregroundColorChanged();
}

qint8 Theme::iconSize() {
    return m_iconSize;
}

void Theme::setIconSize(qint8 &size) {
    m_iconSize = size;
    emit iconSizeChanged();
}
