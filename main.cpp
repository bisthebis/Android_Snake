/*
MIT License

Copyright (c) 2017 Boris Martin

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtGlobal>
#include <QTime>
#include <QDebug>
#include <QMap>
#include <QTextStream>
#include <QQmlContext>
#include "gamegrid.h"
#include "gamedata.h"
#include "filereader.h"


int main(int argc, char *argv[])
{
    qsrand(QTime::currentTime().msec());
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<FileReader>("be.martin.boris", 1, 0, "FileReader");
    qmlRegisterType<GameGrid>("be.martin.boris", 1, 0, "GameGrid");
    qmlRegisterType<GameData>("be.martin.boris", 1, 0, "GameData");

    //Register data
    GameData data;
    engine.rootContext()->setContextProperty("game_data", &data);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
