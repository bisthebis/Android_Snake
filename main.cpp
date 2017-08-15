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
#include "gamegrid.h"

static QTextStream out(stdout);

void printGrid(const GameGrid& grid) {
    static QMap<GameGrid::CELL_STATE, QChar> symbols;

    symbols[GameGrid::EMPTY] = '0';
    symbols[GameGrid::FOOD] = '#';
    symbols[GameGrid::SNAKE] = '=';

    for (quint32 y = 0; y < grid.height; ++y) {
        for (quint32 x = 0; x < grid.width; ++x) {
            out << symbols[grid.at(x, y)] << ' ';
        }
        out << endl;
    }
}

int main(int argc, char *argv[])
{
    qsrand(QTime::currentTime().msec());
    QGuiApplication app(argc, argv);

    GameGrid grid;
    grid.addFood();
    printGrid(grid);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
